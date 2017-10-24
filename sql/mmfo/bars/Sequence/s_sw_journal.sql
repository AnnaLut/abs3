

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_SW_JOURNAL.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_SW_JOURNAL ***

   CREATE SEQUENCE  BARS.S_SW_JOURNAL  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 93518655 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_SW_JOURNAL ***
grant SELECT                                                                 on S_SW_JOURNAL    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_SW_JOURNAL.sql =========*** End *
PROMPT ===================================================================================== 
