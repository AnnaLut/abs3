

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_STO_IDS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_STO_IDS ***

   CREATE SEQUENCE  BARS.S_STO_IDS  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 142096 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_STO_IDS ***
grant SELECT                                                                 on S_STO_IDS       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_STO_IDS.sql =========*** End *** 
PROMPT ===================================================================================== 
