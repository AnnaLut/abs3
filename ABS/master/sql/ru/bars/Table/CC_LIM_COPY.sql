prompt -- ======================================================
prompt -- create Table BARS.CC_LIM_COPY
prompt -- ======================================================

SET FEEDBACK     OFF

exec bpa.alter_policy_info('CC_LIM_COPY', 'FILIAL',  null,  null, null, null);
exec bpa.alter_policy_info('CC_LIM_COPY', 'WHOLE',  null,  null, null, null);
/
begin
  execute immediate 'create table CC_LIM_COPY
(
  id        NUMBER,
  nd        NUMBER(38),
  fdat      DATE,
  lim2      NUMBER(38),
  acc       INTEGER,
  not_9129  INTEGER,
  sumg      NUMBER(38),
  sumo      NUMBER(38),
  otm       INTEGER,
  kf        VARCHAR2(6),
  sumk      NUMBER,
  not_sn    INTEGER,
  oper_date DATE default sysdate not null,
  userid    NUMBER default sys_context(''userenv'', ''session_userid'') not null
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
  )
';
    dbms_output.put_line('Table BARS.ESCR_LIMITS created.'); 
exception
  when others then
    if sqlcode = -955 then
         dbms_output.put_line('Table BARS.ESCR_LIMITS already exists.'); 
    else raise;
    end if;
end;
/
 
SET FEEDBACK     ON