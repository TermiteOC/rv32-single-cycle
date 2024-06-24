
.data 
arrayA:	     .word 0, 0, 0

.text
main:
        # s0 = endereço-base, s1 = i, s2 = entrada, s5 = j = 1
        
        la    s0, arrayA      # carrega o endereco de arrayA em s0, 
                              # o endereco-base
        addi  s1, zero, 0     # i = 0
        addi  s5, zero, 1     # j = 1
        
        addi  s2, zero, 5     # s2 = 5  
        add   t0, s1, s1      # t0 = 2*i
        add   t0, t0, t0      # t0 = 4*i
        add   t0, s0, t0      # t0 = addr-base + 4*i = addr de A[i]
        sw    s2, 0(t0)       # A[i] = s2 = 5
        slt   t0, s1, s5      # se i < 1, t0 = 1, se nao, t0 = 0
        beq   t0, zero, Exit1 # se t0 = 0, vai para Exit1
        
        add   s1, s1, s5      # i = i + 1 = 1
        sub   s2, s2, s5      # s2 = s2 - j = 4
        add   t0, s1, s1      # t0 = 2*i
        add   t0, t0, t0      # t0 = 4*i
        add   t0, s0, t0      # t0 = addr-base + 4*i = addr de A[i]
        sw    s2, 0(t0)       # A[i] = s2 = 4
        slt   t0, s1, s5      # se i < 1, t0 = 1, se nao, t0 = 0
        beq   t0, zero, Exit1 # se t0 = 0, vai para Exit1
        
        add   s1, s1, s5      # i = i + j = 2
        sub   s2, s2, s5      # s2 = s2 - j = 3
        add   t0, s1, s1      # t0 = 2*i
        add   t0, t0, t0      # t0 = 4*i
        add   t0, s0, t0      # t0 = addr-base + 4*i = addr de A[i]
        sw    s2, 0(t0)       # A[i] = s2 = 3
        
Exit1:  
        add   t0, s1, s1      # t0 = 2*i, i = 1
        add   t0, t0, t0      # t0 = 4*i
        add   t0, s0, t0      # t0 = addr-base + 4*i = addr de A[i]
        lw    t1, 0(t0)       # t1 = A[i] ====== 4
        
        sub   s1, s1, s5      # i = i - 1 = 0
        add   t0, s1, s1      # t0 = 2*i
        add   t0, t0, t0      # t0 = 4*i
        add   t0, s0, t0      # t0 = addr-base + 4*i = addr de A[i]
        lw    t2, 0(t0)       # t2 = A[i] ====== 5
        
        add   t3, t1, t2      # t1 + t2 = 4 + 5
        
End:    nop                   # sem operacao
