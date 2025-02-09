/*
REQUIRED_ARGS: -w -o-

TEST_OUTPUT:
---
fail_compilation/noreturn2.d(18): Error: `return` expression expected
---

https://github.com/dlang/DIPs/blob/master/DIPs/accepted/DIP1034.md
*/

alias noreturn = typeof(*null);

void doStuff();

noreturn returnVoid()
{
    return doStuff();
}


/+
TEST_OUTPUT:
---
fail_compilation/noreturn2.d(37): Error: Expected return type of `int`, not `string`:
fail_compilation/noreturn2.d(35):        Return type of `int` inferred here.
---
+/

auto missmatch(int i)
{
    if (i < 0)
        return assert(false);
    if (i == 0)
        return i;
    if (i > 0)
        return "";
}

/+
TEST_OUTPUT:
---
fail_compilation/noreturn2.d(50): Error: function `noreturn2.returns` is typed as `NR` but does return
fail_compilation/noreturn2.d(50):        `noreturn` functions must either throw, abort or loop indefinitely
---
+/

enum NR : noreturn;

NR returns()
{
    // Fallthrough despite noreturn
}

/+
TEST_OUTPUT:
---
fail_compilation/noreturn2.d(64): Error: cannot implicitly convert expression `1` of type `int` to `noreturn`
---
+/

noreturn returnsValue()
{
    return 1;
}
