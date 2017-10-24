begin
  bpa.alter_policy_info('CCK_AN_WEB', 'FILIAL', 'M', 'M', 'M', 'M');
  bpa.alter_policy_info('CCK_AN_WEB', 'WHOLE',  null, null, null, null);
  commit;
exception when others then null;   
end;
/



begin
execute immediate '
CREATE TABLE BARS.CCK_AN_WEB
(
    DL       CHAR(1 BYTE),
  NBS      CHAR(4 BYTE),
  PR       NUMBER,
  PRS      NUMBER,
  SROK     NUMBER,
  KV       INTEGER,
  N1       NUMBER,
  N2       NUMBER,
  N3       NUMBER,
  NAME     VARCHAR2(30 BYTE),
  OE       INTEGER,
  INSIDER  INTEGER,
  TIP      INTEGER,
  POROG    INTEGER,
  N4       NUMBER,
  N5       NUMBER,
  REG      INTEGER,
  ACCL     INTEGER,
  ACC      INTEGER,
  ACRA     INTEGER,
  CC_ID    VARCHAR2(20 BYTE),
  ZAL      NUMBER,
  ZALQ     NUMBER,
  REZ      NUMBER,
  REZQ     NUMBER,
  UV       NUMBER,
  NLS      VARCHAR2(15 BYTE),
  AIM      INTEGER,
  USERID   NUMBER,
  BRANCH   VARCHAR2(30 BYTE),
  ND       NUMBER,
  NAME1    VARCHAR2(35 BYTE),
  NLSALT   VARCHAR2(15 BYTE),
  kf     varchar2(6) default sys_context(''bars_context'',''user_mfo''),
  rec_id varchar2(32)
)';
exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/

exec bpa.alter_policies('CCK_AN_WEB');


grant select, insert, delete on CCK_AN_WEB to BARS_ACCESS_DEFROLE;