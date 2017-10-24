

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_ZAY_BAOP.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_ZAY_BAOP ***

   CREATE SEQUENCE  BARS.S_ZAY_BAOP  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 655 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_ZAY_BAOP ***
grant SELECT                                                                 on S_ZAY_BAOP      to OPERKKK;
grant SELECT                                                                 on S_ZAY_BAOP      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_ZAY_BAOP.sql =========*** End ***
PROMPT ===================================================================================== 
