package main

func generateOSActions() []action {
	osFlag := generateOSFlag()

	switch {
	case osFlag.IsMac:
		return []action{
			func() error { return bash(cnfTemplate("packages/mac.sh")) },
			func() error { return copy(cnfTemplate("dotfiles/shared"), home(), osFlag) },
			func() error { return copy(cnfTemplate("dotfiles/mac"), home(), osFlag) },
			func() error { return copy(cnfTemplate("binfiles/mac"), home("bin"), osFlag) },
		}
	case osFlag.IsArch:
		fallthrough
	case osFlag.IsCentos:
		fallthrough
	case osFlag.IsManjaro:
		fallthrough
	case osFlag.IsUbuntu:
		return []action{
			func() error { return bash(cnfTemplate("packages/" + osFlag.OSString() + ".sh")) },
			func() error { return copy(cnfTemplate("dotfiles/linux"), home(), OSFlag{}) },
			func() error { return copy(cnfTemplate("dotfiles/shared"), home(), OSFlag{}) },
			func() error { return bash(cnfTemplate("packages/linux.sh")) },
			func() error { return copy(cnfTemplate("binfiles/linux"), home("bin"), OSFlag{}) },
		}
	default:
		panic("unsupported operating system. bye.")
	}
}

func sharedActions() []action {
	flag := OSFlag{}
	return []action{
		func() error { return bash(cnfTemplate("packages/shared.sh")) },
		func() error { return copy(cnfTemplate("binfiles/shared"), home("bin"), flag) },
	}
}

func main() {
	actions := append(generateOSActions(), sharedActions()...)

	for _, a := range actions {
		err := a()
		if err != nil {
			panic(err)
		}
	}
}
