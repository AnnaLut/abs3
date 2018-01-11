

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_OTCN_LOG.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_OTCN_LOG ***

   CREATE SEQUENCE  BARS.S_OTCN_LOG  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 49376603 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_OTCN_LOG ***
grant SELECT                                                                 on S_OTCN_LOG      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_OTCN_LOG.sql =========*** End ***
PROMPT ===================================================================================== 
