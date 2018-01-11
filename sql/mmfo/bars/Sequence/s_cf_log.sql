

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_CF_LOG.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_CF_LOG ***

   CREATE SEQUENCE  BARS.S_CF_LOG  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 866784 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_CF_LOG ***
grant ALTER,SELECT                                                           on S_CF_LOG        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_CF_LOG.sql =========*** End *** =
PROMPT ===================================================================================== 
