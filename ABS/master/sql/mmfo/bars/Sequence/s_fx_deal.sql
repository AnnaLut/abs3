

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_FX_DEAL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_FX_DEAL ***

   CREATE SEQUENCE  BARS.S_FX_DEAL  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 215839 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_FX_DEAL ***
grant SELECT                                                                 on S_FX_DEAL       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_FX_DEAL       to FOREX;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_FX_DEAL.sql =========*** End *** 
PROMPT ===================================================================================== 
