include Irvine32.inc

fibs = 30

.data
sequence dword fibs DUP(?)

.code
main PROC
	call fib
	exit
main ENDP

fib PROC
	mov	sequence[0], 1
	mov	sequence[4], 1
	mov	ecx, fibs - 2
	mov	esi, 2 * type dword
	calc:
	mov	eax, sequence[esi - type dword]
	add	eax, sequence[esi - 2 * type dword]
	mov	sequence[esi],eax
	add	esi, type dword
	loop calc
	mov	esi, OFFSET sequence
	mov	ecx, LENGTHOF sequence
	mov	ebx, type sequence
	call DumpMem
	ret
fib ENDP
END main
