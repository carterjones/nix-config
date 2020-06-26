package main

func main() {
	actions := append(osActions(), sharedActions()...)

	for _, a := range actions {
		err := a()
		if err != nil {
			panic(err)
		}
	}
}
