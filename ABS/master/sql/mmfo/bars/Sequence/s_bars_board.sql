

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_BARS_BOARD.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_BARS_BOARD ***

   CREATE SEQUENCE  BARS.S_BARS_BOARD  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 2179 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_BARS_BOARD ***
grant SELECT                                                                 on S_BARS_BOARD    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_BARS_BOARD.sql =========*** End *
PROMPT ===================================================================================== 
