package main

import (
	"testing"
	"fmt"
	"github.com/desktopgame/gocalc/gocalc"
)

func Test0(t *testing.T) {
	expr := gocalc.Parse("10+5")
    gocalc.Dump(expr)
    val := gocalc.Eval(expr)
    fmt.Println(val)
    if val != (10+5) {
        t.Fatal("parse error")
    }
}

func Test1(t *testing.T) {
	expr := gocalc.Parse("10+5+(3*4)")
    gocalc.Dump(expr)
    val := gocalc.Eval(expr)
    fmt.Println(val)
    if val != (10+5+(3*4)) {
        t.Fatal("parse error")
    }
}

func Test2(t *testing.T) {
	expr := gocalc.Parse("3/1")
    gocalc.Dump(expr)
    val := gocalc.Eval(expr)
    fmt.Println(val)
    if val != (3/1) {
        t.Fatal("parse error")
    }
}

func Test3(t *testing.T) {
	expr := gocalc.Parse("3/2+5")
    gocalc.Dump(expr)
    val := gocalc.Eval(expr)
    fmt.Println(val)
    if val != (3/2+5) {
        t.Fatal("parse error")
    }
}

