exec bpa.alter_policy_info('compen_portfolio', 'filial',  'M', 'M', 'M', 'M');
exec bpa.alter_policy_info('compen_portfolio', 'whole',  null,  'E', 'E', 'E');


begin
  execute immediate '
create table COMPEN_PORTFOLIO
(
  id                   NUMBER(14) not null,
  fio                  VARCHAR2(256),
  country              INTEGER,
  postindex            VARCHAR2(256),
  obl                  VARCHAR2(256),
  rajon                VARCHAR2(256),
  city                 VARCHAR2(256),
  address              VARCHAR2(512),
  fulladdress          VARCHAR2(999),
  icod                 VARCHAR2(128),
  doctype              INTEGER,
  docserial            VARCHAR2(16),
  docnumber            VARCHAR2(32),
  docorg               VARCHAR2(256),
  docdate              DATE,
  clientbdate          DATE,
  clientbplace         VARCHAR2(256),
  clientsex            CHAR(1),
  clientphone          VARCHAR2(128),
  registrydate         DATE,
  nsc                  VARCHAR2(32),
  ida                  VARCHAR2(32),
  nd                   VARCHAR2(256),
  sum                  NUMBER,
  ost                  NUMBER,
  dato                 DATE,
  datl                 DATE,
  attr                 VARCHAR2(10),
  card                 NUMBER(2),
  datn                 DATE,
  ver                  NUMBER(4),
  stat                 VARCHAR2(6),
  tvbv                 CHAR(3),
  branch               VARCHAR2(30),
  kv                   NUMBER(6),
  status               INTEGER,
  date_import          DATE,
  dbcode               VARCHAR2(32),
  percent              NUMBER,
  kkname               VARCHAR2(256),
  ob22                 CHAR(2),
  rnk                  NUMBER,
  branchact            VARCHAR2(30),
  close_date           DATE,
  reason_change_status VARCHAR2(255)
)tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table COMPEN_PORTFOLIO
  is 'Компенсаційні вклади';
-- Add comments to the columns 
comment on column COMPEN_PORTFOLIO.id
  is 'PK (min m_f_o_00000001 - max m_f_o_99999999)';
comment on column COMPEN_PORTFOLIO.fio
  is 'ПІБ';
comment on column COMPEN_PORTFOLIO.country
  is 'Код країни';
comment on column COMPEN_PORTFOLIO.postindex
  is 'Поштовий індекс';
comment on column COMPEN_PORTFOLIO.obl
  is 'Область';
comment on column COMPEN_PORTFOLIO.rajon
  is 'Район';
comment on column COMPEN_PORTFOLIO.city
  is 'Населений пункт';
comment on column COMPEN_PORTFOLIO.address
  is 'Адреса';
comment on column COMPEN_PORTFOLIO.fulladdress
  is 'Повна адреса';
comment on column COMPEN_PORTFOLIO.icod
  is 'Код ОКПО';
comment on column COMPEN_PORTFOLIO.doctype
  is 'Вид документу';
comment on column COMPEN_PORTFOLIO.docserial
  is 'Серія документу';
comment on column COMPEN_PORTFOLIO.docnumber
  is 'Номер документу';
comment on column COMPEN_PORTFOLIO.docorg
  is 'Орган, що видав документ';
comment on column COMPEN_PORTFOLIO.docdate
  is 'Дата видачі документу';
comment on column COMPEN_PORTFOLIO.clientbdate
  is 'Дата народження';
comment on column COMPEN_PORTFOLIO.clientbplace
  is 'Місце народження';
comment on column COMPEN_PORTFOLIO.clientsex
  is 'Стать (1-ч,2-ж,0-н)';
comment on column COMPEN_PORTFOLIO.clientphone
  is 'Телефон';
comment on column COMPEN_PORTFOLIO.registrydate
  is 'Дата заключення договору (datp)';
comment on column COMPEN_PORTFOLIO.nsc
  is 'Номер рахунку АСВО';
comment on column COMPEN_PORTFOLIO.ida
  is 'Iдентифiкатор рахунку АСВО';
comment on column COMPEN_PORTFOLIO.nd
  is 'Код = kkmark_tvbv_id_file_nsc';
comment on column COMPEN_PORTFOLIO.sum
  is 'Сумма внесків (sum*100)';
comment on column COMPEN_PORTFOLIO.ost
  is 'Сумма вкладу (ost*100)';
comment on column COMPEN_PORTFOLIO.dato
  is 'Дата відкриття вкладу (dato)';
comment on column COMPEN_PORTFOLIO.datl
  is 'Дата останньої операціі (datl)';
comment on column COMPEN_PORTFOLIO.attr
  is 'Символ облiку в межах картотеки АСВО';
comment on column COMPEN_PORTFOLIO.card
  is 'Порядковий номер картки АСВО';
comment on column COMPEN_PORTFOLIO.datn
  is 'Дата нарахування процентiв';
comment on column COMPEN_PORTFOLIO.ver
  is 'Версiя рахунку АСВО';
