package main

import (
	"testing"

	"github.com/desktopgame/gocalc/gocalc"
)

func TestParse(t *testing.T) {
	gocalc.Dump(gocalc.Parse("10+51+(3*4)"))
}
