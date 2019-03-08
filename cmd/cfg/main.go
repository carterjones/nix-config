package main

func main() {
	actions := append(osActions(), sharedActions()...)

	for _, a := range actions {
		panicIfErr(a())
	}
}
