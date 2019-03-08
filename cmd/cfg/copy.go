package main

import (
	"fmt"
	"html/template"
	"io/ioutil"
	"os"
	"path/filepath"
	"strings"
)

func copyDir(src, dst string, of OSFlag) error {
	// Add a '/' suffix to the directory string.
	if !strings.HasSuffix(src, "/") {
		src = src + "/"
	}
	if !strings.HasSuffix(dst, "/") {
		dst = dst + "/"
	}

	return filepath.Walk(src, func(p string, info os.FileInfo, err error) error {
		newPath := strings.Replace(p, src, "", -1)
		newDst := dst + newPath
		ok, err := isDir(p)
		if err != nil {
			return err
		}
		if ok {
			return nil
		}
		return copy(p, newDst, of)
	})
}

func copy(src, dst string, of OSFlag) error {
	// Handle directories.
	ok, err := isDir(src)
	if err != nil {
		return err
	}
	if ok {
		return copyDir(src, dst, of)
	}

	data, err := ioutil.ReadFile(src)
	if err != nil {
		return err
	}

	dstDir := filepath.Dir(dst)
	ok, err = isDir(dstDir)
	if err != nil || !ok {
		err = os.MkdirAll(dstDir, os.ModePerm)
		if err != nil {
			return err
		}
	}

	dstF, err := os.Create(dst)
	if err != nil {
		return err
	}

	// Create a new template and parse the letter into it.
	t := template.Must(template.New("file").Parse(string(data)))
	err = t.Execute(dstF, of)
	if err != nil {
		return err
	}

	fmt.Println("copy:", src, "->", dst)

	return nil
}
