package main

func sharedActions() []action {
	flag := OSFlag{}
	return []action{
		func() error { return bash(cnfTemplate("packages/shared.sh")) },
		func() error { return copy(cnfTemplate("binfiles/shared"), home("bin"), flag) },
		func() error { return bash(cnfTemplate("bgrep/install.sh")) },
	}
}
