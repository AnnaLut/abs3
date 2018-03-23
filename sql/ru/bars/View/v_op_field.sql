create or replace view v_op_field_xrm
as
select tag,
       name,
       'C' type,
       case when browser like '%TagBrowse(%' then 1 else 0 end haverb
  from op_field
 where tag in (select tag
                 from op_rules
                where tt in (select tt from staff_tts));
/
grant select,delete,update,insert on bars.v_op_field_xrm to bars_access_defrole;
grant select on bars.v_op_field_xrm to bars_intgr;
/                