%{
package main

import (
    "fmt"
    "unicode"
    "os"
    "strings"
)

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
%}

%union{
    token Token
    expr  Expression
}

%type<expr> program
%type<expr> expr
%token<token> NUMBER
%token ADD
%left ADD

%%

program
    : expr
    {
        $$ = $1
        yylex.(*Lexer).result = $$
    }

expr
    : NUMBER
    {
        $$ = NumExpr{literal: $1.literal}
    }
    | expr ADD expr
    {
        $$ = BinOpExpr{left: $1, operator: '+', right: $3}
    }

%%

type Lexer struct {
    text []rune
    pos int
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

func (l *Lexer) Lex(lval *yySymType) int {
    if !l.ready() {
        return -1
    }
    rn := l.get()
    if unicode.IsDigit(rn) {
        var buf strings.Builder
        for unicode.IsDigit(rn) && l.ready() {
            buf.WriteRune(rn)
            rn = l.get()
        }
        lval.token = Token{token: NUMBER, literal: buf.String()}
        if l.ready() {
            l.unget()
        }
        fmt.Println("route A")
        return NUMBER
    } else if rn == '+' {
        fmt.Println("route B")
        return ADD
    }
    fmt.Println("route P")
    panic("")
}

func (l *Lexer) Error(e string) {
    panic(e)
}

func main() {
    l := &Lexer {
        text: []rune(os.Args[1]),
        pos: 0,
        result: NumExpr{},
    }
    yyParse(l)
    fmt.Printf("%#v\n", l.result)
}