

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_SURVEY_QGRP.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_SURVEY_QGRP ***

   CREATE SEQUENCE  BARS.S_SURVEY_QGRP  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 2 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_SURVEY_QGRP ***
grant SELECT                                                                 on S_SURVEY_QGRP   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_SURVEY_QGRP.sql =========*** End 
PROMPT ===================================================================================== 
