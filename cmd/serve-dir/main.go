package main

import (
	"fmt"
	"net"
	"net/http"
	"os"
	"strings"
)

func main() {
	// Find local IP address that starts with "192."
	ip, err := find192IP()
	if err != nil {
		fmt.Println("Error finding IP:", err)
		os.Exit(1)
	}

	// Serve files from current working directory
	dir, err := os.Getwd()
	if err != nil {
		fmt.Println("Error getting current directory:", err)
		os.Exit(1)
	}

	fs := http.FileServer(http.Dir(dir))
	http.Handle("/", fs)

	port := "8080"
	address := ip + ":" + port
	fmt.Printf("Serving %s over HTTP at http://%s/\n", dir, address)

	err = http.ListenAndServe(address, nil)
	if err != nil {
		fmt.Println("HTTP server error:", err)
	}
}

// find192IP searches for a network interface with an IP starting with 192.
func find192IP() (string, error) {
	ifaces, err := net.Interfaces()
	if err != nil {
		return "", err
	}

	for _, iface := range ifaces {
		if iface.Flags&net.FlagUp == 0 {
			continue // interface down
		}
		addrs, err := iface.Addrs()
		if err != nil {
			continue
		}
		for _, addr := range addrs {
			var ip net.IP
			switch v := addr.(type) {
			case *net.IPNet:
				ip = v.IP
			case *net.IPAddr:
				ip = v.IP
			}
			if ip == nil || ip.IsLoopback() {
				continue
			}
			ip = ip.To4()
			if ip == nil {
				continue // not an IPv4 address
			}
			if strings.HasPrefix(ip.String(), "192.") {
				return ip.String(), nil
			}
		}
	}
	return "", fmt.Errorf("no IP address starting with 192. found")
}
