begin
    execute immediate 'create table PFU.PFU_FILE_TYPE
(
  id   VARCHAR2(2),
  name VARCHAR2(15)
)';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table PFU.PFU_FILE_TYPE
  is '���� ������ ���';
-- Add comments to the columns 
comment on column PFU.PFU_FILE_TYPE.id
  is '�� ���� ������ (1-�����, 2-�������)';
comment on column PFU.PFU_FILE_TYPE.name
  is '����� ����';
-- Grant/Revoke object privileges 
grant select on PFU.PFU_FILE_TYPE to BARS_ACCESS_DEFROLE;
