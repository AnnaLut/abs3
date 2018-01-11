

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FM_BULK_SET_PARAMS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FM_BULK_SET_PARAMS ***

  CREATE OR REPLACE PROCEDURE BARS.P_FM_BULK_SET_PARAMS (p_refs in number_list, -- список референсов
                                                 p_opr_vid1 in finmon_que.opr_vid1%type, -- код вида операции
                                                 p_opr_vid2 in finmon_que.opr_vid2%type, -- код ОМ
                                                 p_comm2    in finmon_que.comm_vid2%type,-- комментарий к ОМ
                                                 p_opr_vid3 in finmon_que.opr_vid3%type, -- код ВМ
                                                 p_comm3    in finmon_que.comm_vid3%type,-- комментарий к ВМ
                                                 p_mode     in finmon_que.monitor_mode%type, -- режим мониторинга
                                                 p_vid2     in string_list, -- доп. коды ОМ
                                                 p_vid3     in string_list -- доп. коды ВМ
                                                 )
is
/* created by Lypskykh O.S. 12.05.2017
пакетное проставление параметров ФМ
ММФО
v1.0.0 30.05.2017 */
g_modcode constant varchar2(3) := 'FMN';
l_refs_to_audit varchar2(2000);
begin
  bars_audit.trace('%s: %s entry', g_modcode, $$PLSQL_UNIT);
  if p_refs.count <= 150 then
    select trim(substr(listagg(column_value, ', ') within group (order by 1), 1, 1500)) into l_refs_to_audit from table(p_refs);
  else l_refs_to_audit := '>150 refs, not shown';
  end if;
  bars_audit.trace('%s: %s merging, refs=>(%s)(1500 substr)', g_modcode, $$PLSQL_UNIT, l_refs_to_audit);

  merge into finmon_que f
  using (select p.column_value as CV
         from table(p_refs) p
         join oper o on p.column_value = o.ref) r
  on (f.ref = r.CV)
  when matched then update
                    set f.opr_vid1 = p_opr_vid1,
                        f.opr_vid2 = p_opr_vid2,
                        f.comm_vid2 = p_comm2,
                        f.opr_vid3 = p_opr_vid3,
                        f.comm_vid3 = p_comm3,
                        f.monitor_mode = p_mode,
                        f.rnk_a = (select c.rnk from customer c
                                   where c.rnk = coalesce(f.rnk_a, -- если уже заполнен
                                                         (select a.rnk
                                                          from oper o
                                                          join accounts a on o.nlsa = a.nls and o.kv = a.kv and o.mfoa = a.kf
                                                          where o.ref = r.CV), -- ищем по счету
                                                         (select max(co.rnk) -- ищем по окпо в документе - если такой клиент один
                                                          from customer co
                                                          join oper o on co.okpo = o.id_a
                                                          where o.ref = r.CV
                                                          group by co.okpo
                                                          having count(*)=1
                                                         ))
                                   ),
                        f.rnk_b = (select c.rnk from customer c
                                   where c.rnk = coalesce(f.rnk_b, -- если уже заполнен
                                                         (select a.rnk
                                                          from oper o
                                                          join accounts a on o.nlsb = a.nls and nvl(o.kv2, o.kv) = a.kv and o.mfob = a.kf
                                                          where o.ref = r.CV), -- ищем по счету
                                                         (select max(co.rnk) -- ищем по окпо в документе - если такой клиент один
                                                          from customer co
                                                          join oper o on co.okpo = o.id_b
                                                          where o.ref = r.CV
                                                          group by co.okpo
                                                          having count(*)=1
                                                         ))
                                   )
  when not matched then insert(ref, rec, status, opr_vid1, opr_vid2, comm_vid2, opr_vid3, comm_vid3, monitor_mode, agent_id, rnk_a, rnk_b)
  values (r.CV, null, 'I', p_opr_vid1, p_opr_vid2, p_comm2, p_opr_vid3, p_comm3, p_mode, user_id, coalesce((select a.rnk
                                                                                                                          from oper o
                                                                                                                          join accounts a on o.nlsa = a.nls and o.kv = a.kv and o.mfoa = a.kf
                                                                                                                          where o.ref = r.CV),
                                                                                                                         (select max(co.rnk)
                                                                                                                          from customer co
                                                                                                                          join oper o on co.okpo = o.id_a
                                                                                                                          where o.ref = r.CV
                                                                                                                          group by co.okpo
                                                                                                                          having count(*)=1
                                                                                                                         )),
                                                                                                  coalesce((select a.rnk
                                                                                                                          from oper o
                                                                                                                          join accounts a on o.nlsb = a.nls and nvl(o.kv2, o.kv) = a.kv and o.mfob = a.kf
                                                                                                                          where o.ref = r.CV),
                                                                                                                         (select max(co.rnk)
                                                                                                                          from customer co
                                                                                                                          join oper o on co.okpo = o.id_b
                                                                                                                          where o.ref = r.CV
                                                                                                                          group by co.okpo
                                                                                                                          having count(*)=1
                                                                                                                         ))
  );
  bars_audit.trace('%s: %s merged, refs=>(%s)', g_modcode, $$PLSQL_UNIT, l_refs_to_audit);
  -- если есть доп. коды ОМ
    -- удаляем существующие
  delete from finmon_que_vid2 where id in (select id from finmon_que where ref in (select * from table(p_refs)));
  if p_vid2 is not null and p_vid2.count > 0 then
    if p_vid2.first is not null then
        bars_audit.trace('%s: %s vids2 is not empty, processing', g_modcode, $$PLSQL_UNIT);
        -- проставляем новые
        forall idx in 1..p_vid2.count
          insert into finmon_que_vid2(id, vid)
          select id, p_vid2(idx)
          from finmon_que where ref in (select * from table(p_refs));
    end if;
  end if;
  -- если есть доп. коды ВМ
    -- удаляем существующие
  delete from finmon_que_vid3 where id in (select id from finmon_que where ref in (select * from table(p_refs)));
  if p_vid3 is not null and p_vid3.count > 0 then
    if p_vid3.first is not null then
        bars_audit.trace('%s: %s vids3 is not empty, processing', g_modcode, $$PLSQL_UNIT);
        -- проставляем новые
        forall idx in 1..p_vid3.count
          insert into finmon_que_vid3(id, vid)
          select id, p_vid3(idx)
          from finmon_que where ref in (select * from table(p_refs));
    end if;
  end if;

  bars_audit.trace('%s: %s done', g_modcode, $$PLSQL_UNIT);
end p_fm_bulk_set_params;
/
show err;

PROMPT *** Create  grants  P_FM_BULK_SET_PARAMS ***
grant EXECUTE                                                                on P_FM_BULK_SET_PARAMS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FM_BULK_SET_PARAMS.sql =========
PROMPT ===================================================================================== 
