

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_SW_BANKS_UPD.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_SW_BANKS_UPD ***

   CREATE SEQUENCE  BARS.S_SW_BANKS_UPD  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 144297 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_SW_BANKS_UPD ***
grant SELECT                                                                 on S_SW_BANKS_UPD  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_SW_BANKS_UPD.sql =========*** End
PROMPT ===================================================================================== 
