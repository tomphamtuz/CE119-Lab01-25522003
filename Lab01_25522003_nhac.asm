# $s0 = con tro mang cao do
# $s1 = con tro mang do dai
# $s2 = so not con lai
# $s3 = tong thoi luong du kien (ms)
# $s4 = moc thoi gian dau, sau do la thoi gian do duoc (ms)
# $s5 = do dai mot don vi nhip (ms)
# $s6 = cao do thuc cua not hien tai
# $s7 = thoi luong not hien tai (ms)

        .data
pitch:  .word 64, 64, 65, 67, 67, 65, 64, 62, 60, 60, 62, 64, 64, 62, 62
dur:    .word 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 1, 4
count:  .word 15
sp:     .asciiz " "
nl:     .asciiz "\n"
msg_tg: .asciiz "Tong du kien (ms): "
msg_do: .asciiz "Thoi gian do duoc (ms): "

        .text
main:   la   $s0, pitch
        la   $s1, dur
        lw   $s2, count
        li   $s3, 0
        li   $s5, 150
        li   $v0, 30
        syscall
        move $s4, $a0

lap:    blez $s2, xong
        lw   $s6, 0($s0)
        addiu $s6, $s6, 3
        lw   $s7, 0($s1)
        mul  $s7, $s7, $s5
        addu $s3, $s3, $s7
        move $a0, $s6
        li   $v0, 1
        syscall
        la   $a0, sp
        li   $v0, 4
        syscall
        move $a0, $s7
        li   $v0, 1
        syscall
        la   $a0, nl
        li   $v0, 4
        syscall
        move $a0, $s6
        move $a1, $s7
        li   $a2, 0
        li   $a3, 100
        li   $v0, 33
        syscall
        addiu $s0, $s0, 4
        addiu $s1, $s1, 4
        addiu $s2, $s2, -1
        j    lap

xong:   li   $v0, 30
        syscall
        subu $s4, $a0, $s4
        la   $a0, msg_tg
        li   $v0, 4
        syscall
        move $a0, $s3
        li   $v0, 1
        syscall
        la   $a0, nl
        li   $v0, 4
        syscall
        la   $a0, msg_do
        li   $v0, 4
        syscall
        move $a0, $s4
        li   $v0, 1
        syscall
        la   $a0, nl
        li   $v0, 4
        syscall
        li   $v0, 10
        syscall