

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_ZAY_DATA_TRANSFER.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_ZAY_DATA_TRANSFER ***

   CREATE SEQUENCE  BARS.S_ZAY_DATA_TRANSFER  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1913101 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_ZAY_DATA_TRANSFER ***
grant SELECT                                                                 on S_ZAY_DATA_TRANSFER to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_ZAY_DATA_TRANSFER.sql =========**
PROMPT ===================================================================================== 
