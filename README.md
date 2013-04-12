compiler-macro-utils
====================

Here I intend to collect tools and utilities for writing and working with
Common Lisp compiler macros.

This is what the Hyperspec has to say of the purpose of compiler macros:

> The purpose of the compiler macro facility is to permit selective source code
> transformations as optimization advice to the compiler.

Currently there are three functions in the compiler-macro-utils package.

[Function]  
__compiler-macro-expand__ form &optional env => expansion, expanded-p

> If a compiler macro is defined for _form_, it is expanded repeatedly in the
> lexical environment _env_ until expansion is declined. The resulting expansion
> is returned and _true_ is returned as a second value.
> 
> If there is no compiler macro defined, _form_ is simply returned unchanged and
> _false_ is returned as a second value.


[Function]  
__compiler-macro-expand-1__ form &optional env => expansion, expanded-p

> If a compiler macro is defined for _form_, it is expanded once in the
> lexical environment _env_ and the resulting expansion is returned and _true_
> is returned as a second value.
> 
> If there is no compiler macro defined, _form_ is simply returned unchanged and
> _false_ is returned as a second value.


[Function]  
__compiler-macro-p__ name => boolean

> Returns _true_ if a compiler macro is defined for _name_, otherwise _false_.


[Function]  
__literal-p__ object => boolean

> Returns _true_ if _object_ is either an atom or a list where the first element
> is the symbol _quote_, otherwise _false_.
