BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OVR_TERM_TRZ_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OVR_TERM_TRZ_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

prompt ... 


-- Create table
begin
    execute immediate 'create table OVR_TERM_TRZ_UPDATE
(
  idupd           NUMBER(38),
  chgaction       CHAR(1),
  effectdate      DATE,
  chgdate         DATE,
  doneby          NUMBER(38),
  kf              VARCHAR2(6) default sys_context(''bars_context'',''user_mfo''),
  acc   NUMBER,
  datvz DATE,
  datsp DATE,
  trz   INTEGER,
  acc1  NUMBER
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
comment on table OVR_TERM_TRZ_UPDATE
  is 'Плановые авто-даты выноса на просрочку (тормозной путь)';
-- Add comments to the columns 
comment on column OVR_TERM_TRZ_UPDATE.acc
  is 'Ответчик';
comment on column OVR_TERM_TRZ_UPDATE.datvz
  is 'Факт-дата возникновения события';
comment on column OVR_TERM_TRZ_UPDATE.datsp
  is 'План-дата выноса на просрочку';
comment on column OVR_TERM_TRZ_UPDATE.acc1
  is 'Нарушитель';
-- Grant/Revoke object privileges 
grant select on OVR_TERM_TRZ_UPDATE to BARSREADER_ROLE;
grant select on OVR_TERM_TRZ_UPDATE to UPLD;
