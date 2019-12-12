include Irvine32.inc

.data
caseTable	byte		'1'		; lookup value
		dword	AND_op	; address of procedure
entrySize = ($ - caseTable)
		byte		'2'
		dword	OR_op
		byte		'3'
		dword	NOT_op
		byte		'4'
		dword	XOR_op
entries = ($ - caseTable) / entrySize
prompt	byte	"1. x AND y",0Dh,0Ah
		  	byte	"2. x OR y",0Dh,0Ah
		  	byte	"3. NOT x",0Dh,0Ah
		  	byte	"4. x XOR y",0Dh,0Ah
		  	byte "5. Exit",0Dh,0Ah,0Dh,0Ah
		  	byte "Your Choice: ",0
msgAND	byte	"AND_op",0Dh,0Ah,0
msgOR		byte	"OR_op",0Dh,0Ah,0
msgNOT	byte	"NOT_op",0Dh,0Ah,0
msgXOR	byte	"XOR_op",0Dh,0Ah,0
xAsk	byte	0Dh,0Ah,"enter the value of x in hexadecimal: ",0
yAsk	byte	0Dh,0Ah,"enter the value of y in hexadecimal: ",0

.data?
x		dword	?
y		dword	?

.code
main PROC
	mov	edx,OFFSET prompt		; ask user for input
	call WriteString
	call ReadChar				; read character into AL
	mov	ebx,OFFSET caseTable	; point EBX to the table
	mov	ecx,entries		; loop counter
travelTable:
	cmp	al,[ebx]				; match found?
	jne	continue				; no: continue
	call NEAR PTR [ebx + 1]		; yes: call the procedure
	call Crlf
	jmp	done					; exit the search
continue:
	add	ebx,entrySize			; point to the next entry
	loop travelTable
done:
	exit
main ENDP

; BEING AND

.data
andAnswer	byte	" AND ",0
equals byte	" = ",0

.code
AND_op PROC
	mov	edx,OFFSET msgAND
	call GetX
	call GetY
	call Crlf

	mov	eax,x
	call WriteHex				; print x
	mov	edx,OFFSET andAnswer
	call WriteString			; print " AND "
	mov eax,y
	call WriteHex				; print y
	mov	edx,OFFSET equals
	call WriteString			; print " = "
	mov	eax,x
	and	eax,y
	call WriteHex				; print answer
	call Crlf
	ret
AND_op ENDP

; END AND
; BEGIN OR

.data
orAnswer	byte	" OR ",0

.code
OR_op PROC
	mov	edx,OFFSET msgOR
	call GetX
	call GetY
	call Crlf

	mov	eax,x
	call WriteHex				; print x
	mov	edx,OFFSET orAnswer
	call WriteString			; print " OR "
	mov	eax,y
	call WriteHex				; print y
	mov	edx,OFFSET equals
	call WriteString			; print " = "
	mov eax,x
	or eax,y
	call WriteHex				; print answer
	call Crlf
	ret
OR_op ENDP

; END OR
; BEGIN NOT

.data
notAnswer	byte	"NOT ",0

.code
NOT_op PROC
	mov	edx,OFFSET msgNOT
	call GetX
	call Crlf

	mov	edx,OFFSET notAnswer
	call WriteString			; print "NOT "
	mov	eax,x
	call WriteHex				; print x
	mov	edx,OFFSET equals
	call WriteString			; print " = "
	mov	eax,x
	not	eax
	call WriteHex				; print answer
	call Crlf
	ret
NOT_op ENDP

; END NOT
; BEGIN XOR

.data
xorAnswer	byte	" XOR ",0

.code
XOR_op PROC
	mov	edx,OFFSET msgXOR
	call GetX
	call GetY
	call Crlf

	mov	eax,x
	call WriteHex				; print x
	mov	edx,OFFSET xorAnswer
	call WriteString			; print " XOR "
	mov	eax,y
	call WriteHex				; print y
	mov	edx,OFFSET equals
	call WriteString			; print " = "
	mov	eax,x
	xor	eax,y
	call WriteHex				; print Answer
	call Crlf
	ret
XOR_op ENDP

GetX PROC
	call WriteString			; print message
	mov	edx,OFFSET xAsk
	call WriteString			; get x
	call ReadHex
	mov	x,eax
	ret
GetX ENDP

GetY PROC
	mov	edx,OFFSET yAsk
	call WriteString			; get y
	call ReadHex
	mov	y,eax
	ret
GetY ENDP
END main
