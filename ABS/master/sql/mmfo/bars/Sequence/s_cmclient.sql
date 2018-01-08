

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_CMCLIENT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_CMCLIENT ***

   CREATE SEQUENCE  BARS.S_CMCLIENT  MINVALUE 0 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1506002 CACHE 2 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_CMCLIENT ***
grant SELECT                                                                 on S_CMCLIENT      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_CMCLIENT      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_CMCLIENT.sql =========*** End ***
PROMPT ===================================================================================== 
