begin
  BPA.ALTER_POLICY_INFO( 'ADR_CA_FILES_TRACK', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'ADR_CA_FILES_TRACK', 'FILIAL', null, null, null, null );
end;
/

prompt ... 


-- Create table
begin
    execute immediate 'create table ADR_CA_FILES_TRACK
(
  id          NUMBER not null,
  state       NUMBER(10) default 0 not null,
  message     VARCHAR2(4000),
  sign        RAW(128),
  ddate       DATE not null,
  request_mfo VARCHAR2(100) not null,
  id_file     NUMBER
)
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 128K
    minextents 1
    maxextents unlimited
    pctincrease 0
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table ADR_CA_FILES_TRACK
  is 'История обращений к ЦА за файлами';
-- Add comments to the columns 
comment on column ADR_CA_FILES_TRACK.id
  is 'Ідентифікатор';
comment on column ADR_CA_FILES_TRACK.state
  is 'Состояние ';
comment on column ADR_CA_FILES_TRACK.ddate
  is 'Дата обращения';
comment on column ADR_CA_FILES_TRACK.request_mfo
  is 'Адреса отримувача пакету';
comment on column ADR_CA_FILES_TRACK.id_file
  is 'Ідентифікатор файла в ЦА';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table ADR_CA_FILES_TRACK
  add constraint FK_ADRCAFILESTRACK_IDFILE foreign key (ID_FILE)
  references ADR_CA_FILES (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select, insert, update on ADR_CA_FILES_TRACK to BARS_ACCESS_DEFROLE;

