;; Urse Andrei 312CB
; you can declare any helper variables in .data or .bss

section .text

;; DO NOT MODIFY
global solve_labyrinth

solve_labyrinth:
    push    rbp
    mov     rbp, rsp
    push    rbx
    push    r12
    push    r13
    push    r14
    push    r15

    mov     r12, rdi
    mov     r13, rsi
    mov     r14, rdx
    mov     r15, rcx
    mov     rbx, r8
    ;; DO NOT MODIFY
    ;; YOUR CODE STARTS HERE

    xor rdi, rdi ;; row index
    xor rsi, rsi ;; column index
    dec r14 ;; m - 1
    dec r15 ;; n - 1

next_cell:
    cmp rdi, r14 ;; check if at last row
    je exit

    cmp rsi, r15 ;; check if at last col
    je exit

    mov rdx, [rbx + rdi * 8] ;; current string
    mov byte [rdx + rsi], 0x31 ;; set current pos to 1

check_right:
    mov al, [rdx + rsi + 1] ;; right cell
    cmp al, 0x31 ;; check if obstructed
    je check_down

    inc rsi ;; increase col index
    jmp next_cell

check_down:
    mov r8, [rbx + (rdi + 1) * 8] ;; move down
    mov al, [r8 + rsi] ;; bottom cell
    cmp al, 0x31 ;; check if obstructed
    je check_left

    inc rdi ;; increase row index
    jmp next_cell

check_left:
    mov al, [rdx + rsi - 1] ;; left cell
    cmp al, 0x31 ;; check if obstructed
    je move_up

    dec rsi ;; decrease col index
    jmp next_cell

move_up:
    ;; all other cells are obstructed,
    ;; so top cell must be free

    dec rdi ;; decrease row index
    jmp next_cell

exit:
    mov [r12], edi
    mov [r13], esi

    ;; YOUR CODE ENDS HERE
    ;; DO NOT MODIFY
    pop     r15
    pop     r14
    pop     r13
    pop     r12
    pop     rbx
    pop     rbp
    ret
    ;; DO NOT MODIFY