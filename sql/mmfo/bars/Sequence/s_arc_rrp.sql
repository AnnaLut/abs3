

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_ARC_RRP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_ARC_RRP ***

   CREATE SEQUENCE  BARS.S_ARC_RRP  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 850494843 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_ARC_RRP ***
grant SELECT                                                                 on S_ARC_RRP       to ABS_ADMIN;
grant SELECT                                                                 on S_ARC_RRP       to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_ARC_RRP.sql =========*** End *** 
PROMPT ===================================================================================== 
