.globl button

.text

button:
    addi sp, sp, -28
    sw ra, 0(sp) #on save tout ce qui est suceptible d'etre utilisé
    sw a0, 4(sp) #on save tout ce qui est suceptible d'etre utilisé
    sw a1, 8(sp) #on save tout ce qui est suceptible d'etre utilisé
    sw t0, 12(sp) #on save tout ce qui est suceptible d'etre utilisé
    sw t1, 16(sp) #on save tout ce qui est suceptible d'etre utilisé
    sw t2, 20(sp) #on save tout ce qui est suceptible d'etre utilisé
    sw t3, 24(sp) #on save tout ce qui est suceptible d'etre utilisé

    #config GPIO3  
    li t0, 0x60009010  #adresse de IO_MUX_GPIO3_REG
    li t1, 0x00000300 #on configure en in avec resistance de pull up (il faut connecter le port GPIO3 au GND afin d'activer l'interupteur)
    sw t1, 0(t0) #j'ecrit ma configuration dans le registre adequat

    

    mv t2, x0 
    li t3, 1 #t3 sera le terme actuel de fibonacci et il sera set a 1 car il ne fait aucun sens de faire clignoter 0 fois une led

    boucle:

    li t0, 0x6000403c          
    lw t1, 0(t0)                 
    andi t1, t1, 8 #on met tout les pin qui ne sont pas GPIO3 a 0 avec un masque


                
    bnez t1, boucle  #si t1 = 0, continuer la boucle

    mv a0, t3 #on rentre la valeur de fibonacci actuelle dans le registre parametre de fonction a0
    jal ra, blink_Nfois #j'apelle la fonction blink_Nfois afin d'effectuer le nombre de blink 
    add t3, t3, t2 #on calculer Fn+1
    sub t2, t3, t2 #on met dans t2 la valeur de Fn anciennement dans t3
    jal ra, wait #on wait afin d'avoir la meme cadence de clignetement que dans blinkFib
    jal ra, wait
    jal ra, wait
    jal ra, wait
    j boucle #on retourne dans la boucle a tout les coup car c'est un while 1 qu'on a fait

    #en soit enregistrer dans la pile la valeur des registre pour les resave deriere ne sert a rien car on ne quitte jamais cette fonction mais on sais jamais
    

    lw t3, 24(sp) 
    lw t2, 20(sp)
    lw t1, 16(sp)
    lw t0, 12(sp)
    lw a1, 8(sp)
    lw a0, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 28

jalr a0, 0(ra) # Retourner à l'adresse de retour
