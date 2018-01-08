

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_CORPS_ACC.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_CORPS_ACC ***

   CREATE SEQUENCE  BARS.S_CORPS_ACC  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 4319 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_CORPS_ACC ***
grant SELECT                                                                 on S_CORPS_ACC     to ABS_ADMIN;
grant SELECT                                                                 on S_CORPS_ACC     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_CORPS_ACC.sql =========*** End **
PROMPT ===================================================================================== 
