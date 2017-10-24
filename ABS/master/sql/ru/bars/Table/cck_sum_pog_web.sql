begin
  bpa.alter_policy_info('CCK_SUM_POG_WEB', 'FILIAL', 'M', 'M', 'M', 'M');
  bpa.alter_policy_info('CCK_SUM_POG_WEB', 'WHOLE',  null, null, null, null);
  commit;
exception when others then null;   
end;
/



begin
execute immediate '
CREATE TABLE BARS.CCK_SUM_POG_WEB
(
  ACC    INTEGER,
  ND     INTEGER,
  KV     INTEGER,
  RNK    INTEGER,
  NMK    VARCHAR2(58 BYTE),
  CC_ID  VARCHAR2(20 BYTE),
  G1     NUMBER,
  G2     NUMBER,
  G3     NUMBER(24),
  G4     NUMBER,
  kf     varchar2(6) default sys_context(''bars_context'',''user_mfo''),
  rec_id varchar2(32)
)';
exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/

exec bpa.alter_policies('CCK_SUM_POG_WEB');


grant select, insert, delete on CCK_SUM_POG_WEB to BARS_ACCESS_DEFROLE;