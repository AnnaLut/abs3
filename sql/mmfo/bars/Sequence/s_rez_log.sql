

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_REZ_LOG.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_REZ_LOG ***

   CREATE SEQUENCE  BARS.S_REZ_LOG  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1621379 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_REZ_LOG ***
grant SELECT                                                                 on S_REZ_LOG       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_REZ_LOG       to RCC_DEAL;
grant SELECT                                                                 on S_REZ_LOG       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_REZ_LOG.sql =========*** End *** 
PROMPT ===================================================================================== 
