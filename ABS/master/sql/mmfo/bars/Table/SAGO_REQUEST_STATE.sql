BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SAGO_REQUEST_STATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SAGO_REQUEST_STATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

-- Create table
begin
    execute immediate 'create table SAGO_REQUEST_STATE
(
  id   NUMBER(38),
  name VARCHAR2(1000)
)
tablespace BRSDYND
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
comment on table SAGO_REQUEST_STATE
  is 'Статусы запросов';
-- Add comments to the columns 
comment on column SAGO_REQUEST_STATE.id
  is 'Ид статуса';
comment on column SAGO_REQUEST_STATE.name
  is 'Наименование статуса';
-- Grant/Revoke object privileges 
grant select on SAGO_REQUEST_STATE to BARS_ACCESS_DEFROLE;
