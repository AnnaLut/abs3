prompt ------------------------------------------
prompt  создание таблицы OW_CNG_DATA_TXT 
prompt ------------------------------------------
/
begin
  execute immediate 'begin bpa.alter_policy_info(''ow_cng_data_txt'', ''WHOLE'',  null, ''E'', ''E'', ''E''); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/
begin
  execute immediate 'begin bpa.alter_policy_info(''ow_cng_data_txt'', ''FILIAL'', ''M'', ''M'', ''M'', ''M''); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/
begin 
  execute immediate '
create table ow_cng_data_txt
(
   id        number,
   idn       number,   
   kf        varchar2 (6),
   nls       varchar2 (15),
   acc_pk    number,
   dat_bal   date,
   nbs_ow    varchar2 (15),
   ost       number
)';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
grant select, insert, update, delete on ow_cng_data_txt to bars_access_defrole;
/
begin 
  execute immediate '
create index bars.idx_ow_cng_data_txt_acc on bars.ow_cng_data_txt(acc_pk,nbs_ow,ost)';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
begin 
  execute immediate '
ALTER TABLE BARS.OW_CNG_DATA_TXT ADD (
  CONSTRAINT FK_OWCNGDATATXT_OWCNGTYPES
  FOREIGN KEY (NBS_OW) 
  REFERENCES BARS.OW_CNG_TYPES (NBS_OW)
  ENABLE VALIDATE)
';
exception when others then       
  if sqlcode=-2275 then null; else raise; end if; 
end;
/