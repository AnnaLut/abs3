

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_CONTRACTS_LICENCE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_CONTRACTS_LICENCE ***

   CREATE SEQUENCE  BARS.S_CONTRACTS_LICENCE  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_CONTRACTS_LICENCE ***
grant SELECT                                                                 on S_CONTRACTS_LICENCE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_CONTRACTS_LICENCE.sql =========**
PROMPT ===================================================================================== 
