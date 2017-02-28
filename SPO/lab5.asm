;������ୠ� ࠡ�� �5
;����� ����਩ ���-15�1

menu macro b1,b2,b3,w1,w2,d1

menu_loop:

	call cursor
	vivod s_m0
	vivod s_m1
	vivod s_m2
	vivod s_m3
	vivod s_m4
	vivod s_mExit
	
	vivod s_mOp
	
	
	mov ah,01h
	int 21h
	
	cmp al,'1'
	je menu_1tmp
	cmp al,'2'
	je menu_2tmp
	cmp al,'3'
	je menu_3tmp
	cmp al,'4' 
	je menu_4tmp
	
	cmp al,'0'
	je menu_exit_tmp
	
	call cursor
	vivod s_mErr
	jmp menu_loop
menu_1tmp:
	jmp menu_1
menu_2tmp:
	jmp menu_2
menu_3tmp:
	jmp menu_3
menu_4tmp:
	jmp menu_4
menu_exit_tmp:
	jmp menu_exit
	
menu_1:
	call cursor 
	arifm b1,b2,b3,w1,w2,d1
	jmp menu_loop
menu_2:
	call cursor
	logic b1,b2,b3,w1,w2,d1
	jmp menu_loop
menu_3:
	call cursor
	sdvigi  b1,b2,b3,w1,w2,d1
	jmp menu_loop
menu_4:
	clrscr
	cursor_m
	jmp menu_loop
menu_exit:
endm


cin macro b1,b2,b3,w1,w2,d1

cin_b1:
	mov ah,09											; �뢮� 
	mov osh_v,0											; ��
	lea dx,s_b1											; ��࠭
	int 21h													; ����饭�� "������ .."

	mov ah,0ah										  	;����
	lea dx, vvod_b										;� ����������
	int 21h													;���祭��
	
	call ASCII_bin_b									;��ॢ�� �� ASCII � ������ ���
	
	mov b1,al
	mov prom,0
	call cursor
	
	cmp osh_v,0
	je cin_b2
	jmp cin_b1

cin_b2:
	mov ah,09											; �뢮� 
	mov osh_v,0											; ��
	lea dx,s_b2											; ��࠭
	int 21h													; ����饭�� "������ .."

	mov ah,0ah										  	;����
	lea dx, vvod_b										;� ����������
	int 21h													;���祭��
	
	call ASCII_bin_b									;��ॢ�� �� ASCII � ������ ���
	
	mov b2,al
	mov prom,0
	call cursor
	
	cmp osh_v,0
	je cin_b3
	jmp cin_b2

cin_b3:
	mov ah,09											; �뢮� 
	mov osh_v,0											; ��
	lea dx,s_b3											; ��࠭
	int 21h													; ����饭�� "������ .."

	mov ah,0ah										  	;����
	lea dx, vvod_b										;� ����������
	int 21h													;���祭��
	
	call ASCII_bin_b									;��ॢ�� �� ASCII � ������ ���
	
	mov b3,al
	mov prom,0
	call cursor
	
	cmp osh_v,0
	je cin_w1
	jmp cin_b3

cin_w1:
	mov ah,09											; �뢮� 
	mov osh_v,0											; ��
	lea dx,s_w1											; ��࠭
	int 21h													; ����饭�� "������ .."

	mov ah,0ah										  	;����
	lea dx, vvod_w										;� ����������
	int 21h													;���祭��
	
	call ASCII_bin_w									;��ॢ�� �� ASCII � ������ ���
	
	mov word ptr w1,ax
	mov prom,0
	call cursor
	
	cmp osh_v,0
	je cin_w2
	jmp cin_w1

cin_w2:
	mov ah,09											; �뢮� 
	mov osh_v,0											; ��
	lea dx,s_w2											; ��࠭
	int 21h													; ����饭�� "������ .."

	mov ah,0ah										  	;����
	lea dx, vvod_w										;� ����������
	int 21h													;���祭��
	
	call ASCII_bin_w									;��ॢ�� �� ASCII � ������ ���
	
	mov word ptr w2,ax
	mov prom,0
	call cursor
	
	cmp osh_v,0
	je cin_d1
	jmp cin_w2

