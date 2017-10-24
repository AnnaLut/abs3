create or replace procedure dpt_push_frx
is
begin
 for k in ( SELECT d.deposit_id, d.rnk, 38 as agr_id
              FROM dpt_deposit d, ead_docs e 
              where D.DEPOSIT_ID = E.AGR_ID    
              and d.wb = 'Y'    
              and e.scan_Data is null  
              and e.sign_date >= sysdate - 5
              and e.type_id = 'DOC'
            union all
            SELECT d.deposit_id, d.rnk, case when DA.AGRMNT_TYPE = 4 then 39 when DA.AGRMNT_TYPE = 17 then 39 end 
              FROM dpt_deposit d, ead_docs e, dpt_agreements da 
              where D.DEPOSIT_ID = E.AGR_ID
              and d.deposit_id = DA.DPT_ID
              and DA.AGRMNT_TYPE in (1,4,17)  
              and d.wb = 'Y'    
              and e.scan_Data is null  
              and e.sign_date >= sysdate - 5
              and e.type_id = 'DOC'  )
 loop 
  intg_wb.frx2ea(k.deposit_id, k.rnk, k.agr_id);
 end loop;

end;
/
grant execute on dpt_push_frx to bars_Access_defrole;
/