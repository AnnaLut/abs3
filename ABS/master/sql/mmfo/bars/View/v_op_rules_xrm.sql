create or replace view v_op_rules_xrm
as
 select tt,
        tag,
        opt mflag,
        ord,
        case when val like '%#%' then null else val end def
   from op_rules
 where tt in (select tt from staff_tts) and used4input=1;
/
grant select,delete,update,insert on bars.v_op_rules_xrm to bars_access_defrole;
/                