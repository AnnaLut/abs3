

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DPT_TRUSTEE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DPT_TRUSTEE ***

   CREATE SEQUENCE  BARS.S_DPT_TRUSTEE  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 340047 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_DPT_TRUSTEE ***
grant SELECT                                                                 on S_DPT_TRUSTEE   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_DPT_TRUSTEE   to DPT_ROLE;
grant SELECT                                                                 on S_DPT_TRUSTEE   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DPT_TRUSTEE.sql =========*** End 
PROMPT ===================================================================================== 
