package main

func linuxActions(of OSFlag) []action {
	flag := OSFlag{}
	return []action{
		func() error { return bash(cnfTemplate("packages/linux.sh")) },
		func() error { return copy(cnfTemplate("binfiles/linux"), home("bin"), flag) },
	}
}
