

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/EBK_PRC_QUALITY_SEQ.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  sequence EBK_PRC_QUALITY_SEQ ***

   CREATE SEQUENCE  BARS.EBK_PRC_QUALITY_SEQ  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 6 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  EBK_PRC_QUALITY_SEQ ***
grant SELECT                                                                 on EBK_PRC_QUALITY_SEQ to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/EBK_PRC_QUALITY_SEQ.sql =========**
PROMPT ===================================================================================== 
