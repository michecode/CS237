include Irvine32.inc

.code

gcd PROC, x:dword, y:dword
	; calculate the gcd of the two unsigned ints in recursion
	; receives x,y
	; returns gcd in eax
	mov eax,x
	mov ebx,y
	mov edx,0 				 ; clear edx aka high dividend
	;
	cmp ebx,0 				 ; stop condition
	je L1
	div ebx						 ; a / b // remainder in edx
	invoke gcd,ebx,edx ; recursive call gcd(b, a mod b)

	L1:
		ret
gcd endp
END
