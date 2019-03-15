BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SAGO_REGION'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SAGO_REGION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

begin
    execute immediate 'create table SAGO_REGION
(
  reg_id NUMBER,
  namе   VARCHAR2(300),
  kf     VARCHAR2(6)
)
tablespace BRSSMLD
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

-- Add comments to the columns 
comment on column SAGO_REGION.reg_id
  is 'Ідентифікатор региону САГО';
comment on column SAGO_REGION.namе
  is 'Найменування регіону';
comment on column SAGO_REGION.kf
  is 'Код нашого МФО';
-- Grant/Revoke object privileges 
grant select on SAGO_REGION to BARS_ACCESS_DEFROLE;
