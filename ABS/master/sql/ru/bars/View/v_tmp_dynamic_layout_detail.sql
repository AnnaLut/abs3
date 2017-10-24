create or replace view v_tmp_dynamic_layout_detail as 
select 
  v.id, 
  v.nd,     
  v.kv,
  v.branch,
  v.branch_name,
  v.nls_a,
  v.nls_b,
  v.percent,
  v.summ_a/100 summ_a,
  v.summ_b/100 summ_b,
  v.nls_count,
  v.userid 
from bars.tmp_dynamic_layout_detail v 
where  v.userid = bars.user_id;

comment on table v_tmp_dynamic_layout_detail is 'Деталі макету динамічних проводок';
comment on column v_tmp_dynamic_layout_detail.id  is 'Ідентифікатор';
comment on column v_tmp_dynamic_layout_detail.nd  is 'Номер документу(макету проводок)';
comment on column v_tmp_dynamic_layout_detail.kv is 'Код валюти';
comment on column v_tmp_dynamic_layout_detail.branch is 'Код бранчу';
comment on column v_tmp_dynamic_layout_detail.branch_name is 'Назва бранчу';
comment on column v_tmp_dynamic_layout_detail.nls_a is 'Рахунок А';
comment on column v_tmp_dynamic_layout_detail.nls_b is 'Рахунок бранчу';
comment on column v_tmp_dynamic_layout_detail.percent is 'відсоток від загальної суми';
comment on column v_tmp_dynamic_layout_detail.summ_a is 'Сума проводки з рахунку А';
comment on column v_tmp_dynamic_layout_detail.summ_b is 'Сума проводки в валюті Б';
comment on column v_tmp_dynamic_layout_detail.nls_count is 'Кількість рахунків Б';
/
grant select on bars.v_tmp_dynamic_layout to bars_access_defrole;
/