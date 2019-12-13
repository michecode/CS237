include Irvine32.inc

gcd PROTO,x:dword,y:dword

.data
ask1 byte "enter the first integer: ", 0
ask2 byte "enter the second integer: ", 0
answer byte "gcd: ", 0
butthole byte "gcd: ", 0
x dword ?
y dword ?

.code
main PROC
	call Clrscr
	mov edx, OFFSET ask1
	call getX  ; get variables
	mov edx, OFFSET ask2
	call getY
	; have variables
	invoke gcd, x, y ; returns to eax
	mov edx, OFFSET butthole
	call PrintResult
	exit
main ENDP

GetX PROC
	call WriteString	; print message
	call ReadDec			; get x
	mov	x,eax
	ret
GetX ENDP

GetY PROC
	call WriteString	; print
	call ReadDec			; get y
	mov	y,eax
	ret
GetY ENDP

PrintResult PROC
	call WriteString
	call WriteDec
	ret
PrintResult endp
END main
