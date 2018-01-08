

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_BANK_METALS$LOCAL_UPD.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_BANK_METALS$LOCAL_UPD ***

   CREATE SEQUENCE  BARS.S_BANK_METALS$LOCAL_UPD  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 599125 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_BANK_METALS$LOCAL_UPD ***
grant SELECT                                                                 on S_BANK_METALS$LOCAL_UPD to ABS_ADMIN;
grant SELECT                                                                 on S_BANK_METALS$LOCAL_UPD to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_BANK_METALS$LOCAL_UPD.sql =======
PROMPT ===================================================================================== 
