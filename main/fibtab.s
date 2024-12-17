
.globl fibtab

.text


fibtab:
    addi sp, sp, -24
    sw ra, 0(sp) #on save tout ce qui est suceptible d'etre utilisé
    sw a0, 4(sp) #on save tout ce qui est suceptible d'etre utilisé
    sw a1, 8(sp) #on save tout ce qui est suceptible d'etre utilisé
    sw t0, 12(sp) #on save tout ce qui est suceptible d'etre utilisé
    sw t1, 16(sp) #on save tout ce qui est suceptible d'etre utilisé
    sw t2, 20(sp) #on save tout ce qui est suceptible d'etre utilisé

    beqz a0, finishfibtab #je ne sais pas quoi faire avec un tableau de taille 0

    mv t0, a1 #on recupere l'adresse du tableau dans t0

    addi t2, x0, 1 #contiendra chaque future valeur de fibo en avance en mode, est initalisée a 1 pour les 2 premiere valeurs
    sw t2, 0(t0) #on sw 1
    addi a0, a0, -1
    beqz a0, finishfibtab #on verifie sur la taille du tableau est 1 auquel cas on peut deja jump
    sw t2, 4(t0) #on sw 1
    addi a0, a0, -1
    
    beqz a0, finishfibtab #on verifie sur la taille du tableau est 2 auquel cas on peut deja jump
    addi t0, t0, 8
    mv t1, t2
    bouclefibtab:
        add t1, t2, t1
        sw t1, 0(t0)
        mv t1, t2
        lw t2, 0(t0)
        addi t0, t0, 4
        addi a0, a0, -1
    beqz a0, finishfibtab
    j bouclefibtab

    finishfibtab:
    lw t2, 20(sp)
    lw t1, 16(sp)
    lw t0, 12(sp)
    lw a1, 8(sp)
    lw a0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 24

jalr x0, 0(ra)


