package main

import (
	"flag"
	"fmt"

	"github.com/desktopgame/gocalc/gocalc"
)

func main() {
	var (
		str = flag.String("i", "", "input form")
	)
	flag.Parse()
	expr := gocalc.Parse(*str)
	gocalc.Dump(expr)
	val := gocalc.Eval(expr)
	fmt.Println(val)
}
