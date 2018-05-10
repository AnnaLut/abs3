CREATE OR REPLACE PROCEDURE BARS.dpt_push_frx is
begin
  for k in (select d.deposit_id, d.rnk, d.vidd,
   nvl((select dvc.FLAGS from bars.dpt_vidd_scheme dvc  where dvc.vidd = d.vidd  and dvc.flags = 38),0) as FLAGS
              from dpt_deposit d, ead_docs e
             where d.deposit_id = e.agr_id
               and d.wb = 'Y'
               and e.scan_data is null
--               and e.sign_date >= trunc(sysdate)
               and e.type_id = 'DOC'
               and e.EA_STRUCT_ID = '541'
            union all
            select d.deposit_id, d.rnk, d.vidd,
            nvl((select dvc.FLAGS from bars.dpt_vidd_scheme dvc  where dvc.vidd = d.vidd  and dvc.flags = decode (da.agrmnt_type,11,39,17,40)),0) as FLAGS
              from dpt_deposit d, ead_docs e, dpt_agreements da
             where d.deposit_id = e.agr_id
               and d.deposit_id = da.dpt_id
               and da.agrmnt_type in (1, 11, 4, 17)
               and d.wb = 'Y'
               and e.scan_data is null
--               and e.sign_date >= trunc(sysdate)
               and e.type_id = 'DOC'
               and e.EA_STRUCT_ID in ('542','543'))
  loop
     if k.FLAGS <> 0 then  
     intg_wb.frx2ea(k.deposit_id, k.rnk, k.FLAGS);
     else 
       BARS_AUDIT.INFO('DPT_PUSH_FRX: Код вида договора '||k.vidd || ' не знайден флаг 38,39,40 в таблице dpt_vidd_scheme. DEPOSIT_ID='||k.deposit_id);
     end if;
      
  end loop;

end;
/


Prompt Grants on PROCEDURE DPT_PUSH_FRX TO BARS_ACCESS_DEFROLE to BARS_ACCESS_DEFROLE;
GRANT EXECUTE ON BARS.DPT_PUSH_FRX TO BARS_ACCESS_DEFROLE
/
