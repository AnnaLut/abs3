

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DPT_BONUSES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DPT_BONUSES ***

   CREATE SEQUENCE  BARS.S_DPT_BONUSES  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 2 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_DPT_BONUSES ***
grant SELECT                                                                 on S_DPT_BONUSES   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DPT_BONUSES.sql =========*** End 
PROMPT ===================================================================================== 