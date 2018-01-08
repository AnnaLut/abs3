PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/ND_DREC.sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** Create  view ND_DREC***
create or replace view nd_drec as
select  to_number(pul.Get_Mas_Ini_Val('ND')) ND,
        t.TAG,
        t.name,
        substr((select txt from nd_txt where tag = t.tag and nd = pul.Get_Mas_Ini_Val('ND')), 1, 100) VAL
from cc_tag t where t.tag in('VNCRR','VNCRP','PAWN','NEINF','KHIST');


PROMPT *** Create  grants  ND_DREC***
grant SELECT on ND_DREC to BARS_ACCESS_DEFROLE;
grant SELECT on ND_DREC to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/ND_DREC.sql =========*** End *** ==========
PROMPT ===================================================================================== 