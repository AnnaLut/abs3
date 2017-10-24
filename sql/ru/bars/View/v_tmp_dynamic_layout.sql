create or replace view v_tmp_dynamic_layout as 
select 
  v.nd,
  v.datd,
  v.dk,
  v.summ/100 summ,       
  v.kv_a,
  v.nls_a,
  v.ostc/100 ostc,
  v.nms,
  v.nazn,
  v.date_from,
  v.date_to,
  v.dates_to_nazn,
  v.correction,
  v.ref,
  v.typed_percent,
  v.typed_summ/100 typed_summ,
  v.branch_count,
  v.userid
from bars.tmp_dynamic_layout v 
where  v.userid = bars.user_id;

comment on table v_tmp_dynamic_layout is 'Макет динамічних проводок (заголовок)';
comment on column v_tmp_dynamic_layout.nd is 'Номер документу(розпорядження)';
comment on column v_tmp_dynamic_layout.datd is 'Дата документу(розпорядження)';
comment on column v_tmp_dynamic_layout.dk is '1 - дебет, 0 - кредет';
comment on column v_tmp_dynamic_layout.summ is 'Загальна сума для розподылу';
comment on column v_tmp_dynamic_layout.kv_a is 'Код валюти рахунку А';
comment on column v_tmp_dynamic_layout.nls_a is 'Номер разунку А';
comment on column v_tmp_dynamic_layout.ostc is 'Залишок рахунку А';
comment on column v_tmp_dynamic_layout.nms is ' Найменування рахунку А';
comment on column v_tmp_dynamic_layout.nazn is 'Призначення платежу';
comment on column v_tmp_dynamic_layout.date_from is 'Дата з';
comment on column v_tmp_dynamic_layout.date_to is 'Дата по';
comment on column v_tmp_dynamic_layout.dates_to_nazn is 'Ознака додавання дати з та дати по до призначення платежу(0 - ні, 1 - так)';
comment on column v_tmp_dynamic_layout.correction is 'Ознака виконання платежу корегувальними оборотами';
comment on column v_tmp_dynamic_layout.ref is 'РЕФ';
comment on column v_tmp_dynamic_layout.typed_percent is 'набрано %';
comment on column v_tmp_dynamic_layout.typed_summ is ' набрано суму';
comment on column v_tmp_dynamic_layout.branch_count is 'кількість бранчів';

grant select on bars.v_tmp_dynamic_layout to bars_access_defrole;
