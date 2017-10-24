begin 
  execute immediate 'drop table tmp_dynamic_layout_detail';
  exception when others then null;
end;
/
begin 
  execute immediate '
create table tmp_dynamic_layout_detail
(
  id 			number(38), 
  dk 		    number(1), 
  nd 			varchar2(10),     
  kv 			number(3),
  branch 		varchar2(30),
  branch_name 	varchar2(70),
  nls_a 		varchar2(15),
  nama			varchar2(256),
  okpoa 		varchar2(14),
  mfob 			varchar2(12),
  mfob_name 	varchar2(256),
  nls_b 		varchar2(15),
  namb          varchar2(38),
  okpob 		varchar2(14),
  percent 		number(5,2),
  summ_a 		number(38),
  summ_b 		number(38),
  delta 		number(38),
  tt			varchar2(3),
  vob			number,
  nazn 			varchar2(256),
  ref 			varchar2(64),
  nls_count 	number(38),
  userid 		number
)
SEGMENT CREATION IMMEDIATE 
 NOCOMPRESS LOGGING
TABLESPACE BRSSMLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
comment on table tmp_dynamic_layout_detail is 'Деталі макету динамічних проводок';
comment on column tmp_dynamic_layout_detail.id  is 'Ідентифікатор';
comment on column tmp_dynamic_layout_detail.dk  is 'Ознака 1 дебет, 2 - кредет';
comment on column tmp_dynamic_layout_detail.nd  is 'Номер документу(макету проводок)';
comment on column tmp_dynamic_layout_detail.kv is 'Код валюти';
comment on column tmp_dynamic_layout_detail.branch is 'Код бранчу';
comment on column tmp_dynamic_layout_detail.branch_name is 'Назва бранчу';
comment on column tmp_dynamic_layout_detail.nls_a is 'Рахунок А';
comment on column tmp_dynamic_layout_detail.nama is 'Найменування Рахуноку А';
comment on column tmp_dynamic_layout_detail.okpoa is 'ОКПО А';
comment on column tmp_dynamic_layout_detail.namb is 'МФО Б';
comment on column tmp_dynamic_layout_detail.okpob is 'ОКПО Б';
comment on column tmp_dynamic_layout_detail.nls_b is 'Рахунок бранчу';
comment on column tmp_dynamic_layout_detail.percent is 'відсоток від загальної суми';
comment on column tmp_dynamic_layout_detail.summ_a is 'Сума проводки з рахунку А';
comment on column tmp_dynamic_layout_detail.summ_b is 'Сума проводки в валюті Б';
comment on column tmp_dynamic_layout_detail.delta is '+ или - константа к сумме';
comment on column tmp_dynamic_layout_detail.tt is 'Тип операції';
comment on column tmp_dynamic_layout_detail.vob is 'Код ОП';
comment on column tmp_dynamic_layout_detail.nls_count is 'Кількість рахунків Б';
/
grant select, insert, update, delete on tmp_dynamic_layout_detail to bars_access_defrole;
/