comment on column COMPEN_PORTFOLIO.stat
  is 'Контрольна сумма';
comment on column COMPEN_PORTFOLIO.tvbv
  is 'Код ТВБВ АСВО';
comment on column COMPEN_PORTFOLIO.branch
  is 'Бранч';
comment on column COMPEN_PORTFOLIO.kv
  is 'Код валюти';
comment on column COMPEN_PORTFOLIO.status
  is 'Статус';
comment on column COMPEN_PORTFOLIO.date_import
  is 'Дата імпорту';
comment on column COMPEN_PORTFOLIO.dbcode
  is 'дбкод для ідентифікації';
comment on column COMPEN_PORTFOLIO.percent
  is 'Відсоткова ставка';
comment on column COMPEN_PORTFOLIO.kkname
  is 'Назва вкладу';
comment on column COMPEN_PORTFOLIO.ob22
  is 'ОБ22';
comment on column COMPEN_PORTFOLIO.rnk
  is 'Реєстраційний номер клієнта';
comment on column COMPEN_PORTFOLIO.branchact
  is 'Бранч актуалізації';
comment on column COMPEN_PORTFOLIO.close_date
  is 'Дата закритя вкладу';
comment on column COMPEN_PORTFOLIO.reason_change_status
  is 'Причина зміни статусу';

begin
    execute immediate 'create index IDX_COMPEN_PORTFOLIO_RNK on COMPEN_PORTFOLIO (RNK)
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'create index IDX_COMPEN_PORTFOLIO_TVBV on COMPEN_PORTFOLIO (TVBV, SUBSTR(BRANCH,2,6))
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table COMPEN_PORTFOLIO
  add constraint PK_COMPEN_PORTFOLIO primary key (ID)
  using index 
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table COMPEN_PORTFOLIO
  add constraint FK_COMPEN_PORTFOLIO_STATUS foreign key (STATUS)
  references COMPEN_PORTFOLIO_STATUS (STATUS_ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table COMPEN_PORTFOLIO add rnk_bur NUMBER';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_PORTFOLIO add branchact_bur VARCHAR2(30)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_PORTFOLIO add ostasvo NUMBER';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

comment on column COMPEN_PORTFOLIO.rnk_bur
  is 'Реєстраційний номер клієнта отримувача на поховання';
comment on column COMPEN_PORTFOLIO.branchact_bur
  is 'Бранч актуалізації для виплати на поховання';
comment on column COMPEN_PORTFOLIO.ostasvo
  is 'Сумма вкладу (ost*100) из АСВО';


begin
    execute immediate 'alter table COMPEN_PORTFOLIO add branch_crkr VARCHAR2(30)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'create index IDX_COPMEN_PORTFOLIO_LFIO_NSC on COMPEN_PORTFOLIO (LOWER(FIO))
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'create index IDX_COMPEN_P_BRANCH_CRKR_OB22 on COMPEN_PORTFOLIO (branch_crkr, ob22)
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'drop index IDX_COMPEN_P_BRANCH_CRKR';
 exception when others then 
    if sqlcode = -1418 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'create index IDX_COMPEN_PORTFOLIO_DBCODE on COMPEN_PORTFOLIO (DBCODE)
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'create index IDX_COMPEN_P_BRANCHACT_RNK_BUR on COMPEN_PORTFOLIO (BRANCHACT_BUR, RNK_BUR)
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'create index IDX_COMPEN_PORTFOLIO_icod on COMPEN_PORTFOLIO (icod)
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'create index IDX_COMPEN_PORTFOLIO_branchact on COMPEN_PORTFOLIO (branchact)
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'create index IDX_COPMEN_PORTFOLIO_NSC on COMPEN_PORTFOLIO (NSC)
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


comment on column COMPEN_PORTFOLIO.branch
  is 'Бранч з яким замігрований вклад';
comment on column COMPEN_PORTFOLIO.branch_crkr
  is 'Поточний бранч вкладу';

begin
    execute immediate 'alter table COMPEN_PORTFOLIO add status_prev INTEGER';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

comment on column COMPEN_PORTFOLIO.status_prev is 'Попередній статус вкладу';


begin
    execute immediate 'alter table COMPEN_PORTFOLIO add type_person number(1) default 0';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

comment on column COMPEN_PORTFOLIO.type_person is 'Тип особи 0-фіз 1-юр (оф.спадщини, зміна документу)';

begin
    execute immediate 'alter table COMPEN_PORTFOLIO add name_person varchar2(255)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

comment on column COMPEN_PORTFOLIO.name_person is 'Назва юр.особи (оф.спадщини)';

begin
    execute immediate 'alter table COMPEN_PORTFOLIO add edrpo_person varchar2(10)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

comment on column COMPEN_PORTFOLIO.edrpo_person is 'ЄДРПОУ юр.особи (оф.спадщини)';


-- Grant/Revoke object privileges 
grant select, insert, update, delete on COMPEN_PORTFOLIO to START1;
grant select, insert, update, delete on COMPEN_PORTFOLIO to WR_ALL_RIGHTS;
