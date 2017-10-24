

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_TOP_CONTRACTS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_TOP_CONTRACTS ***

   CREATE SEQUENCE  BARS.S_TOP_CONTRACTS  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 2 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_TOP_CONTRACTS ***
grant SELECT                                                                 on S_TOP_CONTRACTS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_TOP_CONTRACTS.sql =========*** En
PROMPT ===================================================================================== 
