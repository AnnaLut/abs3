

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_ZAY_COMISS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_ZAY_COMISS ***

   CREATE SEQUENCE  BARS.S_ZAY_COMISS  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 141 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_ZAY_COMISS ***
grant SELECT                                                                 on S_ZAY_COMISS    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_ZAY_COMISS.sql =========*** End *
PROMPT ===================================================================================== 
