package gocalc

import "fmt"

type Expression interface{}
type Token struct {
	token   int
	literal string
}

type NumExpr struct {
	literal string
}
type BinOpExpr struct {
	left     Expression
	operator rune
	right    Expression
}

func Dump(expr Expression) {
	dumpImpl(expr, 0)
}
func dumpImpl(expr Expression, depth int) {
	for i := 0; i < depth; i++ {
		fmt.Print("    ")
	}
	switch (expr).(type) {
	case NumExpr:
		fmt.Println(expr.(NumExpr).literal)
		break
	case BinOpExpr:
		biExpr := expr.(BinOpExpr)
		fmt.Printf("%c\n", biExpr.operator)
		dumpImpl(biExpr.left, depth+1)
		dumpImpl(biExpr.right, depth+1)
		break
	}
}
