

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_STO_DET.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_STO_DET ***

   CREATE SEQUENCE  BARS.S_STO_DET  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 339826 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_STO_DET ***
grant SELECT                                                                 on S_STO_DET       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_STO_DET.sql =========*** End *** 
PROMPT ===================================================================================== 
