
@str = <<EOS

func Test__VarName(t *testing.T) {
	expr := gocalc.Parse("__VarForm")
    gocalc.Dump(expr)
    val := gocalc.Eval(expr)
    fmt.Println(val)
    if val != (__VarForm) {
        t.Fatal("parse error")
    }
}
EOS

def gen_func(name, form)
    a = @str.dup
    a = a.gsub("__VarName", name)
    a = a.gsub("__VarForm", form)
    a
end

forms = [
    "10+5",
    "10+5+(3*4)",
    "3/1",
    "3/2+5"
]
forms.each_with_index do |form, i|
    puts(gen_func(i.to_s, form))
end
