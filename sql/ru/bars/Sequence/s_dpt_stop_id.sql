

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DPT_STOP_ID.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DPT_STOP_ID ***

   CREATE SEQUENCE  BARS.S_DPT_STOP_ID  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 243 CACHE 20 ORDER  NOCYCLE ;

PROMPT *** Create  grants  S_DPT_STOP_ID ***
grant SELECT                                                                 on S_DPT_STOP_ID   to ABS_ADMIN;
grant SELECT                                                                 on S_DPT_STOP_ID   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_DPT_STOP_ID   to DPT_ADMIN;
grant SELECT                                                                 on S_DPT_STOP_ID   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DPT_STOP_ID.sql =========*** End 
PROMPT ===================================================================================== 
