PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CL_ERR.sql =========*** Run *** =====
PROMPT ===================================================================================== 
CREATE OR REPLACE FORCE VIEW BARS.V_CL_ERR AS 
select * from nd_txt where tag='CL_ERR';

PROMPT *** Create  grants  V_CL_ERR ***
grant SELECT   on V_CL_ERR        to BARSREADER_ROLE;
grant SELECT   on V_CL_ERR        to BARS_ACCESS_DEFROLE;
