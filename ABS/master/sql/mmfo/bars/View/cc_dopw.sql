

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_DOPW.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_DOPW ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_DOPW ("ND", "CODE", "TAG", "NAME", "TYPE", "TXT", "SEM", "TABLE_NAME") AS 
  select  nd, nvl(code,'NULL') code ,  tag, name,  type, substr(txt,1,250) TXT, substr( cck_ui.DOP_SEM(txt, table_name, sk, fk),1,250) SEM, table_name
from ( --------------------------------------------------------------------
  SELECT 1 dop, t.code, t.tag, t.name,  t.type,  x.ND, x.txt, t.table_name, t.nsisqlwhere,
           (select min(colname) from meta_tables mt,meta_columns mc where mt.tabid=mc.tabid and showretval=1 and  mt.tabname=t.table_name) sk,
         (select min(colname) from meta_tables mt,meta_columns mc where mt.tabid=mc.tabid and INSTNSSEMANTIC=1 and  mt.tabname=t.table_name) fk
  FROM CC_TAG t, (select * from ND_TXT where nd = TO_NUMBER (pul.Get_Mas_Ini_Val ('ND') ) ) x
  WHERE  ( t.TAGTYPE ='CCK' AND t.tag = x.tag (+)  )
 union all -----------------------------------------------------------------
  SELECT 1 dop, t.code,  t.tag, t.name,  t.type, x.ND, x.txt, t.table_name, t.nsisqlwhere,
        (select min(colname) from meta_tables mt,meta_columns mc where mt.tabid=mc.tabid and showretval=1 and  mt.tabname=t.table_name) sk,
        (select min(colname) from meta_tables mt,meta_columns mc where mt.tabid=mc.tabid and INSTNSSEMANTIC=1 and  mt.tabname=t.table_name) fk
  FROM CC_TAG t,  (select * from ND_TXT where nd = TO_NUMBER (pul.Get_Mas_Ini_Val ('ND') ) ) x
  WHERE  ( t.TAGTYPE is null AND t.tag = x.tag )
     ) --------------------------------------------------
 order by decode ( code, null, '9', 'MAIN', '1','SPEC','0', '2') ||nvl(code,'NULL'), ND, TAG
;

PROMPT *** Create  grants  CC_DOPW ***
grant SELECT                                                                 on CC_DOPW         to BARSREADER_ROLE;
grant SELECT                                                                 on CC_DOPW         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_DOPW         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_DOPW.sql =========*** End *** ======
PROMPT ===================================================================================== 
