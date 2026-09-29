;; Urse Andrei 312CB
section .text

;; DO NOT MODIFY
global check_column
global check_row
global check_box

; int check_row(int **array, int size, int rowNr)
; rdi = int **array
; rsi = int size
; rdx = int rowNr
check_row:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	;; DO NOT MODIFY
	;; Your code starts here

	;; r8  - sum
	;; r9  - aritm avg
	;; r10 - product
	;; r11 - factorial

	xor rcx, rcx ;; index
	xor r8, r8 ;; sum
	mov rbx, [rdi + rdx * 8] ;; requested row

	xor rax, rax
aritm_avg_row:
	mov rax, rsi ;; size + 1
	inc rax
	mul rsi ;; (size + 1) * size
	shr rax, 1 ;; / 2
	mov r9, rax

	xor r11, r11
	mov r11, rsi
	mov rax, 1 ;; mul
factorial_size_row:
	mul r11
	dec r11

	test r11, r11
	jg factorial_size_row
	mov r11, rax

	mov rax, 1 ;; mul
next_number_row:
	cmp rcx, rsi ;; check if at end of row
	je check_valid_row

	mov r12d, [rbx + rcx * 4] ;; next number
	add r8, r12
	mul r12

	inc rcx
	jmp next_number_row

check_valid_row:
	cmp r8, r9
	jne invalid_row

	mov r10, rax
	cmp r10, r11
	jne invalid_row

	mov rax, 1 ;; valid row
	jmp exit_row

invalid_row:
	xor rax, rax ;; invalid row

exit_row:
	;; Your code ends here
	;; DO NOT MODIFY
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret
	;; DO NOT MODIFY

	;; DO NOT MODIFY
	; int check_column(int **array, int size, int columnNr)
	; rdi = int **array
	; rsi = int size
	; rdx = int columnNr
check_column:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	;; DO NOT MODIFY
	;; Your code starts here

	xor rcx, rcx ;; index
	xor r8, r8 ;; sum
	mov r13, rdx ;; store col index

	xor rax, rax
aritm_avg_col:
	mov rax, rsi ;; size + 1
	inc rax
	mul rsi ;; (size + 1) * size
	shr rax, 1 ;; / 2
	mov r9, rax

	xor r11, r11
	mov r11, rsi
	mov rax, 1 ;; mul
factorial_size_col:
	mul r11
	dec r11

	test r11, r11
	jg factorial_size_col
	mov r11, rax

	mov rax, 1 ;; mul
next_number_col:
	cmp rcx, rsi ;; check if at end of col
	je check_valid_col

	mov rbx, [rdi + rcx * 8] ;; next row
	mov r12d, [rbx + r13 * 4] ;; next number
	add r8, r12
	mul r12

	inc rcx
	jmp next_number_col

check_valid_col:
	cmp r8, r9
	jne invalid_col

	mov r10, rax
	cmp r10, r11
	jne invalid_col

	mov rax, 1 ;; valid col
	jmp exit_col

invalid_col:
	xor rax, rax ;; invalid col

exit_col:
	;; Your code ends here
	;; DO NOT MODIFY
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret
	;; DO NOT MODIFY

	;; DO NOT MODIFY
; int check_box(int **array, int size, int boxNr)
; rdi = int **array
; rsi = int size
; rdx = int boxNr
check_box:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	;; DO NOT MODIFY
	;; Your code starts here

	xor r8, r8 ;; sum
	mov r14, rdx ;; store boxNr

	xor rax, rax
aritm_avg_box:
	mov rax, rsi ;; size + 1
	inc rax
	mul rsi ;; (size + 1) * size
	shr rax, 1 ;; / 2
	mov r9, rax

	xor r11, r11
	mov r11, rsi
	mov rax, 1 ;; mul
factorial_size_box:
	mul r11
	dec r11

	test r11, r11
	jg factorial_size_box
	mov r11, rax
	xor rax, rax

sudoku_size:
	cmp rsi, 9 ;; 9x9 sudoku
	je box_size_3

	cmp rsi, 16 ;; 16x16 sudoku
	je box_size_4

	mov rsi, 2 ;; 2x2 box
	jmp row_col_index

box_size_3:
	mov rsi, 3 ;; 3x3 box
	jmp row_col_index

box_size_4:
	mov rsi, 4 ;; 4x4 box

row_col_index:
	mov rax, r14
	xor rdx, rdx
	div rsi
	mul rsi
	mov rcx ,rax ;; start row = (boxNr - 1) / sqrt(size) * sqrt(size)

	mov rax, r14
	xor rdx, rdx
	div rsi
	mov rax, rdx
	mul rsi
	mov r13, rax ;; start col = (boxNr - 1) % sqrt(size) * sqrt(size)

	mov rax, 1 ;; mul
	mov r10, r13 ;; store start col
	xor r15, r15 ;; count for rows
next_row_number_box:
	cmp r15, rsi
	je check_valid_box
	inc r15

	mov rbx, [rdi + rcx * 8] ;; row

	mov r13, r10 ;; restore start col
	xor r14, r14 ;; count for cols
next_col_number_box:
	mov r12d, [rbx + r13 * 4] ;; next number
	add r8, r12
	mul r12

	inc r13
	inc r14

	cmp r14, rsi
	jne next_col_number_box

	inc rcx ;; next row
	jmp next_row_number_box

check_valid_box:
	cmp r8, r9
	jne invalid_box 

	mov r10, rax
	cmp r10, r11
	jne invalid_box

	mov rax, 1 ;; valid box
	jmp exit_box

invalid_box:
	xor rax, rax ;; invalid box

exit_box:
	;; Your code ends here
	;; DO NOT MODIFY
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret
