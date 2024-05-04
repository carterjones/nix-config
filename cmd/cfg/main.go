package main

func generateOSActions() []action {
	osFlag := generateOSFlag()

	sharedActions := []action{
		func() error { return bash(cnfTemplate("packages/shared.sh")) },
		func() error { return copy(cnfTemplate("binfiles/shared"), home("bin"), osFlag) },
	}

	switch {
	case osFlag.IsMac:
		return append([]action{
			func() error { return bash(cnfTemplate("packages/mac.sh")) },
			func() error { return copy(cnfTemplate("dotfiles/shared"), home(), osFlag) },
			func() error { return copy(cnfTemplate("dotfiles/mac"), home(), osFlag) },
			func() error { return copy(cnfTemplate("binfiles/mac"), home("bin"), osFlag) },
		}, sharedActions...)
	case osFlag.IsCentos:
		fallthrough
	case osFlag.IsManjaro:
		fallthrough
	case osFlag.IsUbuntu:
		fallthrough
	case osFlag.IsDebian:
		return append([]action{
			func() error { return bash(cnfTemplate("packages/" + osFlag.OSString() + ".sh")) },
			func() error { return copy(cnfTemplate("dotfiles/linux"), home(), osFlag) },
			func() error { return copy(cnfTemplate("dotfiles/shared"), home(), osFlag) },
			func() error { return bash(cnfTemplate("packages/linux.sh")) },
			func() error { return copy(cnfTemplate("binfiles/linux"), home("bin"), osFlag) },
		}, sharedActions...)
	default:
		panic("unsupported operating system. bye.")
	}
}

func main() {
	actions := generateOSActions()

	for _, a := range actions {
		err := a()
		if err != nil {
			panic(err)
		}
	}
}
