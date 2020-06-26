package main

import (
	"io/ioutil"
	"os"
	"os/exec"
	"regexp"
	"strings"
)

// OSFlag contains a bunch of flags that indicate if this is running on a
// particular OS.
type OSFlag struct {
	IsArch    bool
	IsCentos  bool
	IsMac     bool
	IsManjaro bool
	IsUbuntu  bool
}

// IsLinux returns true if the flags indicate it is a Linux operating system.
func (of OSFlag) IsLinux() bool {
	return of.IsArch || of.IsCentos || of.IsManjaro || of.IsUbuntu
}

// OSString returns a short string representing the type of operating system
// associated with the flag.
func (of OSFlag) OSString() string {
	var s string
	switch {
	case of.IsArch:
		s = "arch"
	case of.IsCentos:
		s = "centos"
	case of.IsMac:
		s = "mac"
	case of.IsManjaro:
		s = "manjaro"
	case of.IsUbuntu:
		s = "ubuntu"
	default:
		s = "<undefined os>"
	}
	return s
}

func isFile(name string) (bool, error) {
	fi, err := os.Stat(name)
	if err != nil {
		return false, err
	}
	return !fi.IsDir(), nil
}

func fileContains(str, filepath string) bool {
	b, err := ioutil.ReadFile(filepath)
	if err != nil {
		return false
	}

	ok, err := regexp.Match(str, b)
	if err != nil {
		return false
	}
	return ok
}

func getUnameOutput() string {
	out, err := exec.Command("uname").Output()
	if err != nil {
		// Fail hard. `uname` should always work.
		panic(err)
	}
	return string(out)
}

func generateOSFlag() OSFlag {
	of := OSFlag{}
	if ok, _ := isFile("/etc/manjaro-release"); ok {
		of.IsManjaro = true
	} else if ok, _ := isFile("/etc/arch-release"); ok {
		of.IsArch = true
	} else if ok, _ := isFile("/etc/centos-release"); ok {
		of.IsCentos = true
	} else if fileContains("Ubuntu", "/etc/lsb-release") {
		of.IsUbuntu = true
	} else if strings.Contains(getUnameOutput(), "Darwin") {
		of.IsMac = true
	}
	return of
}
