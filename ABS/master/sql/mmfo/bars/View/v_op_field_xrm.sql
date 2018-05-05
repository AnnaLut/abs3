prompt create view bars.v_op_field_xrm
create or replace view v_op_field_xrm as
select tag,
       name,
       'C' type,
       case when browser like '%TagBrowse(%' then 1 else 0 end haverb,
       regexp_substr(upper(browser), q'$(FROM)([[:blank:]])+([^ "\(\)']+)$', 1, 1, null, 3) as DICT
  from op_field
 where tag in (select tag
                 from op_rules
                where (tt in (select tt from staff_tts)
                      or
                      exists (select null from dpt_tts_vidd d where d.tt = op_rules.tt )));

grant select,delete,update,insert on bars.v_op_field_xrm to bars_access_defrole;