
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt


MOV SI,1100H ;SI registeri sayi arrayimizin pointeri olarak kullanacagiz
             ;SI<-1100H                              
                          
MOV BYTE PTR [SI],0AH    ;Siralacagimiz eleman sayisi 10 oldugu icin 0A hexadecimal olarak yaziyoruz
                         ;Ve 1100H bellek hucresinde tutuyoruz 
                         ;[SI + 1] Bellek hucresinden [SI + 10] bellek hucresine kadar 10 tane hucre olarak siralamak istedigimiz 10 sayi icermektedir      
MOV BYTE PTR [SI+ 1],15H ;[1101H] <- 15H 
MOV BYTE PTR [SI+ 2],02H ;[1102H] <- 02H 
MOV BYTE PTR [SI+ 3],1FH ;[1103H] <- 1FH 
MOV BYTE PTR [SI+ 4],0EH ;[1104H] <- 0EH 
MOV BYTE PTR [SI+ 5],0FFH;[1105H] <- 0FFH 
MOV BYTE PTR [SI+ 6],05H ;[1106H] <- 05H 
MOV BYTE PTR [SI+ 7],0EFH;[1107H] <- 0EFH 
MOV BYTE PTR [SI+ 8],10H ;[1108H] <- 10H 
MOV BYTE PTR [SI+ 9],23H ;[1109H] <- 23H 
MOV BYTE PTR [SI+ 10],01H;[110AH] <- 01H 




      
org 100h  ;Programimizin komutlari yerlestirme baslangic bellek hucresi 




    MOV SI,1100H  ;Pointerimiz SI
    MOV CL,[SI]   ;[SI]'deki eleman sayisimizi CL registerinde tutuyoruz 
    DEC CL        ;CL'i decrement yapiyoruz yani 10 sayimiz varsa tekar donme sayimiz 10-1=9 olur
Tekrar:
    MOV SI,1100H  ;SI pointerimizi initialize ediyoruz
    MOV CH,[SI]   ;[SI]'deki eleman sayisimizi CH registerinde tutuyoruz
    DEC CH        ;CH'i decrement ediyoruz 10-1=9 yani CH registeri kiyaslama(compare) sayisimizi tutuyor 
    INC SI        ;SI'i incremet ediyoruz yani ilk sayimizin bellek hucre numarasi tutulacak
Kiyasla:
    MOV AL,[SI]   ;[SI]'deki sayimiz AL registerinde tutuyoruz
    INC SI        ;SI'i increment ediyoruz
    CMP AL,[SI]   ;Burada kiyaslama islemi gerceklestirilir, ilk elemani kendisinden bir sonraki elemani ile kiyaslanir
    JC Bastan     ;CMP calistirildiktan sonra yani cikartma sonucunda C(carry) bayragi set edilirse Bastan labeline jump edilsin
    XCHG AL,[SI]  ;Jump edilmezse kiyaslanan elemanlarin ilki ikincisinden daha buyuk anlamina gelir
    XCHG AL,[SI-1];XCHG komutu ile yer degistirme yapiyoruz
Bastan:
    DEC CH        ;Kiyaslama sayisi decrement ediyoruz 
    JNZ Kiyasla   ;Kalan kiyaslama sayisi bitmezse yani 0 degilse kiyaslama islemine devam edilsin
    DEC CL        ;Elemanlarin arasina gecme sayisi da decrement edilsin 
    JNZ Tekrar    ;CL 0'dan farki ise Tekrar labeline tekrar gitsin
   
    

HLT



;MOV SI,1100H 

;MOV BYTE PTR [SI],10H 
;MOV BYTE PTR [SI+ 1],15H
;MOV BYTE PTR [SI+ 2],02H
;MOV BYTE PTR [SI+ 3],1FH
;MOV BYTE PTR [SI+ 4],0EH
;MOV BYTE PTR [SI+ 5],0FFH 
;MOV BYTE PTR [SI+ 6],02H
;MOV BYTE PTR [SI+ 7],0EFH
;MOV BYTE PTR [SI+ 8],10H
;MOV BYTE PTR [SI+ 9],23H
;MOV BYTE PTR [SI+ 10],01H
