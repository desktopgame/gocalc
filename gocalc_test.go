package main

import (
	"testing"
	"fmt"
	"github.com/desktopgame/gocalc/gocalc"
)

func TestParse(t *testing.T) {
	expr := gocalc.Parse("10+51+(3*4)")
	gocalc.Dump(expr)
	fmt.Println(gocalc.Eval(expr))
}
