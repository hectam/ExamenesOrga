# Instrucciones a agregar
- addi
- ori
- andi
- lui

# Nuevas señales de control
- ImmExtend
  Si es 0 hay que hacer zero extend del immediate value.
  Si es 1 hay que hacer sign extend del immediate value.

- MemToReg es de 2 bits
  Si es 2 significa que el Write Data viene de la instrucción LUI.
  Los otros valores quedan igual que antes.
