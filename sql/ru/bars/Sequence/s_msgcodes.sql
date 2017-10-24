

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_MSGCODES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_MSGCODES ***

   CREATE SEQUENCE  BARS.S_MSGCODES  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 771 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_MSGCODES ***
grant SELECT                                                                 on S_MSGCODES      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_MSGCODES.sql =========*** End ***
PROMPT ===================================================================================== 
