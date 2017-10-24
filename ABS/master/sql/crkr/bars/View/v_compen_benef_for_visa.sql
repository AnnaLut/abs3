create or replace force view v_compen_benef_for_visa as
select o.oper_id, t.text, o.oper_type, o.msg, p.fio, p.nsc, p.ost / 100 ost, b.fiob fio_benef, b.idb, o.regdate, p.id, 
       case when o.oper_type = 32 then crkr_compen_web.analiz_change_benef(o.compen_id, o.benef_idb) else null end as change_info,
       (select t.logname from staff$base t where t.id = o.user_id) user_login,
  decode(o.changedate, null, 0, 1) as is_change_state  
  from compen_oper o, compen_portfolio p, compen_oper_types t, compen_benef b
  where o.compen_id = p.id
    and o.oper_type = t.type_id
    and o.benef_idb = b.idb and o.compen_id = b.id_compen
    and o.state = 10/**/
    and o.oper_type in (31/**/, 32/**/, 33 /**/)
    and (o.mfo = sys_context('bars_context','user_mfo') or sys_context('bars_context','user_mfo') = '300465')
  with read only;
comment on table v_compen_benef_for_visa is 'Операції маніпуляцій з беніфіціарами на візування контролеру';
comment on column v_compen_benef_for_visa.OPER_ID is 'Ідентифиікатор операції';
comment on column v_compen_benef_for_visa.TEXT is 'Назва операції';
comment on column v_compen_benef_for_visa.MSG is 'Інформація';
comment on column v_compen_benef_for_visa.FIO is 'Прізвище на вкладі';
comment on column v_compen_benef_for_visa.NSC is 'Номер книжки';
comment on column v_compen_benef_for_visa.OST is 'Залишок на вкладі';
comment on column v_compen_benef_for_visa.fio_benef is 'Прізвище беніфіціара';
comment on column v_compen_benef_for_visa.REGDATE is 'Дата реєстрації';
comment on column v_compen_benef_for_visa.ID is 'ІД Вкладу';
comment on column v_compen_benef_for_visa.idb is 'ІД Беніфіціара';
comment on column v_compen_benef_for_visa.change_info is 'Інформація що змінювалось';
comment on column v_compen_benef_for_visa.IS_CHANGE_STATE is '1- була зміна статусу';

GRANT SELECT ON v_compen_benef_for_visa TO BARS_ACCESS_DEFROLE;