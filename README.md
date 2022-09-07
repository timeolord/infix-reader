# infix-reader
A reader macro that enables infix notation in Common Lisp.

# Installation
```lisp
(ql:quickload :infix-reader)
```

# Usage
```lisp
(infix-reader:enable-infix-reader)

{1 + 2}
; 3
{1 + {5 + 2}}
; 8
{x defvar 12}
; X

(infix-reader:disable-infix-reader)
```

# Notes
The macro only works with 2 arguments, to prevent issues with precident.
Essentially all it does is parse "{1 + 2}" into "(+ 1 2)".
