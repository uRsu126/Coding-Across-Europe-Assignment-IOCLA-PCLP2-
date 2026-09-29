;; Urse Andrei 312CB
; write the structures
struc date
	.day resb 1
	.hour resb 1
	.minutes resb 1
endstruc

struc flight
	.destination resb 32
	.departingTime resb date_size
	.arrivingTime resb date_size
	.bag_weight resw 1
	.delayMinutes resb 1
	.delayHours resb 1
endstruc

section .text

;; DO NOT MODIFY
global filter_flights

; void filter_flights(struct flight* origFlights, struct flight* finalFlights
;						 int* nrFlights, int min_bag_weight)
; rdi = struct flight *origFlights
; rsi = struct flight *finalFlights
; rdx = int *nrFlights
; rcx = int min_bag_weight
filter_flights:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	;; DO NOT MODIFY
	;; Your code starts here

	xor rax, rax
	mov r8d, [rdx] ;; nrFlights
	xor r9, r9 ;; count filtered flights

next_flight:
	test r8, r8
	jz exit

	xor r12, r12
	mov ax, [rdi + flight.bag_weight]
	cmp ax, cx ;; check weight
	jl skip_flight

copy_flight:
	mov r11, [rdi + r12 * 8] ;; copy destination, dep/arr times
	mov [rsi + r12 * 8], r11 ;; and bag_weight                 

	inc r12
	cmp r12, 5 ;; check if done
	jne copy_flight

	mov r11w, [rdi + 40] ;; copy 
	mov [rsi + 40], r11w ;; delay time

	inc r9
	add rsi, flight_size

skip_flight:
	dec r8
	add rdi, flight_size
	jmp next_flight

exit:
	mov [rdx], r9d ;; update nrFlights

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

	leave
	ret