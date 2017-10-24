create or replace view v_compen_actual_compens as
select c.rnk,
       c.fio fio_client,
       case when p.passp = 7 then p.eddr_id else p.ser end as ser,
       p.numdoc,
       c.dbcode,
       c.nls,
       cc.branch,
       o.compen_id,
       nvl(o.changedate, o.regdate) l_date,
       o.oper_type, 
       (select t.text from compen_oper_types t where t.type_id = o.oper_type) type_oper_name,
       cp.fio fio_compen,
       cp.nsc,
       o.user_id,
       case
         when o.reg_id is not null then
          'враховано в реєстрі'
         else
          'не враховано в реєстрі'
       end as reg_processed,
       (select t.state_name from compen_oper_states t where t.state_id = o.state) state_oper_name
/*       (select listagg('Статус: ' || state_id || '| Сума: '' ;') within group(order by null) || amount from
       (select sum(amount), r.state_id from compen_payments_registry r
         where r.rnk = c.rnk
           and r.type_id = case
                 when o.oper_type = 5 then
                  1
                 when o.oper_type = 6  then
                  2
               end
         group by r.state_id)) as info_registry
         */
  from compen_clients c
  join person p
    on (c.rnk = p.rnk)
  join customer cc
    on (cc.rnk = c.rnk)
  join compen_oper o
    on (c.rnk = o.rnk and o.oper_type in (5, 6))
  join compen_portfolio cp on (cp.id = o.compen_id)
 where o.mfo = sys_context('bars_context','user_mfo')
   and o.user_id = user_id();
comment on table V_COMPEN_ACTUAL_COMPENS is 'Список актуалізацій вкладів';
comment on column V_COMPEN_ACTUAL_COMPENS.RNK is 'Ідентифікатор клієнту';
comment on column V_COMPEN_ACTUAL_COMPENS.FIO_CLIENT is 'ПІБ клієнта';
comment on column V_COMPEN_ACTUAL_COMPENS.SER is 'Серія документу або ЄДДР якщо ID-картка';
comment on column V_COMPEN_ACTUAL_COMPENS.NUMDOC is 'Номер Документу';
comment on column V_COMPEN_ACTUAL_COMPENS.DBCODE is 'DBCODE';
comment on column V_COMPEN_ACTUAL_COMPENS.NLS is 'Рахунок для виплат клієнту';
comment on column V_COMPEN_ACTUAL_COMPENS.BRANCH is 'Бранч клієнта';
comment on column V_COMPEN_ACTUAL_COMPENS.COMPEN_ID is 'Ідентифікатор вкладу';
comment on column V_COMPEN_ACTUAL_COMPENS.L_DATE is 'Дата останньої зміни операції';
comment on column V_COMPEN_ACTUAL_COMPENS.OPER_TYPE is 'Тип операції; 5-акт 6-акт похов.';
comment on column V_COMPEN_ACTUAL_COMPENS.TYPE_OPER_NAME is 'Назва операції';
comment on column V_COMPEN_ACTUAL_COMPENS.FIO_COMPEN is 'ПІБ вкладу';
comment on column V_COMPEN_ACTUAL_COMPENS.NSC is 'Рахунок вкладу';
comment on column V_COMPEN_ACTUAL_COMPENS.USER_ID is 'ІД користувача створивший операцію';
comment on column V_COMPEN_ACTUAL_COMPENS.REG_PROCESSED is 'Відмітка про формування реєстру по актуалізації';
comment on column V_COMPEN_ACTUAL_COMPENS.STATE_OPER_NAME is 'Статус операції';

  GRANT SELECT ON BARS.V_COMPEN_ACTUAL_COMPENS TO BARS_ACCESS_DEFROLE;