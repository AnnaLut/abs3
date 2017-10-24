

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_OBPC_ELPLAT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_OBPC_ELPLAT ***

   CREATE SEQUENCE  BARS.S_OBPC_ELPLAT  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 94965 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_OBPC_ELPLAT ***
grant SELECT                                                                 on S_OBPC_ELPLAT   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_OBPC_ELPLAT.sql =========*** End 
PROMPT ===================================================================================== 
