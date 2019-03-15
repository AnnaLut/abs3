BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SAGO_PARAMETERS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SAGO_PARAMETERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

-- Create table
begin
    execute immediate 'create table SAGO_PARAMETERS
(
  name  VARCHAR2(10),
  value VARCHAR2(4000),
  comm  VARCHAR2(4000)
)
tablespace BRSSMLD
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the columns 
comment on column SAGO_PARAMETERS.name
  is 'Назва параметру';
comment on column SAGO_PARAMETERS.value
  is 'Значення параметру';
comment on column SAGO_PARAMETERS.comm
  is 'Коментар';
  
grant select on SAGO_PARAMETERS to bars_access_defrole;
