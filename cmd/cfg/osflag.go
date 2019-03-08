package main

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
