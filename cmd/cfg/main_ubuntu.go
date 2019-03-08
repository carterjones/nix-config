// +build ubuntu

package main

func osActions() []action {
	flag := OSFlag{IsUbuntu: true}
	actions := []action{
		func() error { return bash(cnfTemplate("packages/ubuntu.sh")) },
	}
	return append(actions, linuxActions(flag)...)
}
