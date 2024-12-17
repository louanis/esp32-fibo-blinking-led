.globl on
.globl off
.globl wait
.globl blink_Nfois
.globl blink_fib

.text

on:
    addi sp, sp, -16
    sw ra, 0(sp) #on save l'adresse de retour dans la memoire
    sw a0, 4(sp)
    sw a1, 8(sp)
    sw a2, 12(sp)

    li a2, 0x400 #Le bit correspondant au GPIO a allumer est set a 1 (le GPIO 10 dans mon cas)

    #enable
    li a0, 0x60004024
    lw a1, 0(a0)
    or a1, a1, a2
    sw a1, 0(a0)


    #allume la led
    li a0, 0x60004008
    lw a1, 0(a0)
    or a1, a1, a2
    sw a2, 0(a0)

    lw a2, 12(sp)
    lw a1, 8(sp)
    lw a0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 16
jalr x0, 0(ra)

off:
    addi sp, sp, -20
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)
    sw t2, 12(sp)

    li t2, 0x400

    #enable
    li t0, 0x60004020
    lw t1, 0(t0)
    or t1, t1, t2
    sw t1, 0(t0)


    #eteindre la led
    li t0, 0x6000400c
    lw t1, 0(t0)
    or t1, t1, t2
    sw t2, 0(t0)

    lw t2, 12(sp)
    lw t1, 8(sp)
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 20
jalr x0, 0(ra)


blink_fib:
    addi sp, sp, -24
    sw ra, 0(sp) #on save l'adresse de retour dans la memoire
    sw a0, 4(sp) #on save la taille du tableau dans la memoire
    sw a1, 8(sp) #on save les parametres de la fonction dans la memoire
    sw t0, 12(sp)
    sw t1, 16(sp) #t1 sera notre compteur
    sw t2, 20(sp) #t2 sera le registre qui stockera chaque valeur du tableau en entrée 1 a 1

    mv t0, a1
    mv t1, a0

    loop_blink_fib:

        lw a0, 0(t0) #on rentre la valeur de fibonacci actuelle dans le registre parametre de fonction a0
        jal ra, blink_Nfois #j'apelle la fonction blink_Nfois afin d'effectuer le nombre de blink 
        jal ra, wait #on wait afin de differencier la frequence de clignottement dans le meme appel de blink_Nfois
        jal ra, wait
        jal ra, wait
        jal ra, wait

        addi t0, t0, 4
        addi t1,t1,-1
    beqz t1, end_loop_blink_fib
    j loop_blink_fib

    end_loop_blink_fib:

    lw t2, 20(sp)
    lw t1, 16(sp)
    lw t0, 12(sp)
    lw a1, 8(sp)
    lw a0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 24
jalr x0, 0(ra)


blink_Nfois:
    addi sp, sp, -16
    sw ra, 0(sp)
    sw a0, 4(sp)


    blink_loop:
        beqz a0, blink_end
        jal ra, on
        jal ra, wait
        jal ra, off
        jal ra, wait
        addi a0, a0, -1
    beqz a0, blink_end
    j blink_loop


    blink_end:
    lw a0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 16
jalr x0, 0(ra)









#0.25 sec de delai
wait:
    addi sp, sp, -16
    sw ra, 0(sp)
    sw t0, 4(sp)

    li t0, 6666667

    boucle_wait:
        addi t0, t0, -1
    beqz t0, boucle_fin
    j boucle_wait

    boucle_fin:
    lw t0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 16
jalr x0, 0(ra)