cin_d1:
	mov ah,09											; �뢮� 
	mov osh_v,0											; ��
	lea dx,s_d1											; ��࠭
	int 21h													; ����饭�� "������ .."

	mov ah,0ah										  	;����
	lea dx, vvod_d										;� ����������
	int 21h													;���祭��
	
	call ASCII_bin_d									;��ॢ�� �� ASCII � ������ ���
	
	mov word ptr d1,ax
	mov word ptr d1+2,ax
	mov prom,0
	call cursor
	
	cmp osh_v,0
	je cin_end
	jmp cin_d1

cin_end:	
endm

arifm macro b1,b2,b3,w1,w2,d1
call cursor
vivod s_f1
;��⠥� �� ��㫥-----------------------------------------------------
;w2+w1-b1*b2+d1/b3
	;b1*b2
	mov al,b1
	mov ah,0
	mul b2
	mov word ptr rez1,ax			;rez1 = b1*b2
	;d1/b3
	mov ax, word ptr d1
	div b3
	mov word ptr rez2,ax			;rez2 = d1/b3
	;w2+w1
	mov ax,w1
	add ax,w2			;ax=w1+w2
	;w2+w1-b1*b2
	sub ax,word ptr rez1			;ax=w2+1-rez1
	;w2+w1-b1*b2+d1/b3
	add ax,word ptr rez2			;ax = rezult
	
	mov word ptr rezult,ax
	
	call bin_ASCII
	vivod soob_o			;�뢮� �⢥� ࠢ��
	vivod ascval			;�뢮� �⢥�
;���������-----------------------------------------------------------------------
endm

logic macro b1,b2,b3,w1,w2,d1
	vivod s_f2
	;w2 or w1 xor b2 and b1or d1 and not b3
	mov bl,b3
	not bl
	and bx,word ptr d1
	mov al,b2
	and al,b1
	or ax,bx
	mov bx,w2
	or bx,w1
	xor ax,bx
	mov word ptr rezult,ax	
	
	call bin_ASCII
	vivod soob_o			;�뢮� �⢥� ࠢ��
	vivod ascval			;�뢮� �⢥�
endm

sdvigi macro b1,b2,b3,w1,w2,d1

;��� (2)
mov ax,w1
shl ax,2
mov word ptr rezult,ax
call bin_ASCII
vivod s_f3_1
vivod ascval
call cursor

;���(3)
mov ax, word ptr d1
sar ax,3
mov word ptr rezult,ax
call bin_ASCII
vivod s_f3_2
vivod ascval
call cursor
;���(4)
mov al,b1
rol ax,4
mov word ptr rezult,ax
call bin_ASCII
vivod s_f3_3
vivod ascval
call cursor
;���(5)�
mov cx,5
aq1:
clc
mov ax,w2
rcr ax,1
loop aq1
mov word ptr rezult,ax
call bin_ASCII
vivod s_f3_4
vivod ascval
call cursor

endm

clrscr macro ; ���⪠ ��࠭�
  mov ax,0600h	;\               						| ah=06(�ப��⪠),al=00(���� ��࠭)
  mov bh,02			; \              			 			| ��ଠ��� ��ਡ�� (�୮-����)
  mov cx,0000		;  ���⪠ ��࠭� 	 			| ������ ����� ������
  mov dx,314fh		; /              			 			| ������ �ࠢ�� ������
  int 10h				;/                						| ��।�� �ࠢ����� � BIOS
endm
cursor_m macro
	mov ah,02		;\                     					| ��⠭���� �����
	mov bh,00		; \                    					| ��࠭ 0
	mov dh,01		;  �ࠢ����� ����஬ 	| ��ப� 01
	mov dl,00		; /                    					| �⮫��� 00
	int 10h				;/                     					| ��।�� ��. � BIOS
endm
;------------------------------------------------------------------------
vivod macro soob ; �����⢫���� �뢮�� �� ��࠭ ᮮ�饭�� - soob
	mov ah,09h
	lea dx,soob
	int 21h
endm
;-------------------------------------------------------------------------
vvod macro name ; �����⢫���� �����
	mov ah,0ah
	lea dx,name
	int 21h
endm

; ������� �⥪�
stacksg segment para stack 'Stack' 		; ��砫� ᥣ���� �⥪�  (��४⨢� segment)	
  db 1024 dup (?) 						; १�ࢨ஢���� 1024 �祥� ����� ��� �⥪
