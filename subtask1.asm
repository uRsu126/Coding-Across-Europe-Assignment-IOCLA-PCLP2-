;; Urse Andrei 312CB
; write the structures. make sure it fits the layour in the README
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
global apply_delay

; void apply_delay(struct flight* flights, int nrFlights)
; rdi = struct flight *flightss
; rsi = int nrFlights
apply_delay:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	;; DO NOT MODIFY
	;; Your code starts here

next_flight:
	;; departing time
	mov r8b, byte [rdi + flight.departingTime + date.hour]
	mov r9b, byte [rdi + flight.departingTime + date.minutes]

	add r9b, byte [rdi + flight.delayMinutes]
	cmp r9b, 60 ;; minutes are over 59

	mov r15, 0 ;; fix departing minutes
	jge minutes_fix

departing_fix:
	;; update departing minutes 
	mov byte [rdi + flight.departingTime + date.minutes], r9b

	;; update departing hour
	add r8b, byte [rdi + flight.delayHours]
	mov byte [rdi + flight.departingTime + date.hour], r8b

	;; arriving time
	mov r8b, byte [rdi + flight.arrivingTime + date.hour]
	mov r9b, byte [rdi + flight.arrivingTime + date.minutes]

	add r9b, byte [rdi + flight.delayMinutes]
	cmp r9b, 60 ;; minutes are over 59

	mov r15, 1 ;; fix arriving minutes
	jge minutes_fix

arriving_fix:
	;; update arriving minutes 
	mov byte [rdi + flight.arrivingTime + date.minutes], r9b

	;; update arriving hour
	add r8b, byte [rdi + flight.delayHours]
	mov byte [rdi + flight.arrivingTime + date.hour], r8b

	dec rsi
	test rsi, rsi
	jz exit

	add rdi, flight_size ;; next flight offset
	jmp next_flight

minutes_fix:
	mov r12b, r9b
	sub r12b, 60 ;; substract 1 hour
	mov r9b, r12b ;; add remaining minutes
	inc r8b ;; add 1 hour

	test r15, r15
	jz departing_fix

	jmp arriving_fix

exit:
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
