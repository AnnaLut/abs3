

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PRVN_PACKAGE.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view PRVN_PACKAGE ***

  CREATE OR REPLACE FORCE VIEW BARS.PRVN_PACKAGE ("NAME", "H", "B") AS 
  select NAME, substr(h, 1, 100) H, substr(B, 1, 100) B
  FROM (    select 'CCK'         NAME,  CCK.header_version            H,   CCK.body_version             B  from dual
  union all select 'PRVN_FLOW'       ,  PRVN_FLOW.header_version       ,   PRVN_FLOW.body_version          from dual
  union all select 'BARS_LOSS_EVENTS',  BARS_LOSS_EVENTS.header_version,   BARS_LOSS_EVENTS.body_version   from dual
       );

PROMPT *** Create  grants  PRVN_PACKAGE ***
grant SELECT                                                                 on PRVN_PACKAGE    to BARSREADER_ROLE;
grant SELECT                                                                 on PRVN_PACKAGE    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PRVN_PACKAGE    to START1;
grant SELECT                                                                 on PRVN_PACKAGE    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PRVN_PACKAGE.sql =========*** End *** =
PROMPT ===================================================================================== 
