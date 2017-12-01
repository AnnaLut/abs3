PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DOPPARAM_MSFZ.sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DOPPARAM_MSFZ ***
create or replace view V_DOPPARAM_MSFZ as
select  to_number(pul.Get_Mas_Ini_Val('ND')) ND,
        t.TAG,
        t.name,
        (select txt from nd_txt where tag = t.tag and nd = pul.Get_Mas_Ini_Val('ND'))VAL
from cc_tag t where t.tag in('BUS_MOD','SPPI','IFRS');


PROMPT *** Create  grants  V_DOPPARAM_MSFZ***
grant SELECT on V_DOPPARAM_MSFZ to BARS_ACCESS_DEFROLE;
grant SELECT on V_DOPPARAM_MSFZ to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DOPPARAM_MSFZ.sql =========*** End *** ==========
PROMPT ===================================================================================== 