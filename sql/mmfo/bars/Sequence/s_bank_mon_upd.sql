

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_BANK_MON_UPD.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_BANK_MON_UPD ***

   CREATE SEQUENCE  BARS.S_BANK_MON_UPD  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 3590 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_BANK_MON_UPD ***
grant SELECT                                                                 on S_BANK_MON_UPD  to ABS_ADMIN;
grant SELECT                                                                 on S_BANK_MON_UPD  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_BANK_MON_UPD.sql =========*** End
PROMPT ===================================================================================== 
