%{
package gocalc
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

func Parse(source string) Expression {
    l := &Lexer {
        text: []rune(source),
        pos: 0,
        result: NumExpr{},
    }
    yyParse(l)
    return l.result
}
