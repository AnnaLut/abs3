

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DPT_VIDD_UPDATE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DPT_VIDD_UPDATE ***

   CREATE SEQUENCE  BARS.S_DPT_VIDD_UPDATE  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 6200021294 CACHE 20 ORDER  NOCYCLE ;

PROMPT *** Create  grants  S_DPT_VIDD_UPDATE ***
grant SELECT                                                                 on S_DPT_VIDD_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_DPT_VIDD_UPDATE to DPT_ADMIN;
grant SELECT                                                                 on S_DPT_VIDD_UPDATE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DPT_VIDD_UPDATE.sql =========*** 
PROMPT ===================================================================================== 
