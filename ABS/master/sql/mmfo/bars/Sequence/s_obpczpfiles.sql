

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_OBPCZPFILES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_OBPCZPFILES ***

   CREATE SEQUENCE  BARS.S_OBPCZPFILES  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 16790 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_OBPCZPFILES ***
grant SELECT                                                                 on S_OBPCZPFILES   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_OBPCZPFILES.sql =========*** End 
PROMPT ===================================================================================== 
