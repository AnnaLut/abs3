

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_TICKETS_ADVERTISING.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_TICKETS_ADVERTISING ***

   CREATE SEQUENCE  BARS.S_TICKETS_ADVERTISING  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_TICKETS_ADVERTISING ***
grant SELECT                                                                 on S_TICKETS_ADVERTISING to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_TICKETS_ADVERTISING.sql =========
PROMPT ===================================================================================== 
