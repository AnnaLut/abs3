PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/procedure/p_fm_bulk_set_status.sql =========*** Run *** 
PROMPT ===================================================================================== 

PROMPT *** Create  procedure p_fm_bulk_set_status ***

create or replace procedure p_fm_bulk_set_status(p_refs in number_list) 
is
  l_error varchar2(3000);
begin

  merge into finmon_que f
  using (select p.column_value as ref,
                case when coalesce(q.otm, 0) > 0 then 'T' else 'N' end as status
         from table(p_refs) p
              inner join oper o on p.column_value = o.ref
              left join fm_ref_que q on q.ref = p.column_value) r
  on (f.ref = r.ref)
  when matched then 
    update set f.status = r.status
  when not matched then
    insert (id, ref, rec, status, agent_id, comments)
    values (bars_sqnc.get_nextval('s_finmon_que'), r.ref, null, r.status, user_id, null);

exception
  when others then
    l_error := substrb(dbms_utility.format_error_backtrace || ' ' || sqlerrm, 1, 3000);
    bars_audit.info('p_fm_bulk_set_status error ' || l_error);
    raise_application_error(-20000,'Помилка відправки документів: '|| l_error);
end p_fm_bulk_set_status;
/
show err;

PROMPT *** Create  grants  P_FM_SET_STATUS ***
grant EXECUTE                                                                on bars.p_fm_bulk_set_status to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on bars.p_fm_bulk_set_status to FINMON01;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/procedure/p_fm_bulk_set_status.sql =========*** End *** 
PROMPT ===================================================================================== 
