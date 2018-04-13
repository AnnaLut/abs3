-- Create table
begin 
  execute immediate '
create global temporary table TMP_OLD_STATE
(
  doc_id    NUMBER not null,
  status_id NUMBER
)
on commit preserve rows ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
-- Add comments to the columns 
comment on column TMP_OLD_STATE.doc_id
  is 'Номер зависшего документа из corp2';
comment on column TMP_OLD_STATE.status_id
  is 'Статус = 45';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table TMP_OLD_STATE
  add constraint PK_TMP_OLD_STATE primary key (DOC_ID)';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

