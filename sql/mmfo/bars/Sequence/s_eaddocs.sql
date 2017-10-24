

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_EADDOCS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_EADDOCS ***

   CREATE SEQUENCE  BARS.S_EADDOCS  MINVALUE 0 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 31533 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_EADDOCS ***
grant SELECT                                                                 on S_EADDOCS       to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_EADDOCS.sql =========*** End *** 
PROMPT ===================================================================================== 
