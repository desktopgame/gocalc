# gocalc

電卓  
+-\*/%() のみ使用可能

# install

```
go get github.com/desktopgame/gocalc
```

# example

.1

```
$ gocalc -i "3 +  1 * 2"
+
    3
    *
        1
        2
5
```

.2

```
$ gocalc -i "3 +  1 * 2 * 4"
+
    3
    *
        *
            1
            2
        4
11
```

.3

```
$ gocalc -i "10 % 3"
%
    10
    3
1
```
