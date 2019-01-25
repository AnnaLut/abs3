
delete from teller_oper_define
  where oper_code = 'SBN';

insert into teller_oper_define (oper_code,
                                max_amount,
                                cur_code,
                                equip_ref,
                                need_req)
select 'SBN',10000,null,10,'IN' from dual where not exists (select 1 from teller_oper_define where oper_code = 'SBN' and equip_ref = 10);

insert into teller_oper_define (oper_code,
                                max_amount,
                                cur_code,
                                equip_ref,
                                need_req)
select 'SBN',10000,null,20,'IN' from dual where not exists (select 1 from teller_oper_define where oper_code = 'SBN' and equip_ref = 20);

commit;

