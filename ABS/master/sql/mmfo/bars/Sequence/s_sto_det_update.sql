

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_STO_DET_UPDATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_STO_DET_UPDATE ***

   CREATE SEQUENCE  BARS.S_STO_DET_UPDATE  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 14333 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_STO_DET_UPDATE ***
grant SELECT                                                                 on S_STO_DET_UPDATE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_STO_DET_UPDATE.sql =========*** E
PROMPT ===================================================================================== 
