

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_SECJOURNAL.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_SECJOURNAL ***

   CREATE SEQUENCE  BARS.S_SECJOURNAL  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 394772 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_SECJOURNAL ***
grant SELECT                                                                 on S_SECJOURNAL    to ABS_ADMIN;
grant SELECT                                                                 on S_SECJOURNAL    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_SECJOURNAL.sql =========*** End *
PROMPT ===================================================================================== 
