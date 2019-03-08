// +build manjaro

package main

func osActions() []action {
	flag := OSFlag{IsManjaro: true}
	actions := []action{
		func() error { return bash(cnfTemplate("packages/manjaro.sh")) },
		func() error { return copy(cnfTemplate("dotfiles/shared"), home(), flag) },
	}
	return append(actions, linuxActions(flag)...)
}
