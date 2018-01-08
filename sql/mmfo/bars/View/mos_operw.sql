

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/MOS_OPERW.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view MOS_OPERW ***

  CREATE OR REPLACE FORCE VIEW BARS.MOS_OPERW ("ND", "TAG", "VALUE") AS 
  select nd, tag, txt VALUE 
from  nd_txt 
where tag in (select tag from mos_tag) 
;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/MOS_OPERW.sql =========*** End *** ====
PROMPT ===================================================================================== 
