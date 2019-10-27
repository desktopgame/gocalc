%{
package gocalc

import (
    "fmt"
    "unicode"
    "strings"
)
%}

%union{
    token Token
    expr  Expression
}

%type<expr> expr program primary
%token<token> NUMBER
%token 	ADD SUB MUL DIV MOD LP RP
%right ASSIGN ADD_ASSIGN SUB_ASSIGN MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN AND_ASSIGN OR_ASSIGN LSHIFT_ASSIGN RSHIFT_ASSIGN EXC_OR_ASSIGN
%left LOGIC_OR
%left LOGIC_AND
%left BIT_OR
%left EXC_OR
%left BIT_AND
%left EQUAL NOTEQUAL
%left GT GE LT LE
%left LSHIFT RSHIFT
%left ADD SUB INJECTION
%left MUL DIV MOD
%right CHILDA NOT NEGATIVE POSITIVE
%left DOT FUNCCALL LSB
%nonassoc LP

%%

program
    : expr
    {
        $$ = $1
        yylex.(*Lexer).result = $$
    }
expr
    : primary
    | LP expr RP
    {
        $$ = $2
    }
    | expr ADD expr
    {
        $$ = BinOpExpr{left: $1, operator: '+', right: $3}
    }
    | expr SUB expr
    {
        $$ = BinOpExpr{left: $1, operator: '-', right: $3}
    }
    | expr MUL expr
    {
        $$ = BinOpExpr{left: $1, operator: '*', right: $3}
    }
    | expr DIV expr
    {
        $$ = BinOpExpr{left: $1, operator: '/', right: $3}
    }
    | expr MOD expr
    {
        $$ = BinOpExpr{left: $1, operator: '%', right: $3}
    }
    ;
primary
    : NUMBER
    {
        $$ = NumExpr{literal: $1.literal}
    }
    ;
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
        l.unget()
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

func Parse(source string) {
    l := &Lexer {
        text: []rune(source),
        pos: 0,
        result: NumExpr{},
    }
    yyParse(l)
    fmt.Printf("%#v\n", l.result)
}
