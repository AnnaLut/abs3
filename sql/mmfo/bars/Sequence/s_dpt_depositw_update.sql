

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DPT_DEPOSITW_UPDATE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DPT_DEPOSITW_UPDATE ***

   CREATE SEQUENCE  BARS.S_DPT_DEPOSITW_UPDATE  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  ORDER  NOCYCLE ;

PROMPT *** Create  grants  S_DPT_DEPOSITW_UPDATE ***
grant SELECT                                                                 on S_DPT_DEPOSITW_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_DPT_DEPOSITW_UPDATE to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DPT_DEPOSITW_UPDATE.sql =========
PROMPT ===================================================================================== 
