

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_ACC_TARIF_ARC.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_ACC_TARIF_ARC ***

   CREATE SEQUENCE  BARS.S_ACC_TARIF_ARC  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 432048 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_ACC_TARIF_ARC ***
grant SELECT                                                                 on S_ACC_TARIF_ARC to ABS_ADMIN;
grant SELECT                                                                 on S_ACC_TARIF_ARC to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_ACC_TARIF_ARC.sql =========*** En
PROMPT ===================================================================================== 
