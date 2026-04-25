section .text
global f1, f2, f3, df1, df2, df3, g1

f1:
    push ebp
    mov ebp, esp
    sub esp, 4
    finit
    mov dword[esp], 3
    fild dword[esp]
    mov dword[esp], 5
    fild dword[esp]
    fdivp
    fld qword[ebp + 8]
    fmulp
    mov dword[esp], 3
    fild dword[esp]
    faddp
    add esp, 4
    leave
    ret
    
f2:
    push ebp
    mov ebp, esp
    sub esp, 4
    finit
    mov dword[esp], -2
    fild dword[esp]
    fld qword[ebp + 8]
    faddp
    fld ST0
    fld ST0
    fmulp
    fmulp
    mov dword[esp], -1
    fild dword[esp]
    faddp
    add esp, 4
    leave
    ret
    
f3:
    push ebp
    mov ebp, esp
    sub esp, 4
    finit
    mov dword[esp], 3
    fild dword[esp]
    fld qword[ebp + 8]
    fdivp
    add esp, 4
    leave
    ret
    
df1:
    push ebp
    mov ebp, esp
    sub esp, 4
    finit
    mov dword[esp], 3
    fild dword[esp]
    mov dword[esp], 5
    fild dword[esp]
    fdivp
    add esp, 4
    leave
    ret
    
df2:
    push ebp
    mov ebp, esp
    sub esp, 4
    finit
    mov dword[esp], 3
    fild dword[esp]
    mov dword[esp], -2
    fild dword[esp]
    fld qword[ebp + 8]
    faddp
    fld ST0
    fmulp
    fmulp
    add esp, 4
    leave
    ret
    
df3:
    push ebp
    mov ebp, esp
    sub esp, 4
    finit
    mov dword[esp], -3
    fild dword[esp]
    fld qword[ebp + 8]
    fld ST0
    fmulp
    fdivp
    add esp, 4
    leave
    ret
    
g1:
    push ebp
    mov ebp, esp
    sub esp, 4
    finit
    mov dword[esp], 389
    fild dword[esp]
    mov dword[esp], 100
    fild dword[esp]
    fdivp
    mov dword[esp], 1
    fild dword[esp]
    fld qword[ebp + 8]
    fyl2x
    fldl2e
    fdivp
    faddp    
    fld qword[ebp + 8]
    fld ST0
    mov dword[esp], 15
    fild dword[esp]
    fmulp
    fmulp
    fsubp
    add esp, 4
    leave
    ret
