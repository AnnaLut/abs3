

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_OBPC_DP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_OBPC_DP ***

   CREATE SEQUENCE  BARS.S_OBPC_DP  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_OBPC_DP ***
grant SELECT                                                                 on S_OBPC_DP       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_OBPC_DP.sql =========*** End *** 
PROMPT ===================================================================================== 