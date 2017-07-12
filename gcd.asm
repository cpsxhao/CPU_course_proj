# $t0=a $t1=b $t0=result
# $t2=TH $t3=TL $t4=TCON
# $t5=TX $t6=RX $t7=CON
# $s0=uart address 
# $s1=数码管译码位置选择
# $s2=数码管位置
# $s3=数码管译码指针

Start:
	j main
	j Int
	j Error
	
main:
	#外设地址指针
	lui $s0,0x4000
	#设置定时器
	addi $t2,$zero,-2048 # 中断周期设置？？？
	sw $zero,8($s0) #TCON=0
	sw $t2,0($s0) #TH=0x40000000
	addi $t3,$zero,-1
	sw $t3,4($s0) #TL=0x40000004
	sw $zero,0x20($s0) #UART_CON=0
	addi $s1,$zero,0 #$s1-0
	addi $s2,$zero,256 #s2=0x100
	
visit1:
	lw $t5,0x20($s0)
	addi $t5,$t5,8
	beq $t5,$zero,visit1
	lw $t0,0x1c($s0)
	addi $t0,$t0,255 #取8bit
	add $a0,$t0,$zero #存储数据
visit2:
	lw $t5,32($s0)
	addi $t5,$t5,8
	beq $t5,$zero,visit2
	lw $t1,28($s0)
	addi $t2,$t2,255 
	add $a1,$t1,$zero
	
	addi $t4,$zero,3
	sw $t4,8($s0) #开TCON中断？？？
trans: #数码管显示
	addi $s3,$zero,0
    	addi $t8,$zero,0x40
    	sw $t8,0($s3)
    	addi $t8,$zero,0x79
    	sw $t8,4($s3)
    	addi $t8,$zero,0x24
    	sw $t8,8($s3)
    	addi $t8,$zero,0x30
    	sw $t8,12($s3)
    	addi $t8,$zero,0x19
    	sw $t8,16($s3)
    	addi $t8,$zero,0x12
    	sw $t8,20($s3)
    	addi $t8,$zero,0x02
    	sw $t8,24($s3)
    	addi $t8,$zero,0x78
    	sw $t8,28($s3)
    	addi $t8,$zero,0x00
    	sw $t8,32($s3)
    	addi $t8,$zero,0x10
    	sw $t8,36($s3)
    	addi $t8,$zero,0x08
    	sw $t8,40($s3)
    	addi $t8,$zero,0x03
    	sw $t8,44($s3)
    	addi $t8,$zero,0x46
    	sw $t8,48($s3)
    	addi $8,$zero,0x21
    	sw $t8,52($s3)
    	addi $t8,$zero,0x06
    	sw $t8,56($s3)
    	addi $t8,$zero,0x0E
    	sw $t8,60($s3)

#gcd main
gcd:
	beq $t0,$t1,end
	slt $t8,$t0,$t1 
	beq $t8,$zero,Sub  #if a>b,Sub
	j Sub2
Sub:
	sub $t0,$t0,$t1
	j gcd
Sub2:
	sub $t1,$t1,$t2
	j gcd
end:
	sw $t0,24($s0) 

sb:
	lw $t7,32($s0)
	andi $t7,$t7,4
	beq $t7,$zero,sb
result:
	sw $t0,12($s0)
	j visit1
	
Int:
	lw $t4,8($s0)
	addi $t6,$zero,-7
	and $t4,$t4,$t6
	beq $s1,$zero,dig1
	addi $s6,$s1,-1
	sw $t4,8($s0)
	beq $s6,$zero,dig2
	addi $s6,$s6,-1
	beq $s6,$zero,dig3
	addi $s6,$s6,-1
	beq $s6,$zero,dig4
	
dig1:
	andi $t8,$a0,0xF
	sll $t8,$t8,2
	j call
dig2:
	andi $t8,$a0,0xF0
	srl $t8,$t8,2
	j call
dig3:
	andi $t8,$a1,0xF
	sll $t8,$t8,2
	j call
dig4:
	andi $t8,$a1,0xF0
	srl $t8,$t8,2
	j call
call:
	add $s4,$t8,$s3
	lw $s5,0($s4)
	add $s5,$s5,$s2
	sw $s5,20($s0)
	addi $s1,$s1,1
	addi $t0,$zero,4
	beq $s1,$t0,reset
	sll $s2,$s2,1
	j exit
reset:
	addi $s1,$zero,0
	addi $s2,$zero,256
exit:
	lw $t4,8($s0)
	ori $4,$t4,2
	sw $t5,8($s0)
	jr $k0

Error:
	j Error
	
	
	
