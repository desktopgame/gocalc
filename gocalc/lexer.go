package gocalc

import (
	"fmt"
	"strings"
	"unicode"
)

type Lexer struct {
	text   []rune
	pos    int
	result Expression
}

func (l *Lexer) get() rune {
	if l.pos >= len(l.text) {
		panic("could not read")
	}
	rn := l.text[l.pos]
	l.pos++
	return rn
}

func (l *Lexer) unget() {
	l.pos--
}

func (l *Lexer) ready() bool {
	return l.pos < len(l.text)
}

func (l *Lexer) skipSpace() {
	r := false
	for {
		if !l.ready() {
			r = true
			break
		}
		rn := l.get()
		if rn != ' ' {
			break
		}
	}
	if !r {
		l.unget()
	}
}

func (l *Lexer) Lex(lval *yySymType) int {
	l.skipSpace()
	if !l.ready() {
		return -1
	}
	rn := l.get()
	if unicode.IsDigit(rn) {
		var buf strings.Builder
		r := false
		for unicode.IsDigit(rn) {
			buf.WriteRune(rn)
			if !l.ready() {
				r = true
				break
			}
			rn = l.get()
		}
		lval.token = Token{token: NUMBER, literal: buf.String()}
		if !r {
			l.unget()
		}
		return NUMBER
	} else if rn == '+' {
		return ADD
	} else if rn == '-' {
		return SUB
	} else if rn == '*' {
		return MUL
	} else if rn == '/' {
		return DIV
	} else if rn == '%' {
		return MOD
	} else if rn == '(' {
		return LP
	} else if rn == ')' {
		return RP
	}
	panic(fmt.Sprintf("invalid character: %c", rn))
}

func (l *Lexer) Error(e string) {
	panic(e)
}
