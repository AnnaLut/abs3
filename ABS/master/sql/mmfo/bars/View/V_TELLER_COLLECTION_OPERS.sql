
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/v_teller_collection_opers.sql =========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.V_TELLER_COLLECTION_OPERS ("ID", "LAST_DT", "EXEC_TIME", "CUR_CODE", "AMOUNT", "DOC_REF", "CASH_DIRECTION", "OPER_STATUS", "CANDELETE") AS 
  select tco.id, last_dt, last_dt as exec_time, to_number(cur) as cur_code, amount, doc_ref, direction||'('||purpose||')' as cash_direction,
       case nvl(doc_ref,-1)
         when -1 then '-'
         else '+'
       end as oper_status,
       tco.candelete
  from teller_collection_opers tco
  where tco.user_id = bars.user_id
    and ((tco.doc_ref is null)
         or
         (tco.doc_ref is not null and exists (select 1 from teller_opers op where op.doc_ref = tco.doc_ref and op.work_date = gl.bD))
        )
/*select id,
       exec_time,
       op.cur_code,
       amount,
       op.doc_ref,
       case substr(state,1,2)
         when 'IA' then 'Підкріплення (АТМ)'
         when 'IC' then 'Підкріплення (зношені)'
         when 'IT' then 'Підкріплення (темпокаса)'
         when 'OA' then 'Вилучення (АТМ)'
         when 'OC' then 'Вилучення (зношені)'
         when 'OT' then 'Вилучення (темпокаса)'
         when 'OK' then
           case co.op_type
             when 'IN' then 'Підкріплення'
             when 'OUT' then 'Вилучення'
           end
         else '??'
       end as cash_direction,
       case nvl(op.doc_ref,-1)
         when -1 then '-'
         else '+'
       end as oper_status
  from teller_opers op, teller_cash_opers co
  where work_date = gl.bd
    and user_ref = user_id
    and oper_ref = 'TOX'
    and op.id = co.doc_ref;*/
;
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/v_teller_collection_opers.sql =========
 PROMPT ===================================================================================== 
 