stacksg ends 							; ����� ᥣ���� �⥪�  (��४⨢� ends)
; ������� ������

datasg segment para 'Data' ;��砫� ᥣ���� ������  (��४⨢� segment)

	tmp_logic db 'LOGIC',0ah,0dh,'$'


ifndef variant
	b1 			db 1
	b2 			db 1
	b3 			db 1
	w1 			dw 1
	w2 			dw 1
	d1 			dd 1
endif
ifdef variant	
	b1 			db 0
	b2 			db 0
	b3 			db 0
	w1 			dw 0
	w2 			dw 0
	d1 			dd 0
endif
	

	vvod_b 			label byte
	max_b 			db 4
	fact_b 			db 0
	field_b			db '0000','$'

	key 				label byte ; ���稪 ����
	max_k 			db 2
	fact_k 			db 0
	field_k 			db '00','$';

	vvod_w 			label byte
	max_w 			db 7
	fact_w 			db 0
	field_w 			db '0000000','$'

	vvod_d 			label byte
	max_d 			db 11
	fact_d 			db 0
	field_d 			db '00000000000','$'
	; �祩�� �����, �ᯮ��㥬� ��楤�ࠬ� ascii_binb, ascii_binw, ascii_bind, bin_ascii � ��.
	ascval 			db "00000000000000000000","$";���� ��ॢ����� ������
	binval			db 0                         ;१���� �८�ࠧ������
	asclen 			db 20                        ;����� ���������� ᨬ���쭮�� �᫠
	mult10 			db 1                         ;䠪�� 㬭������
	binval_w 		dw 0
	; ᨬ����� ����⠭�� (⥪��� ᮮ�饭��, �뤠������ �� ��࠭)
	soob_p 		db '��ࠢ���� 㢠����� ���짮��⥫�',0dh,0ah,'$'
	
	
	s_f1				db '���㫠 (w2+w1-b2*b1+d1/b3)',0ah,0dh,'$'
	s_f2				db '���㫠 (w2 or w1 xor b2 and b1or d1 and not b3)',0ah,0dh,'$'
	s_f3				db '���(2) ���(3), ��� (4), ��� (5)�','$'
	
	s_f3_1			db '���(2)',0ah,0dh,'$'
	s_f3_2			db '���(3)',0ah,0dh,'$'
	s_f3_3			db '��� (4)',0ah,0dh,'$'
	s_f3_4			db '��� (5)�',0ah,0dh,'$'
		
	s_b1 			db '������ b1',0ah,0dh,'$'
	s_b2 			db '������ b2',0ah,0dh,'$'
	s_b3				db '������ b3',0ah,0dh,'$'
	s_w1 			db '������ w1',0ah,0dh,'$'
	s_w2 			db '������ w2',0ah,0dh,'$'
	s_d1 			db '������ d1',0ah,0dh,'$'
	soob_o 		db '�⢥� �㤥� ࠢ��: ',0ah,0dh,'$'
	soob_vixod 	db "��� ��室� ������ ���� �������","$"
	soob 			db '�� ᢨ�����',0ah,0dh,'$'
	
	s_m0			db '�롥�� ⨯ ����樨',0ah,0dh,'$'
	s_m1			db '1 - ��䬨��᪨� ����樨',0ah,0dh,'$'
	s_m2			db '2 - �����᪨� ����樨',0ah,0dh,'$'
	s_m3			db '3 - ������',0ah,0dh,'$'
	s_m4			db '4 - ������ ��࠭',0ah,0dh,'$'
	s_mExit		db '0 - ��室',0ah,0dh,'$'
	s_mOp			db '������ ����� ����樨:','$'
	s_mErr			db'������ �᫠ � ��������� �� 0 �� 3',0ah,0dh,'$'
	
	perevod_cursora db 0dh,0ah,"$"
	oshibka_v 			db "�訡�� �����!(������ ��㣮� �᫮)","$"
	
	rezult 			dq 0
	rez1	 			dq 0
	rez2 				dq 0
	
	kol 				dq 0
	osh_v 			db 0
	prom 			dw 0
	promd 			dd 0
	fml 				dd 0
	
	
	
	;����� ��� 䠩��
	file_name 		db 'input.txt',0
	buffer 			db 7
	endline			db 0ah,0dh,'$'
	
	s_FError 		db ''�訡�� ������ 䠩��,0ah,0dh,'$'
		
	;----------------------------
	
	
 
