prompt ... 

exec bpa.alter_policy_info('TMP_OVR', 'FILIAL', 'M', 'M', 'M', 'M');
exec bpa.alter_policy_info('TMP_OVR', 'WHOLE',  null, null, null, null );

/


-- Create table
begin
    execute immediate 'create table TMP_OVR
(
  dat    DATE,
  id     INTEGER,
  dk     INTEGER,
  nlsa   VARCHAR2(15),
  nlsb   VARCHAR2(15),
  s      NUMBER(38),
  txt    VARCHAR2(35),
  branch VARCHAR2(30) default sys_context(''bars_context'',''user_branch''),
  kf     VARCHAR2(6) default sys_context(''bars_context'',''user_mfo'')
)
tablespace BRSMDLD
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 128K
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table TMP_OVR
  add constraint FK_TMP_OVR_BRANCH foreign key (BRANCH)
  references BRANCH (BRANCH)
  deferrable
  novalidate';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table TMP_OVR
  add constraint CC_TMPOVR_BRANCH_NN
  check ("BRANCH" IS NOT NULL)
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

begin 
   execute immediate('alter table TMP_OVR add "KF" VARCHAR2(6 BYTE  ) ');
   execute immediate 'alter table TMP_OVR MODIFY KF default sys_context(''bars_context'',''user_mfo'')';
exception when others then 
   null; 
end;
/

-- Grant/Revoke object privileges 
grant select, insert, update, delete on TMP_OVR to BARS009;
grant select on TMP_OVR to BARSREADER_ROLE;
grant select, insert, delete on TMP_OVR to BARS_ACCESS_DEFROLE;
grant select on TMP_OVR to BARS_DM;
grant select, insert, delete on TMP_OVR to ELT;
grant select on TMP_OVR to RCC_DEAL;
grant select on TMP_OVR to UPLD;
grant select, insert, update, delete on TMP_OVR to WR_ALL_RIGHTS;


exec bpa.alter_policies('TMP_OVR');


