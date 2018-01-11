

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DPTPOAS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DPTPOAS ***

   CREATE SEQUENCE  BARS.S_DPTPOAS  MINVALUE 1 MAXVALUE 999999999999999999999 INCREMENT BY 1 START WITH 5512 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_DPTPOAS ***
grant SELECT                                                                 on S_DPTPOAS       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_DPTPOAS       to BARS_CONNECT;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DPTPOAS.sql =========*** End *** 
PROMPT ===================================================================================== 
