.model flat, stdcall

INCLUDE Irvine32.inc

.data
myArr		DWORD	1,5,6,8

.code
main PROC
	mov	esi,OFFSET myArr
	mov	ecx,LENGTHOF myArr
	mov	ebx,TYPE myArr
	call DumpMem
	; print first array | pre reversal

	mov	esi,OFFSET myArr
	mov	edi,OFFSET myArr + SIZEOF myArr - TYPE myArr
	mov	ecx,LENGTHOF myArr
	mov	eax,TYPE myArr

	; start reversing
	call ReverseArray

	; print reversed array
	mov	esi,OFFSET myArr
	mov	ecx,LENGTHOF myArr
	mov	ebx,TYPE myArr
	call DumpMem
main ENDP

ReverseArray PROC
Reverse:
; load value
	mov	eax,[esi]
	mov	ebx,[edi]
; store value in arr
	mov	[esi],ebx
	mov	[edi],eax
	add	esi,TYPE myArr
	sub	edi,TYPE myArr
	dec	ecx
loop Reverse
	ret
ReverseArray ENDP

END main