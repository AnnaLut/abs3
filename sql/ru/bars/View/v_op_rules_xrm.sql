create or replace view v_op_rules_xrm as

select tt,
        tag,
        opt mflag,
        ord,
        case when val like '%#%' then null else val end def
   from op_rules
 where (tt in (select tt from staff_tts)
       or
       exists (select null from dpt_tts_vidd d where d.tt = op_rules.tt ))
 and used4input=1;
/
grant select on bars.v_op_rules_xrm to bars_access_defrole;
grant select on bars.v_op_rules_xrm to bars_intgr;