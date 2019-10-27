package main

import "testing"
import "github.com/desktopgame/gocalc/gocalc"

func TestParse(t *testing.T) {
	gocalc.Parse("10+51+(3*4)")
}
