PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/table/msp_file_records.sql =========*** Run
PROMPT ===================================================================================== 

begin
    execute immediate 'create table msp_file_records
(
  id            NUMBER(38),
  file_id       NUMBER(38),
  deposit_acc   number(19),
  filia_num     NUMBER(5),
  deposit_code  NUMBER(3),
  pay_sum       NUMBER(19),
  full_name     VARCHAR2(100 CHAR),
  numident      VARCHAR2(10 CHAR),
  pay_day       VARCHAR2(2 CHAR),
  displaced     VARCHAR2(1 CHAR),
  state_id      NUMBER(3),
  block_type_id NUMBER(2),
  block_comment VARCHAR2(4000),
  rec_no        NUMBER(38),
  comm          VARCHAR2(4000),
  ref           NUMBER(38),
  fact_pay_date date,
  pers_acc_num  VARCHAR2(6)
)
tablespace BRSBIGD
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table MSP_FILE_RECORDS
  is 'Інформаційні рядки файлу обміну з банками';
-- Add comments to the columns 
comment on column MSP_FILE_RECORDS.id
  is 'id інформаційного рядка файлу';
comment on column MSP_FILE_RECORDS.file_id
  is 'id файлу';
comment on column MSP_FILE_RECORDS.deposit_acc
  is 'Номер рахунку вкладника';
comment on column MSP_FILE_RECORDS.filia_num
  is 'Номер фiлiї';
comment on column MSP_FILE_RECORDS.deposit_code
  is 'Код вкладу';
comment on column MSP_FILE_RECORDS.pay_sum
  is 'Сума (в коп.)';
comment on column MSP_FILE_RECORDS.full_name
  is 'Прiзвище, iм`я, по батьковi';
comment on column MSP_FILE_RECORDS.numident
  is 'Ідентифікаційний номер';
comment on column MSP_FILE_RECORDS.pay_day
  is 'День виплати';
comment on column MSP_FILE_RECORDS.displaced
  is 'Ознака ВПО';
comment on column MSP_FILE_RECORDS.state_id
  is 'Стан інформаційного рядка файлу';
comment on column MSP_FILE_RECORDS.block_type_id
  is 'Тип блокування';
comment on column MSP_FILE_RECORDS.block_comment
  is 'Коментар блокування';
comment on column MSP_FILE_RECORDS.ref
  is 'Референс созданного документа';
comment on column MSP_FILE_RECORDS.fact_pay_date
  is 'Фактична дата зарахування коштів';
comment on column MSP_FILE_RECORDS.pers_acc_num
  is 'Номер л/с';
comment on column msp.msp_file_records.rec_no 
  is 'Номер позиції в отриманому текстовому файлі';
comment on column msp.msp_file_records.comm 
  is 'Коментар';

begin
-- Create/Rebegin
    execute immediate 'create index I_MSP_FILE_RECORD_BLOCK_ID on MSP_FILE_RECORDS (BLOCK_TYPE_ID)';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'create index I_MSP_FILE_RECORD_FILE_ID on MSP_FILE_RECORDS (FILE_ID)';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'create index I_MSP_FILE_RECORD_STATE_ID on MSP_FILE_RECORDS (STATE_ID)';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table MSP_FILE_RECORDS
  add constraint PK_MSP_FILE_RECORD primary key (ID)
  using index ';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table MSP_FILE_RECORDS
  add constraint UK_MSP_FILE_RECORD_REF unique (REF)
  using index';
 exception when others then 
    if sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table MSP_FILE_RECORDS
  add constraint FK_MSP_BLOCK_TYPE_ID foreign key (BLOCK_TYPE_ID)
  references MSP_BLOCK_TYPE (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table MSP_FILE_RECORDS
  add constraint FK_MSP_FILE_RECORD_FILE_ID foreign key (FILE_ID)
  references MSP_FILES (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table MSP_FILE_RECORDS
  add constraint FK_MSP_FILE_RECORD_STATE_ID foreign key (STATE_ID)
  references MSP_FILE_RECORD_STATE (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table MSP_FILE_RECORDS
  add constraint CC_MSP_FILE_RECORD_FILE_ID_NN
  check ("FILE_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table MSP_FILE_RECORDS
  add constraint CC_MSP_FILE_RECORD_ID_NN
  check ("ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

begin 
  execute immediate 'alter table msp_file_records add state_comment varchar2(4000)';
exception when others then 
  if sqlcode in (-904, -6512, -1430) then 
    null; 
  else 
    raise; 
  end if;
end;
/
begin 
  execute immediate 'alter table msp_file_records add validation_state NUMBER(3)';
exception when others then 
  if sqlcode in (-904, -6512, -1430) then 
    null; 
  else 
    raise; 
  end if;
end;
/
comment on column MSP_FILE_RECORDS.state_comment
  is 'Коментар до зміни стану користувачем';
comment on column MSP_FILE_RECORDS.validation_state
  is 'Стан валідації';

alter table MSP.MSP_FILE_RECORDS modify pers_acc_num VARCHAR2(9);

-- Grant/Revoke object privileges 
grant update on MSP_FILE_RECORDS to BARS;
grant update on MSP_FILE_RECORDS to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/table/msp_file_records.sql =========*** End
PROMPT ===================================================================================== 
