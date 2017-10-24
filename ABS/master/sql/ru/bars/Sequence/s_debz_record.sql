

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DEBZ_RECORD.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DEBZ_RECORD ***

   CREATE SEQUENCE  BARS.S_DEBZ_RECORD  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_DEBZ_RECORD ***
grant SELECT                                                                 on S_DEBZ_RECORD   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_DEBZ_RECORD   to START1;
grant SELECT                                                                 on S_DEBZ_RECORD   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DEBZ_RECORD.sql =========*** End 
PROMPT ===================================================================================== 
