create or replace view v_mbdk_currency as
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
grant select on v_mbdk_currency to bars_access_defrole;
