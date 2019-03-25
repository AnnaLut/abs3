begin
  bpa.alter_policy_info('CHECK_PAY_FILE_A', 'FILIAL', 'M', 'M', 'M', 'M');
  bpa.alter_policy_info('CHECK_PAY_FILE_A', 'WHOLE',  null, null, null, null);
  commit;
exception when others then null;   
end;
/



begin
execute immediate '
CREATE TABLE BARS.CHECK_PAY_FILE_A
(
  ND      VARCHAR2(10 BYTE),
  S       NUMBER(24),
  NLSA    VARCHAR2(15 BYTE),
  NLSB    VARCHAR2(15 BYTE),
  MFOA    VARCHAR2(12 BYTE),
  MFOB    VARCHAR2(12 BYTE),
  LCV     CHAR(3 BYTE),
  pdat    DATE,
  VDAT    DATE,
  kf     varchar2(6) default sys_context(''bars_context'',''user_mfo''),
  constraint pk_CHECKPAYFILEA primary key (nd, s,nlsa,nlsb,mfoa,mfob,lcv,pdat,vdat,kf)
) tablespace BRSBIGD';
exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/

exec bpa.alter_policies('CHECK_PAY_FILE_A');


grant select, insert, delete on CHECK_PAY_FILE_A to BARS_ACCESS_DEFROLE;