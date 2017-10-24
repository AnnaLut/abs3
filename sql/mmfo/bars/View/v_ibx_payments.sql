-- IBOX
-- tvSukhov 28/08/2013
-- Реестр платежей для формы квитовки с IBOX

create or replace view v_ibx_payments as
select substr(ir.type_id, 1, 99) as typi,
       ir.ext_ref as iref,
       ir.ext_date as idat,
       ir.ext_source,
       ir.deal_id as ccid,
       ir.summ/100 as isum,
       ir.abs_ref as aref,
       ir.kwt as ikwt,
       substr(if.file_name, 1, 99) as nfil,
       if.file_date as ofil,
       if.total_count as kfil,
       if.total_sum as sfil,
       if.loaded as dfil
  from ibx_recs ir, ibx_files if
 where ir.type_id = if.type_id(+)
   and ir.file_name = if.file_name(+)
 order by ir.ext_ref desc;

comment on table v_ibx_payments is 'Реестр платежей для формы квитовки с IBOX';
comment on column v_ibx_payments.typi is 'Тип интерфейса';
comment on column v_ibx_payments.iref is 'Реф. пл. в IBOX';
comment on column v_ibx_payments.idat is 'Дата/время в IBOX';
comment on column v_ibx_payments.ccid is '№ КД';
comment on column v_ibx_payments.isum is 'Сумма в целых';
comment on column v_ibx_payments.aref is 'Реф. пл. в АБC';
comment on column v_ibx_payments.ikwt is 'КВТ: 1 - OK, 0 - ERR, Null - не обр';
comment on column v_ibx_payments.nfil is 'Имя файла';
comment on column v_ibx_payments.ofil is 'Дата файла';
comment on column v_ibx_payments.kfil is 'Всего записей';
comment on column v_ibx_payments.sfil is 'Всего сумма';
comment on column v_ibx_payments.dfil is 'Дата/время принятия';

grant select on v_ibx_payments to bars_access_defrole;
