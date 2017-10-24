

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DDBS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DDBS ***

   CREATE SEQUENCE  BARS.S_DDBS  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_DDBS ***
grant SELECT                                                                 on S_DDBS          to ABS_ADMIN;
grant SELECT                                                                 on S_DDBS          to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DDBS.sql =========*** End *** ===
PROMPT ===================================================================================== 
