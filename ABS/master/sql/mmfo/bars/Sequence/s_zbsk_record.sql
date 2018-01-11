

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_ZBSK_RECORD.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_ZBSK_RECORD ***

   CREATE SEQUENCE  BARS.S_ZBSK_RECORD  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 46724957 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_ZBSK_RECORD ***
grant SELECT                                                                 on S_ZBSK_RECORD   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_ZBSK_RECORD.sql =========*** End 
PROMPT ===================================================================================== 
