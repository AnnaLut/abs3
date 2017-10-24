

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUR_RATES$BASE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUR_RATES$BASE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUR_RATES$BASE'', ''FILIAL'' , null, null, ''B'', ''N'');
               bpa.alter_policy_info(''CUR_RATES$BASE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUR_RATES$BASE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUR_RATES$BASE 
   (	KV NUMBER(3,0), 
	VDATE DATE, 
	BSUM NUMBER(9,4), 
	RATE_O NUMBER(9,4), 
	RATE_B NUMBER(9,4), 
	RATE_S NUMBER(9,4), 
	RATE_SPOT NUMBER(9,4), 
	RATE_FORWARD NUMBER(9,4), 
	LIM_POS NUMBER(24,0), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	OTM VARCHAR2(1) DEFAULT ''Y'', 
	OFFICIAL VARCHAR2(1) DEFAULT ''N''
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUR_RATES$BASE ***
 exec bpa.alter_policies('CUR_RATES$BASE');


COMMENT ON TABLE BARS.CUR_RATES$BASE IS '����������� ����� �����';
COMMENT ON COLUMN BARS.CUR_RATES$BASE.OFFICIAL IS 'Y-������ ���.����, N-�� ������ ���.����';
COMMENT ON COLUMN BARS.CUR_RATES$BASE.KV IS '��� ������';
COMMENT ON COLUMN BARS.CUR_RATES$BASE.VDATE IS '���� ������������� (��������� �����)';
COMMENT ON COLUMN BARS.CUR_RATES$BASE.BSUM IS '������� �����';
COMMENT ON COLUMN BARS.CUR_RATES$BASE.RATE_O IS '����������� ����';
COMMENT ON COLUMN BARS.CUR_RATES$BASE.RATE_B IS '���� �������';
COMMENT ON COLUMN BARS.CUR_RATES$BASE.RATE_S IS '���� �������';
COMMENT ON COLUMN BARS.CUR_RATES$BASE.RATE_SPOT IS 'SPOT-����';
COMMENT ON COLUMN BARS.CUR_RATES$BASE.RATE_FORWARD IS '���� ��� ���������� ������';
COMMENT ON COLUMN BARS.CUR_RATES$BASE.LIM_POS IS '�����';
COMMENT ON COLUMN BARS.CUR_RATES$BASE.BRANCH IS '��. �������������';
COMMENT ON COLUMN BARS.CUR_RATES$BASE.OTM IS '������� � ����������� (Y-������������, N-���)';




PROMPT *** Create  constraint FK_CURRATES$BASE_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATES$BASE ADD CONSTRAINT FK_CURRATES$BASE_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CURRATES$BASE_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATES$BASE ADD CONSTRAINT FK_CURRATES$BASE_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CURRATES$BASE_VDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATES$BASE ADD CONSTRAINT CC_CURRATES$BASE_VDATE CHECK (vdate = trunc(vdate)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CURRATES$BASE_OTM ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATES$BASE ADD CONSTRAINT CC_CURRATES$BASE_OTM CHECK (OTM in (''Y'',''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CURRATES$BASE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATES$BASE ADD CONSTRAINT PK_CURRATES$BASE PRIMARY KEY (BRANCH, VDATE, KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009557 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATES$BASE MODIFY (OTM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CURRATES$BASE_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATES$BASE MODIFY (BRANCH CONSTRAINT CC_CURRATES$BASE_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CURRATES$BASE_RATEO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATES$BASE MODIFY (RATE_O CONSTRAINT CC_CURRATES$BASE_RATEO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CURRATES$BASE_BSUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATES$BASE MODIFY (BSUM CONSTRAINT CC_CURRATES$BASE_BSUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CURRATES$BASE_VDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATES$BASE MODIFY (VDATE CONSTRAINT CC_CURRATES$BASE_VDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CURRATES$BASE_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATES$BASE MODIFY (KV CONSTRAINT CC_CURRATES$BASE_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CURRATES$BASE_OFFICIAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATES$BASE ADD CONSTRAINT CC_CURRATES$BASE_OFFICIAL CHECK (OFFICIAL in (''Y'',''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CURRATES$BASE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CURRATES$BASE ON BARS.CUR_RATES$BASE (BRANCH, VDATE, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_CURRATES$BASE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_CURRATES$BASE ON BARS.CUR_RATES$BASE (KV, VDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 1 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUR_RATES$BASE ***
grant SELECT                                                                 on CUR_RATES$BASE  to BARS;
grant SELECT                                                                 on CUR_RATES$BASE  to BARSAQ with grant option;
grant SELECT                                                                 on CUR_RATES$BASE  to BARSUPL;
grant INSERT,SELECT,UPDATE                                                   on CUR_RATES$BASE  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUR_RATES$BASE  to BARS_SUP;
grant SELECT                                                                 on CUR_RATES$BASE  to JBOSS_USR;
grant INSERT,SELECT,UPDATE                                                   on CUR_RATES$BASE  to PYOD001;
grant INSERT,SELECT,UPDATE                                                   on CUR_RATES$BASE  to TECH005;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUR_RATES$BASE  to WR_ALL_RIGHTS;
grant SELECT                                                                 on CUR_RATES$BASE  to WR_RATES;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUR_RATES$BASE.sql =========*** End **
PROMPT ===================================================================================== 
