

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_STO_IDG.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_STO_IDG ***

   CREATE SEQUENCE  BARS.S_STO_IDG  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_STO_IDG ***
grant SELECT                                                                 on S_STO_IDG       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_STO_IDG.sql =========*** End *** 
PROMPT ===================================================================================== 
