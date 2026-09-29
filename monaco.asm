;; Urse Andrei 312CB
section .text

;; DO NOT MODIFY
global fix_lap_times


fix_lap_times:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	;; DO NOT MODIFY
	;; YOUR CODE STARTS HERE

	xor rbx, rbx
	dec rdx ;; nrDrivers - 1
	xor r12, r12 ;; count

next_value:
	mov al, [rsi + rbx]	;; error flag

	cmp al, 1 ;; check if error flag is set
	je add_repaired_value

add_value:
	mov r10, [rdi + rbx * 4] ;; add value
	mov [rcx + rbx * 4], r10 ;; to output array

	cmp rbx, rdx
	je exit

	inc rbx
	jmp next_value

add_repaired_value:
	test rbx, rbx ;; check if at first value
	jz repair_first_value

	cmp rbx, rdx ;; check if at last value
	je repair_last_value

	mov r9d, [rdi + (rbx - 1) * 4] ;; sum of
	mov r11d, [rdi + (rbx + 1) * 4] ;; neighbour values
	add r9, r11
	shr r9, 1 ;; divided by 2

	mov [rcx + rbx * 4], r9 ;; add repaired value

	inc rbx
	inc r12
	jmp next_value

repair_first_value:
	mov r10, [rdi + (rbx + 1) * 4] ;; add repaired
	mov [rcx + rbx * 4], r10 ;; first value

	inc rbx
	inc r12
	jmp next_value

repair_last_value:
	mov r10, [rdi + (rbx - 1) * 4] ;; add repaired
	mov [rcx + rbx * 4], r10 ;; last value

	inc r12

exit:
	mov [r8], r12d

	;; YOUR CODE ENDS HERE
	;; DO NOT MODIFY
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret
	;; DO NOT MODIFY