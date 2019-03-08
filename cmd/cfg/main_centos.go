// +build centos

package main

func osActions() []action {
	flag := OSFlag{IsCentos: true}
	actions := []action{
		func() error { return bash(cnfTemplate("packages/centos.sh")) },
		func() error { return copy(cnfTemplate("dotfiles/shared"), home(), flag) },
	}
	return append(actions, linuxActions(flag)...)
}
