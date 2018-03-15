PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBU_OWNERPP_UO.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBU_OWNERPP_UO ***

 CREATE OR REPLACE FORCE VIEW BARS.V_NBU_OWNERPP_UO AS 
 select "RNK","RNKB","LASTNAME","FIRSTNAME","MIDDLENAME","ISREZ","INN","COUNTRYCOD","PERCENT","STATUS","KF" from NBU_OWNERPP_UO;

grant SELECT                                  on V_NBU_OWNERPP_UO   to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBU_OWNERPP_UO.sql =========*** End *
PROMPT ===================================================================================== 