datasg ends

codesg segment para 'Code'
begin proc far 											; ��砫� ������� ��楤��� (��४⨢� proc)

assume cs:codesg,ds:datasg,ss:stacksg					; ��४⨢�, ��⠭��������  ᮮ⢥��⢨� ᥣ������ ॣ���஢  ᥣ���⠬ (��४⨢� assume)
; �������, ����� ������ ���� � �� EXE-�ணࠬ��
	push 	ds
	xor 	ax,ax
	push 	ax
	mov 	ax,datasg
	mov 	ds,ax
;--------------------------------------------------
	clrscr 												; ���⪠ ��࠭� (�����)
	cursor_m											; �����饭�� �����
;-------------------------------------------------- 
	vivod soob_p 										;�뢮� �� ��࠭ ᮮ�饭��  '��ࠢ���� 㢠����� ���짮��⥫�'
;--------------------------------------------------

;��������� � ����������--------------------------------------
ifdef variant
	cin b1,b2,b3,w1,w2,d1						;���� ������ � ����������
endif	
;-------------------------------------------------------------------------------------
;������ �� �����------------------------------------------------------

;-------------------------------------------------------------------------------------
	menu b1,b2,b3,w1,w2,d1					;�맮� ����

	call cursor
	vivod soob_vixod


exit_programm:	
	mov ah,0
	int 16h
	
	
	ret
begin endp

;ASCII_binb           ;��楤�� ��ॢ��� �� ASCII � bin ��� ����
; ��砫� ��楤��� (��४⨢� proc)
ASCII_bin_b proc            ;��楤�� ��ॢ��� �� ASCII � bin ��� ���� 
; �室: ᯨ᮪ ��ࠬ��஢ vvod_b ������ ���� ��������;
; ��室: al=�᫮ � bin
; ���� ��楤���
	xor ax,ax
	xor cx,cx
	mov prom,ax
	mov osh_v,al
	mov al,fact_b
	mov cl,al
	dec al
	mov si,ax
	mov bx,1
met1_b:
	mov al,field_b[si]
	cbw
	cmp ax,30h
	jb error_b
	cmp ax,39h
	ja error_b
	and al,0fh
	mul bx
	add prom,ax
	mov ax,bx
	mov bx,10
	mul bx
	mov bx,ax
	dec si
	loop met1_b
	mov ax,prom
	jmp end_error_b
error_b:
	call cursor
	mov ah,09h
	lea dx,oshibka_v
	int 21h
	mov osh_v,1	
end_error_b:
	ret
; ����� ��楤���  (��४⨢� endp)
ASCII_bin_b endp
;====================================================================    
;ASCII_binw           ;��楤�� ��ॢ��� �� ASCII � bin ��� ᫮��
; �室: 		ᯨ᮪ ��ࠬ��஢ vvod_w ������ ���� ��������
; ��室:	ax = �᫮ � bin

ASCII_bin_w proc            ;��楤�� ��ॢ��� �� ASCII � bin ��� ᫮�� (�室: ᯨ᮪ ��ࠬ��஢ vvod_w ������ ���� ��������; ��室: ax=�᫮ � bin)
; ���� ��楤���
	xor ax,ax
	xor cx,cx
	mov prom,ax
	mov osh_v,al
	mov al,fact_w
	mov cl,al
	dec al
	mov si,ax
	mov bx,1
met1_w:
	mov al,field_w[si]
	cbw
	cmp ax,30h
	jb error_w
	cmp ax,39h
	ja error_w
	and al,0fh
	mul bx
	add prom,ax
	mov ax,bx
	mov bx,10
	mul bx
	mov bx,ax
	dec si
	loop met1_w
	mov ax,prom
	jmp end_error_w
error_w:
	call cursor
	mov ah,09h
	lea dx,oshibka_v
	int 21h
	mov osh_v,1	
end_error_w:
; ����� ��楤���  (��४⨢� endp)
	ret
