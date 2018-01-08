

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_9760.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_9760 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_9760 ("NLS", "NMS", "ZAR", "SPI") AS 
  SELECT nls, nms,         make_docinput_url ('976'       , 'Зарахувати' ,
'reqv_P9760', ''           ,
'reqv_D9760', 'Зарахування',
'reqv_TOBO3', branch       ,
'reqv_FIO'  , ''           ,
'Vob'       , '118'        ,
'Dk'        , '1'          ,
'DisR'      , '1'          ,
'DisA'      , '1'          ,
'Nls_A'     , nls          ,
'DisB'      , '1'          ,
'Nls_B'     ,
  '#(nbs_ob22(substr(#(P9760),1,4),substr(#(P9760),6,2) ) )'   ) ZAR,
                             make_docinput_url ('976'       , 'Списати'    ,
'reqv_P9760', ''           ,
'reqv_D9760', 'Списання'   ,
'reqv_TOBO3', ''           ,
'reqv_FIO'  , ''           ,
'Vob'       , '121'        ,
'Dk'        , '0'          ,
'DisR'      , '1'          ,
'DisA'      , '1'          ,
'Nls_A'     , nls          ,
'DisB'      , '1'          ,
'Nls_B'     ,
  '#(nbs_ob22_null(substr(#(P9760),1,4), substr(#(P9760),6,2),
     decode(substr(#(P9760),6,2), ''07'',  #(TOBO3),
     SYS_CONTEXT (''bars_context'', ''user_branch'')  ) ) )'   ) SPI
FROM v_gl   WHERE nbs = '9760'  AND dazs IS NULL     AND kv = 980
 AND branch = SYS_CONTEXT ('bars_context', 'user_branch');

PROMPT *** Create  grants  V_9760 ***
grant SELECT                                                                 on V_9760          to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on V_9760          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_9760          to PYOD001;
grant SELECT                                                                 on V_9760          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_9760          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_9760          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_9760.sql =========*** End *** =======
PROMPT ===================================================================================== 
