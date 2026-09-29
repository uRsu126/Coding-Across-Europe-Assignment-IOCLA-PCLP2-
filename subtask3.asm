;; Urse Andrei 312CB
; write the structure
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
global sort_and_return

; int sort_and_return(struct flight* flights, int nrFlights, 
;                      struct flight* bestFlight, char destination[32])
; rdi = flights (pointer)
; rsi = nrFlights (value)
; rdx = bestFlight (pointer to pre-allocated struct)
; rcx = destination (pointer to 32-byte string)
sort_and_return:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	;; DO NOT MODIFY
	;; Your code starts here

	mov r11, rdi ;; store pointer
	mov r14, rsi ;; store nrFlights

	mov r15, rdi
	add r15, flight_size ;; flight to the right

	dec rsi
	mov r10, rsi

	jmp next_flight

remaining_flights_num:
	dec rsi
	test rsi, rsi
	jz sort_done

	mov r10, rsi ;; store nrFlights - 1

	add rdi, flight_size
	mov r15, rdi
	add r15, flight_size

next_flight:
	;; current flight arr day
	mov r8b, [rdi + flight.arrivingTime + date.day]
	;; next flight arr day
	mov r9b, [r15 + flight.arrivingTime + date.day]

	cmp r8b, r9b ;; check smaller day
	jg switch_flights

	cmp r8b, r9b ;; check same day
	je check_hour

inner_next_flight:
	add r15, flight_size ;; compare every flight to the ones to its right
	dec r10
	test r10, r10
	jz remaining_flights_num

	jmp next_flight

check_hour:
	;; current flight arr hour
	mov r8b, [rdi + flight.arrivingTime + date.hour]
	;; next flight arr hour
	mov r9b, [r15 + flight.arrivingTime + date.hour]

	cmp r8b, r9b ;; check smaller hour
	jg switch_flights

	cmp r8b, r9b ;; check same hour
	je check_minutes

	jmp inner_next_flight

check_minutes:
	;; current flight arr minutes
	mov r8b, [rdi + flight.arrivingTime + date.minutes]
	;; next flight arr minutes
	mov r9b, [r15 + flight.arrivingTime + date.minutes]

	cmp r8b, r9b ;; check less minutes
	jg switch_flights

	cmp r8b, r9b ;; check equal minutes
	je check_bag_weight

	jmp inner_next_flight

check_bag_weight:
	;; current flight arr minutes
	mov r8w, [rdi + flight.bag_weight]
	;; next flight arr minutes
	mov r9w, [r15 + flight.bag_weight]

	cmp r8w, r9w ;; check heavier bag weight
	jl switch_flights

	jmp inner_next_flight

switch_flights:
	xor r13, r13

copy_flight_1:
	;; rdx = rdi
	mov r12, [rdi + r13 * 8] ;; copy destination, dep/arr times
	mov [rdx + r13 * 8], r12 ;; and bag_weight  

	inc r13
	cmp r13, 5 ;; check if done
	jne copy_flight_1

	mov r12w, [rdi + 40] ;; copy
	mov [rdx + 40], r12w ;; delay time

	;; rdi = r15
	xor r13, r13
copy_flight_2:
	mov r12, [r15 + r13 * 8] ;; copy destination, dep/arr times
	mov [rdi + r13 * 8], r12 ;; and bag_weight  

	inc r13
	cmp r13, 5 ;; check if done
	jne copy_flight_2

	mov r12w, [r15 + 40] ;; copy
	mov [rdi + 40], r12w ;; delay time

	;; r15 = rdx
	xor r13, r13
copy_flight_3:
	mov r12, [rdx + r13 * 8] ;; copy destination, dep/arr times               
	mov [r15 + r13 * 8], r12 ;; and bag_weight  

	inc r13
	cmp r13, 5 ;; check if done
	jne copy_flight_3

	mov r12w, [rdx + 40] ;; copy
	mov [r15 + 40], r12w ;; delay time

	jmp next_flight

sort_done:
	mov rdi, r11 ;; restore pointer
	mov rsi, r14 ;; restore nrFlights
	xor r11, r11

	jmp compare_destinations

find_flight:
	xor r11, r11
	add rdi, flight_size

	dec rsi
	test rsi, rsi ;; check if all flights searched
	jz not_found

compare_destinations:
	mov r8b, [rdi + flight.destination + r11]
	mov r9b, [rcx + r11]

	cmp r8b, r9b ;; if different, check next flight
	jne find_flight

	inc r11
	cmp r11, 32 ;; check if compared entire string
	jz found_flight

	jmp compare_destinations

found_flight:
	mov rax, 1 ;; found flight
	xor r12, r12

copy_flight:
	mov r11, [rdi + r12 * 8] ;; copy destination, dep/arr times
	mov [rdx + r12 * 8], r11 ;; and bag_weight

	inc r12
	cmp r12, 5 ;; check if done
	jne copy_flight

	mov r11w, [rdi + 40] ;; copy 
	mov [rdx + 40], r11w ;; delay time

	jmp exit

not_found:
	xor rax, rax ;; flight doesn't exist

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