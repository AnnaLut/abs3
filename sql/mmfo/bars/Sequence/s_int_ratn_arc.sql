

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_INT_RATN_ARC.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_INT_RATN_ARC ***

   CREATE SEQUENCE  BARS.S_INT_RATN_ARC  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 19804963 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_INT_RATN_ARC ***
grant SELECT                                                                 on S_INT_RATN_ARC  to ABS_ADMIN;
grant SELECT                                                                 on S_INT_RATN_ARC  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_INT_RATN_ARC.sql =========*** End
PROMPT ===================================================================================== 
