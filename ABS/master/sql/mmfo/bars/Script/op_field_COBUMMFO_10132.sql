PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/script/op_field_COBUMMFO_10132.sql =========*** Run ***
PROMPT ===================================================================================== 
 
begin
  merge into bars.op_field f
  using (select 'EWAGC' as tag, 'Агентська коміся банку' as name from dual) t on (t.tag = f.tag)
  when matched then 
    update set f.name = t.name
  when not matched then
    insert (f.tag,
            f.name,
            f.fmt,
            f.browser,
            f.nomodify,
            f.vspo_char,
            f.chkr,
            f.default_value,
            f.type,
            f.use_in_arch)
    values (t.tag,
            t.name,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            0);
exception
  when others then
    raise;
end;
/
commit;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/script/op_field_COBUMMFO_10132.sql =========*** End ***
PROMPT ===================================================================================== 
