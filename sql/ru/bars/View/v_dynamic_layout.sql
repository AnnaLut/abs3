create or replace view v_dynamic_layout as 
select id, 
  nvl(dk,1) dk,
  name, 
  nls, 
  bs1 bs,
  ob1 ob,  
  nazn1 nazn,
  datp, 
  alg, 
  grp
from ope_lot 
where  ob22 = '~~' ;

comment on table bars.v_dynamic_layout  is 'Динамічні макети';
comment on column bars.v_dynamic_layout.id  is 'Ідентифікатор';
comment on column bars.v_dynamic_layout.name  is 'Найменування макету';
comment on column bars.v_dynamic_layout.nls  is 'Рахунок А';
comment on column bars.v_dynamic_layout.bs  is 'Балансовий рахунок';
comment on column bars.v_dynamic_layout.ob  is 'ОБ22';
comment on column bars.v_dynamic_layout.nazn  is 'Попередне призначення платежу';
comment on column bars.v_dynamic_layout.datp  is 'Дата попереднього виконання';
comment on column bars.v_dynamic_layout.alg  is '№ алг';
comment on column bars.v_dynamic_layout.grp  is '';

grant select on bars.v_dynamic_layout to bars_access_defrole;
