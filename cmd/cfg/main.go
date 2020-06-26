package main

func linuxActions(of OSFlag) []action {
	return []action{
		func() error { return copy(cnfTemplate("dotfiles/linux"), home(), OSFlag{}) },
		func() error { return copy(cnfTemplate("dotfiles/shared"), home(), OSFlag{}) },
		func() error { return bash(cnfTemplate("packages/linux.sh")) },
		func() error { return copy(cnfTemplate("binfiles/linux"), home("bin"), OSFlag{}) },
	}
}

func generateOSActions() []action {
	osFlag := generateOSFlag()

	osActions := map[string][]action{
		"arch": append(
			[]action{func() error { return bash(cnfTemplate("packages/arch.sh")) }},
			linuxActions(osFlag)...,
		),
		"centos": append(
			[]action{func() error { return bash(cnfTemplate("packages/centos.sh")) }},
			linuxActions(osFlag)...,
		),
		"mac": []action{
			func() error { return bash(cnfTemplate("packages/mac.sh")) },
			func() error { return copy(cnfTemplate("dotfiles/shared"), home(), osFlag) },
			func() error { return copy(cnfTemplate("dotfiles/mac"), home(), osFlag) },
			func() error { return copy(cnfTemplate("binfiles/mac"), home("bin"), osFlag) },
		},
		"manjaro": append(
			[]action{func() error { return bash(cnfTemplate("packages/manjaro.sh")) }},
			linuxActions(osFlag)...,
		),
		"ubuntu": append(
			[]action{func() error { return bash(cnfTemplate("packages/ubuntu.sh")) }},
			linuxActions(osFlag)...,
		),
	}

	switch {
	case osFlag.IsArch:
		return osActions["arch"]
	case osFlag.IsCentos:
		return osActions["centos"]
	case osFlag.IsMac:
		return osActions["mac"]
	case osFlag.IsManjaro:
		return osActions["manjaro"]
	case osFlag.IsUbuntu:
		return osActions["ubuntu"]
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
