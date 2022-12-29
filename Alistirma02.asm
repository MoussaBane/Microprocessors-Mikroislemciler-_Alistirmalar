
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; Bazi Aciklamalar !!!    
  
;Bu ornekte 32 bitlik iki sayiyi (MUL emiri kullanmadan) ...  
;Carpan programidir.

;32 bitlik sayilarimiz icin bellek hucreleri kullanacagiz

;Ilk sayimizin alt 16 biti [1100h][1101h] bellek hucrelerinde saklayacagiz
;Ilk sayimizin ust 16 biti ise [1102h][1103h] bellek hucrelerinde saklayacagiz

;Ikinci sayimizin alt 16 biti [1104h][1105h] ...
;Ikinci sayimizin ust 16 biti ise [1106h][1107h] ...

;Sonucu ise DX:CX:BX:AX registerlerinde tutacagiz -- "sirasiyla"

;Dongu sayacimiz ise BP'i uzerinde oluyor ve 32 decimal veya 20h hex defa donecek 
 
basla:  
    ;Ilk sayimizi bu word ptr buyuklukta 2 tane bellek hucrelerinde sakliyoruz
    MOV SI, WORD PTR [1100h]   ;Sayi1'in en anlamsiz 2-byte
    MOV DI, WORD PTR [1102h]   ;Sayi1'in en anlamli  2-byte 
    ;Sonucumuzu tutacak registerlerimizi sifirlaniyor
    XOR AX, AX
    XOR BX, BX
    XOR CX, CX
    XOR DX, DX
    MOV BP, 32                ;Sayacimiz tek tek carpanin 32 bitin uzerinden gececek

dongu:                     ;Carpilan ile Carpimin toplamlari yapilan
    ;Carpanin ilgili biti 1 olup olmadigini kontrol edilir
    TEST SI, 1                ;Logical AND between all bits of two operands -- Result is not stored anywhere
    JZ  kaydir                ;0 ise toplamaya gerek kalmadan sadece kaydirma yapilsin
    ADD CX, WORD PTR[1104h]   ;Sayi2'inin en anlamsiz 2-byte
    ADC DX, WORD PTR[1106h]   ;Sayi2'inin en anlamli  2-byte

kaydir:
    ;Carpimin ve Carpanin bitlerinde kaydirma islemi gerceklestirilir                  
    RCR DX, 1                 ;Rotate operand1 right through Carry Flag. The number of rotates is set by operand2.
    RCR CX, 1
    RCR BX, 1
    RCR AX, 1
    RCR DI, 1
    RCR SI, 1
    DEC BP                    ;Sayacimizi decrement edilir
    JNZ  dongu                ;Sayacimiz 0 olana kadar dongu icine donsun

    ret




