

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DPT_VIDD.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DPT_VIDD ***

   CREATE SEQUENCE  BARS.S_DPT_VIDD  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1362 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_DPT_VIDD ***
grant SELECT                                                                 on S_DPT_VIDD      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_DPT_VIDD      to DPT_ADMIN;
grant SELECT                                                                 on S_DPT_VIDD      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DPT_VIDD.sql =========*** End ***
PROMPT ===================================================================================== 
