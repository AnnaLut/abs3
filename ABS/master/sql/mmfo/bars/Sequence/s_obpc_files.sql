

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_OBPC_FILES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_OBPC_FILES ***

   CREATE SEQUENCE  BARS.S_OBPC_FILES  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 33131 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_OBPC_FILES ***
grant SELECT                                                                 on S_OBPC_FILES    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_OBPC_FILES.sql =========*** End *
PROMPT ===================================================================================== 
