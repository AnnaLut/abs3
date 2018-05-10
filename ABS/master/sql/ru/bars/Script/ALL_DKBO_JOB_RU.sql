---------- DKBO MMFO ---------------
set serveroutput on
begin
--  return;
  FOR cur_dkbo IN (select row_number() over(partition by customer_id order by d.id) as rn, customer_id as rnk, d.id as deal_id, c.kf
                     from deal d
                     join customer c on d.customer_id = c.rnk
                     join object_type ot on d.deal_type_id = ot.id
                    where ot.type_code = 'DKBO'
                    and c.kf in (select t.kf from MV_KF t where rownum = 1))
  loop
--    exit;         

    if cur_dkbo.rn = 1 then
      ead_pack.msg_create('CLIENT', TO_CHAR(cur_dkbo.rnk), cur_dkbo.rnk /*, cur_dkbo.kf*/);
--      dbms_output.put_line('rnk='||cur_dkbo.rnk);
    end if;

    ead_pack.msg_create('AGR', 'DKBO;' || TO_CHAR(cur_dkbo.deal_id) || ';ALL', cur_dkbo.rnk /*, cur_dkbo.kf*/);

    for i in (select rownum as rn, acc, kf
                from accounts
               where acc in (select column_value
                               from table(bars.pkg_dkbo_utl.f_get_all_cust_acc(p_customer_id => deal_utl.get_deal_customer_id(cur_dkbo.deal_id),
                                                                               p_deal_id     => cur_dkbo.deal_id))))
    loop
      bars.ead_pack.msg_create('ACC', 'ACC;' || i.acc, cur_dkbo.rnk /*, i.kf*/);
    end loop;  

    FOR cur IN (SELECT deposit_id, kf FROM dpt_deposit WHERE archdoc_id > 0 AND wb = 'Y')
    LOOP
      bars.ead_pack.msg_create('AGR', 'DPT;' || TO_CHAR(cur.deposit_id), cur_dkbo.rnk /*, cur.kf*/);
    END LOOP;
  
  end loop;

  bc.set_policy_group('FILIAL');
--  bc.go(cur_dkbo.kf);

  update ead_docs d
     set d.ea_struct_id = '541', d.sign_date = null
   where ea_struct_id = '212'
     and d.template_id = 'WB_CREATE_DEPOSIT'
     and agr_id in (select deposit_id from dpt_deposit where wb = 'Y');

  bc.set_policy_group('WHOLE');

  for k in (select d.deposit_id, d.rnk, 38 as agr_id
              from dpt_deposit d, ead_docs e
             where d.deposit_id = e.agr_id
               and d.wb = 'Y'
               and e.scan_data is null
               and e.type_id = 'DOC'
               and e.EA_STRUCT_ID = '541') loop
    intg_wb.frx2ea(k.deposit_id, k.rnk, k.agr_id);
  end loop;
  
  commit work comment 'DKBO preload' write batch nowait;
  dbms_output.put_line('comet');

exception
  when others then
    dbms_output.put_line(dbms_utility.format_error_stack || dbms_utility.format_error_backtrace);
    rollback; 
    raise;
end;

