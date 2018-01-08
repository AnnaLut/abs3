

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_SOC_FILENAME.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_SOC_FILENAME ***

   CREATE SEQUENCE  BARS.S_SOC_FILENAME  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1844 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_SOC_FILENAME ***
grant SELECT                                                                 on S_SOC_FILENAME  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_SOC_FILENAME  to DPT_ROLE;
grant SELECT                                                                 on S_SOC_FILENAME  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_SOC_FILENAME.sql =========*** End
PROMPT ===================================================================================== 
