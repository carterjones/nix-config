// +build ubuntu

package main

func osActions() []action {
	flag := OSFlag{IsUbuntu: true}
	actions := []action{
		func() error { return bash(cnfTemplate("packages/ubuntu.sh")) },
		func() error { return copy(cnfTemplate("dotfiles/linux"), home(), flag) },
		func() error { return copy(cnfTemplate("dotfiles/shared"), home(), flag) },
	}
	return append(actions, linuxActions(flag)...)
}
