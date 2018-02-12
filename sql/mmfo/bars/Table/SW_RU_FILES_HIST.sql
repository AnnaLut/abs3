prompt ... 
begin 
  BPA.ALTER_POLICY_INFO( 'SW_RU_FILES_HIST', 'WHOLE' ,  null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'SW_RU_FILES_HIST', 'FILIAL', 'M', 'M', 'M', 'M');
end;
/

prompt ... 




-- Create table
begin
    execute immediate 'create table SW_RU_FILES_HIST
(
  id        NUMBER not null,
  state     NUMBER(10) not null,
  message   VARCHAR2(4000),
  sign      RAW(128),
  ddate     DATE not null,
  kf        VARCHAR2(6),
  file_data CLOB,
  sdate     DATE,
  chgdate   DATE
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

 exec bpa.alter_policies('SW_RU_FILES_HIST');