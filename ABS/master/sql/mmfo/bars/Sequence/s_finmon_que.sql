

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_FINMON_QUE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_FINMON_QUE ***

   CREATE SEQUENCE  BARS.S_FINMON_QUE  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 851374 CACHE 2 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_FINMON_QUE ***
grant SELECT                                                                 on S_FINMON_QUE    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_FINMON_QUE    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_FINMON_QUE.sql =========*** End *
PROMPT ===================================================================================== 
