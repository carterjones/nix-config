// +build mac

package main

func osActions() []action {
	flag := OSFlag{IsMac: true}
	return []action{
		func() error { return bash(cnfTemplate("packages/mac.sh")) },
		func() error { return copy(cnfTemplate("dotfiles/shared"), home(), flag) },
		func() error { return copy(cnfTemplate("dotfiles/mac"), home(), flag) },
		func() error { return copy(cnfTemplate("binfiles/mac"), home("bin"), flag) },
	}
}
