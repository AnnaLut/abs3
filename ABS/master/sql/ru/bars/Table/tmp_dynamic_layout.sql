begin 
  execute immediate '
create table bars.tmp_dynamic_layout
(
  nd varchar2(10),
  datd date,
  dk number (1),
  summ number(38),       
  kv_a number(3),
  nls_a varchar2(15),
  ostc number(38),
  nms varchar2(70),
  nazn varchar2(256),
  date_from date,
  date_to date,
  dates_to_nazn number(1),
  correction number(1),
  ref number(38),
  typed_percent number (5,2),
  typed_summ number (38),
  branch_count number(38),
  userid number(38)
)
SEGMENT CREATION IMMEDIATE 
 NOCOMPRESS LOGGING
TABLESPACE BRSSMLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

comment on table tmp_dynamic_layout is 'Макет динамічних проводок (заголовок)';
comment on column tmp_dynamic_layout.nd is 'Номер документу(розпорядження)';
comment on column tmp_dynamic_layout.datd is 'Дата документу(розпорядження)';
comment on column tmp_dynamic_layout.dk is '1 - дебет, 0 - кредет';
comment on column tmp_dynamic_layout.summ is 'Загальна сума для розподылу';
comment on column tmp_dynamic_layout.kv_a is 'Код валюти рахунку А';
comment on column tmp_dynamic_layout.nls_a is 'Номер разунку А';
comment on column tmp_dynamic_layout.ostc is 'Залишок рахунку А';
comment on column tmp_dynamic_layout.nms is ' Найменування рахунку А';
comment on column tmp_dynamic_layout.nazn is 'Призначення платежу';
comment on column tmp_dynamic_layout.date_from is 'Дата з';
comment on column tmp_dynamic_layout.date_to is 'Дата по';
comment on column tmp_dynamic_layout.dates_to_nazn is 'Ознака додавання дати з та дати по до призначення платежу(0 - ні, 1 - так)';
comment on column tmp_dynamic_layout.correction is 'Ознака виконання платежу корегувальними оборотами';
comment on column tmp_dynamic_layout.ref is 'РЕФ';
comment on column tmp_dynamic_layout.typed_percent is 'набрано %';
comment on column tmp_dynamic_layout.typed_summ is ' набрано суму';
comment on column tmp_dynamic_layout.branch_count is 'кількість бранчів';
/
grant select, insert, update, delete on tmp_dynamic_layout to bars_access_defrole;
/


