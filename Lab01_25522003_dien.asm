# $s0 = so kWh nhap vao
# $s1 = con tro mang limits
# $s2 = con tro mang prices
# $s4 = tong tien

        .data
limits: .word 50, 100, 200, 300, 400, 9999
prices: .word 1660, 1720, 2010, 2560, 2910, 3060
msg_in:  .asciiz "Nhap so kWh (0..9999): "
msg_err: .asciiz "Gia tri khong hop le, nhap lai.\n"
msg_out: .asciiz "Tien dien: "
msg_end: .asciiz " dong\n"

        .text
main:
nhap:   la   $a0, msg_in
        li   $v0, 4
        syscall
        li   $v0, 5
        syscall
        move $s0, $v0
        sltiu $t0, $s0, 10000
        bne  $t0, $zero, hople
        la   $a0, msg_err
        li   $v0, 4
        syscall
        j    nhap

hople:  la   $s1, limits
        la   $s2, prices
        li   $s4, 0
        li   $t0, 0

lap:    lw   $t2, 0($s1)
        lw   $t3, 0($s2)
        slt  $t4, $t2, $s0
        beq  $t4, $zero, cuoi
        subu $t5, $t2, $t0
        mul  $t5, $t5, $t3
        addu $s4, $s4, $t5
        move $t0, $t2
        addiu $s1, $s1, 4
        addiu $s2, $s2, 4
        j    lap

cuoi:   subu $t5, $s0, $t0
        mul  $t5, $t5, $t3
        addu $s4, $s4, $t5

        la   $a0, msg_out
        li   $v0, 4
        syscall
        move $a0, $s4
        li   $v0, 1
        syscall
        la   $a0, msg_end
        li   $v0, 4
        syscall
        li   $v0, 10
        syscall