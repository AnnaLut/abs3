

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBDK_CURRENCY.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBDK_CURRENCY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBDK_CURRENCY ("KV", "NAME") AS 
  select  kv, name
from    tabval t
where   t.kv in (select a.kv
                 from   accounts a
                 where  a.dazs is null and
                        a.nls = branch_attribute_utl.get_attribute_value(p_branch_code => bars_context.current_branch_code(),
                                                                         p_attribute_code => 'MBD_NLS_1819',
                                                                         p_raise_expt => 0,
                                                                         p_parent_lookup => 1,
                                                                         p_check_exist => 0));

PROMPT *** Create  grants  V_MBDK_CURRENCY ***
grant SELECT                                                                 on V_MBDK_CURRENCY to BARSREADER_ROLE;
grant SELECT                                                                 on V_MBDK_CURRENCY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_MBDK_CURRENCY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBDK_CURRENCY.sql =========*** End **
PROMPT ===================================================================================== 
