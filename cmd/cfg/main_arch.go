// +build arch

package main

func osActions() []action {
	flag := OSFlag{IsArch: true}
	actions := []action{
		func() error { return bash(cnfTemplate("packages/arch.sh")) },
		func() error { return copy(cnfTemplate("dotfiles/shared"), home(), flag) },
	}
	return append(actions, linuxActions(flag)...)
}
