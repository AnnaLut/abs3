PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBU_GROUPUR_UO.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBU_GROUPUR_UO ***

 CREATE OR REPLACE FORCE VIEW BARS.V_NBU_GROUPUR_UO ("RNK", "WHOIS", "ISREZGR", "CODEDRPOUGR", "NAMEURGR", "COUNTRYCODGR", "STATUS","STATUS_MESSAGE", "KF") AS
 select "RNK","WHOIS","ISREZGR","CODEDRPOUGR","NAMEURGR","COUNTRYCODGR","STATUS","STATUS_MESSAGE","KF" from NBU_GROUPUR_UO;

grant SELECT                                  on V_NBU_GROUPUR_UO   to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBU_GROUPUR_UO.sql =========*** End *
PROMPT ===================================================================================== 
