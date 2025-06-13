# Program MIPS Assembly untuk menghitung luas bujur sangkar
# Tugas T15 - Organisasi dan Arsitektur Komputer
# Kelompok: 2 - DS-03-01

.data
    # Informasi awal
    info1: .asciiz "DS-03-01 Kelompok 2"
    info2: .asciiz "Ikfan Putra Maesru Dwi Pradana  1206230010"
    info3: .asciiz "Khosyi Kafi Kirdiat             1206230029"
    info4: .asciiz "Madina Nilasari                 1206230057"
    info5: .asciiz "Sabrina Salva Kalimatin Sava    1206230061"
    info6: .asciiz "Dwi Bagas Iyantoro              1206230070"
    info7: .asciiz "Untuk keluar dari program, masukkan angka 1001"
    
    # Input prompt
    input_sisi1: .asciiz "Masukkan sisi pertama: "
    input_sisi2: .asciiz "Masukkan sisi kedua: "

    # Error messages
    error_negatif: .asciiz "ERROR: Bilangan harus positif (> 0)!\n"
    error_berbeda: .asciiz "ERROR: Kedua sisi harus sama untuk bujur sangkar!\n"

    # Output
    hasil_luas: .asciiz "Luas bujur sangkar: "
    kategori_kecil: .asciiz "Kategori: BUJUR SANGKAR KECIL\n"
    kategori_sedang: .asciiz "Kategori: BUJUR SANGKAR SEDANG\n"
    kategori_besar: .asciiz "Kategori: BUJUR SANGKAR BESAR\n"
    
    newline: .asciiz "\n"

.text
.globl main

main:
    # Tampilkan info kelompok
    li $v0, 4
    la $a0, info1
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 4
    la $a0, info2
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 4
    la $a0, info3
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 4
    la $a0, info4
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 4
    la $a0, info5
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 4
    la $a0, info6
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 4
    la $a0, info7
    syscall
    li $v0, 4
    la $a0, newline
    syscall

program_loop:
    jal prosedur_masukan
    beq $s0, 1001, exit_program
    jal prosedur_proses
    jal prosedur_keluaran
    j program_loop

exit_program:
    li $v0, 10
    syscall

# ========== PROSEDUR MASUKAN ==========
prosedur_masukan:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

input_loop:
    li $v0, 4
    la $a0, input_sisi1
    syscall

    li $v0, 5
    syscall
    move $s0, $v0

    beq $s0, 1001, masukan_selesai
    blez $s0, error_input_negatif

    li $v0, 4
    la $a0, input_sisi2
    syscall

    li $v0, 5
    syscall
    move $s1, $v0

    blez $s1, error_input_negatif
    bne $s0, $s1, error_input_berbeda

    j masukan_selesai

error_input_negatif:
    li $v0, 4
    la $a0, error_negatif
    syscall
    j input_loop

error_input_berbeda:
    li $v0, 4
    la $a0, error_berbeda
    syscall
    j input_loop

masukan_selesai:
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

# ========== PROSEDUR PROSES ==========
prosedur_proses:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    li $s2, 0
    li $t0, 0

multiply_loop:
    beq $t0, $s0, multiply_done
    add $s2, $s2, $s1
    addi $t0, $t0, 1
    j multiply_loop

multiply_done:
    slti $t1, $s2, 500
    bne $t1, $zero, kategori_kecil_set

    slti $t1, $s2, 1000
    bne $t1, $zero, kategori_sedang_set

    li $s3, 3
    j proses_selesai

kategori_kecil_set:
    li $s3, 1
    j proses_selesai

kategori_sedang_set:
    li $s3, 2

proses_selesai:
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

# ========== PROSEDUR KELUARAN ==========
prosedur_keluaran:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    li $v0, 4
    la $a0, hasil_luas
    syscall

    li $v0, 1
    move $a0, $s2
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    beq $s3, 1, tampil_kecil
    beq $s3, 2, tampil_sedang
    beq $s3, 3, tampil_besar

tampil_kecil:
    li $v0, 4
    la $a0, kategori_kecil
    syscall
    j keluaran_selesai

tampil_sedang:
    li $v0, 4
    la $a0, kategori_sedang
    syscall
    j keluaran_selesai

tampil_besar:
    li $v0, 4
    la $a0, kategori_b_