ASCII_bin_w endp
;====================================================================
;ascii_bind            ;��楤�� ��ॢ��� �� ASCII � bin ��� �������� ᫮��
; �室: 		ᯨ᮪ ��ࠬ��஢ vvod_d ������ ���� ��������
; ��室:	dx:ax = �᫮ � bin
; ��砫� ��楤��� (��४⨢� proc)
ASCII_bin_d proc ;��楤�� ��ॢ��� �� ASCII � bin ��� ��. ᫮�� ��� �� 8086 (�室: ᯨ᮪ ��ࠬ��஢ vvod_d ������ ���� ��������; ��室: dx:ax=�᫮ � bin)
; ���� ��楤���
	xor ax,ax
	xor bx,bx
	xor cx,cx
	xor dx,dx
	mov word ptr promd,ax
	mov word ptr promd[2],ax
	mov word ptr fml[2],ax
	mov word ptr fml,1
	mov osh_v,al
	mov al,fact_d
	mov cl,al
	dec al
	mov si,ax
met1_d:
	mov bl,field_d[si]
	cmp bx,30h
	jb error_d
	cmp bx,39h
	ja error_d
	and bl,0fh
	mov dx,0
	mov ax,0
abd1:	cmp bl,0
	jz abd2
	add ax,word ptr fml
	adc dx,word ptr fml[2]
	dec bl
	jmp abd1
abd2:	add word ptr promd,ax
	adc word ptr promd[2],dx
	mov bl,9
	mov dx,word ptr fml[2]
	mov ax, word ptr fml
abd3:	cmp bl,0
	jz abd4
	add word ptr fml,ax
	adc word ptr fml[2],dx
	dec bl
	jmp abd3
abd4:		
	dec si
	loop met1_d
	mov dx,word ptr promd[2]
	mov ax,word ptr promd
	jmp end_error_d
error_d:
	call cursor
	mov ah,09h
	lea dx,oshibka_v
	int 21h
	mov osh_v,1	
end_error_d:
	ret
; ����� ��楤���  (��४⨢� endp)
ASCII_bin_d endp
;====================================================================
; bin_ascii            ;��楤�� ��ॢ��� �� bin � ASCII
; �室: 		rezult = ����筮� �᫮
; ��室:	ascval = �᫮ � ����� ascii
; ��砫� ��楤��� (��४⨢� proc)
bin_ASCII proc		;��楤�� ��ॢ��� �� bin � ASCII (�室: rezult=�᫮ � bin; ��室: ascval= �᫮ � ASCII)
; ���� ��楤���
	call clrascval		;�맮� ��楤��� ���⪨ ��ப���� ��६����� ascval
	lea si,ascval[19]
m1:
	cmp word ptr rezult[6],0
	jne m2
	cmp word ptr rezult[4],0
	jne m2
	cmp word ptr rezult[2],0
	jne m2
	cmp word ptr rezult,10
	jnb m2
	mov ax,word ptr rezult
	or al,30h
	mov [si],al
	dec si
	jmp m3
m2:
	sub word ptr rezult,10
	sbb word ptr rezult[2],0
	sbb word ptr rezult[4],0
	sbb word ptr rezult[6],0
	add word ptr kol,1
	adc word ptr kol[2],0
 	adc word ptr kol[4],0
	adc word ptr kol[6],0
	jmp m1
m3:
	cmp word ptr kol[6],0
	jne m4
	cmp word ptr kol[4],0
	jne m4
	cmp word ptr kol[2],0
	jne m4
	cmp word ptr kol,0
	jne m4
	ret
m4:
	mov ax,word ptr kol
	mov word ptr rezult,ax
	mov ax,word ptr kol[2]
	mov word ptr rezult[2],ax
	mov ax,word ptr kol[4]
	mov word ptr rezult[4],ax
	mov ax,word ptr kol[6]
	mov word ptr rezult[6],ax
	mov word ptr kol,0
	mov word ptr kol[2],0
	mov word ptr kol[4],0
	mov word ptr kol[6],0
	jmp m1
; ����� ��楤���  (��४⨢� endp)
bin_ASCII endp
;==================================================================== 
clrascval proc
      	mov cx,20
	mov si,19
clr1:	and ascval[si],30h
	dec si
	loop clr1
	ret
clrascval endp
;==================================================================== 
cursor proc		;��楤�� ��ॢ��� ����� �� ᫥�. ��ப�
	mov ah,09
	lea dx,perevod_cursora
	int 21h
	ret
cursor endp
;==================================================================== 
codesg ends
end begin