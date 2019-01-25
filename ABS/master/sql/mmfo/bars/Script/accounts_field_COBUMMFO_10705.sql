PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/script/accounts_field_COBUMMFO_10705.sql =========*** Run ***
PROMPT ===================================================================================== 
 
begin
  merge into bars.accounts_field f
  using (select 'CVK_INF2' as tag, 'ЦВК. Інформація про відповідального працівника (№ тел, e-mail)' as name from dual) t on (t.tag = f.tag)
  when matched then 
    update set f.name = t.name,
               f.deleted = null,
               f.use_in_arch = 1
  when not matched then
    insert (f.tag,
            f.name,
            f.deleted,
            f.use_in_arch)
    values (t.tag,
            t.name,
            null,
            1);
exception
  when others then
    raise;
end;
/
commit;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/script/accounts_field_COBUMMFO_10705.sql =========*** End ***
PROMPT ===================================================================================== 
