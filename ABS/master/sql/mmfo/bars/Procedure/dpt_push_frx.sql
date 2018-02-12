Prompt Procedure DPT_PUSH_FRX;
CREATE OR REPLACE PROCEDURE BARS.dpt_push_frx is
begin
  for k in (select d.deposit_id, d.rnk, 38 as agr_id
              from dpt_deposit d, ead_docs e
             where d.deposit_id = e.agr_id
               and d.wb = 'Y'
               and e.scan_data is null
--               and e.sign_date >= trunc(sysdate)
               and e.type_id = 'DOC'
               and e.EA_STRUCT_ID = '541'
            union all
            select d.deposit_id, d.rnk, case when da.agrmnt_type = 11 then 39 when da.agrmnt_type = 17 then 40 end
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
    intg_wb.frx2ea(k.deposit_id, k.rnk, k.agr_id);
  end loop;

end;
/


Prompt Grants on PROCEDURE DPT_PUSH_FRX TO BARS_ACCESS_DEFROLE to BARS_ACCESS_DEFROLE;
GRANT EXECUTE ON BARS.DPT_PUSH_FRX TO BARS_ACCESS_DEFROLE
/
