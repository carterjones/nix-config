package main

import (
	"io/ioutil"
	"os"
	"path/filepath"
	"strings"
	"text/template"
)

func isDir(name string) (bool, error) {
	fi, err := os.Stat(name)
	if err != nil {
		return false, err
	}
	return fi.IsDir(), nil
}

// Generate a walk function used to copy files.
func generateWalkFunc(src, dst string, of OSFlag) filepath.WalkFunc {
	return func(p string, info os.FileInfo, err error) error {
		if err != nil {
			return nil
		}
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
	}
}

// Recursively copy the source directory to the destination directory.
func copyDir(src, dst string, of OSFlag) error {
	// Add a '/' suffix to the directory string.
	if !strings.HasSuffix(src, "/") {
		src = src + "/"
	}
	if !strings.HasSuffix(dst, "/") {
		dst = dst + "/"
	}

	return filepath.Walk(src, generateWalkFunc(src, dst, of))
}

// Copy the file mode and data of a source file to a destination file.
func copyFile(src, dst string, of OSFlag) error {
	data, err := ioutil.ReadFile(src)
	if err != nil {
		return err
	}

	// Prepare the destination file and/or directory.
	if err = ensureDstDirExists(dst); err != nil {
		return err
	}

	// Create the destination file on disk.
	dstF, err := prepareDstFile(src, dst)
	if err != nil {
		return err
	}

	// Create a new template and parse the letter into it.
	t := template.Must(template.New("file").Parse(string(data)))
	return t.Execute(dstF, of)
}

// Ensure that a directory exists for the specified path.
func ensureDstDirExists(dst string) error {
	dstDir := filepath.Dir(dst)
	ok, err := isDir(dstDir)
	if err != nil || !ok {
		err = os.MkdirAll(dstDir, os.ModePerm)
		if err != nil {
			return err
		}
	}

	return nil
}

func prepareDstFile(src, dst string) (*os.File, error) {
	// Create the destination file with a default mask.
	dstF, err := os.Create(dst)
	if err != nil {
		return nil, err
	}

	// Read the source file's mask information.
	fi, err := os.Stat(src)
	if err != nil {
		return nil, err
	}

	// Set the mask on the destination file based on the source file.
	err = os.Chmod(dst, fi.Mode().Perm())
	if err != nil {
		return nil, err
	}

	// Return a pointer to the newly created destination file.
	return dstF, nil
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

	// Copy the file.
	return copyFile(src, dst, of)
}
