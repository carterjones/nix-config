package main

import (
	"os"
	"os/exec"
	"regexp"
	"strings"
)

// OSFlag contains a bunch of flags that indicate if this is running on a
// particular OS.
type OSFlag struct {
	IsCentos  bool
	IsMac     bool
	IsManjaro bool
	IsUbuntu  bool
}

// IsLinux returns true if the flags indicate it is a Linux operating system.
func (of OSFlag) IsLinux() bool {
	return of.IsCentos || of.IsManjaro || of.IsUbuntu
}

// OSString returns a short string representing the type of operating system
// associated with the flag.
func (of OSFlag) OSString() string {
	var s string
	switch {
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

func fileExists(path string) bool {
	fi, err := os.Stat(path)
	if err != nil {
		return false
	}
	return !fi.IsDir()
}

func fileContains(str, filepath string) bool {
	b, err := os.ReadFile(filepath)
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
	switch {
	case fileExists("/etc/manjaro-release"):
		of.IsManjaro = true
	case fileExists("/etc/centos-release"):
		of.IsCentos = true
	case fileContains("Ubuntu", "/etc/lsb-release"):
		of.IsUbuntu = true
	case strings.Contains(getUnameOutput(), "Darwin"):
		of.IsMac = true
	default:
		panic("no OS was identified. this is required to proceed.")
	}
	return of
}
