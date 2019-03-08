package main

import (
	"os"
	"os/exec"
	"path"
	"path/filepath"
)

func cnfTemplate(s ...string) string {
	templateDir := "templates"
	elems := append([]string{templateDir}, s...)
	return path.Join(elems...)
}

func home(s ...string) string {
	elems := append([]string{os.Getenv("HOME")}, s...)
	return path.Join(elems...)
}

func bash(p string) error {
	cmd := exec.Command("/bin/bash", filepath.Base(p))
	cmd.Dir = filepath.Dir(p)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	err := cmd.Run()
	if err != nil {
		return err
	}
	return nil
}

func isDir(name string) (bool, error) {
	fi, err := os.Stat(name)
	if err != nil {
		return false, err
	}
	return fi.IsDir(), nil
}
