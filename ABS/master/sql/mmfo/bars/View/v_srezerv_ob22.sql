PROMPT ===================================================================================== 
PROMPT *** Run *** ======= Scripts /Sql/BARS/View/V_SREZERV_OB22.sql ======*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SREZERV_OB22 ***

CREATE OR REPLACE FORCE VIEW BARS.V_SREZERV_OB22 AS
 select o.nbs     , p.name NBS_NAME, 
        o.ob22    , s.txt  OB22_TXT,  
        o.CUSTTYPE, o.KV      , o.s080, 
        o.NBS_REZ , o.OB22_REZ,
        o.NBS_7R  , o.OB22_7R ,
        o.NBS_7F  , o.OB22_7F ,
        o.PR      , o.R013    , 
        o.NAL     , n.name NAL_NAME 
 from srezerv_ob22 o, ps p, sb_ob22 s, rez_nal n 
 where o.nbs = s.r020(+) and o.ob22 = s.ob22(+) and o.nbs=p.nbs(+) and o.nal=n.nal(+);

PROMPT *** Create  grants  V_SREZERV_OB22 ***
grant SELECT, UPDATE            on V_SREZERV_OB22 to BARS_ACCESS_DEFROLE;
grant SELECT, UPDATE            on V_SREZERV_OB22 to START1;

PROMPT ===================================================================================== 
PROMPT *** End *** ======= Scripts /Sql/BARS/View/V_SREZERV_OB22.sql ======*** End *** =====
PROMPT ===================================================================================== 


