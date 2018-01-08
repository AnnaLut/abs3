

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/Table/BANKMON.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table BANKMON ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.BANKMON 
   (	PER_ID NUMBER, 
	BRANCH VARCHAR2(30), 
	KF VARCHAR2(12), 
	VIDP_PERS VARCHAR2(100), 
	PHONE VARCHAR2(20), 
	NAME_MON VARCHAR2(70), 
	KOD NUMBER, 
	COUNTRY VARCHAR2(20), 
	VAGA NUMBER, 
	VYMIR_OD VARCHAR2(20), 
	TYPE_MET NUMBER(*,0), 
	TEMA VARCHAR2(70), 
	CARB VARCHAR2(20), 
	CINA NUMBER, 
	CNT NUMBER(*,0), 
	CNT_SALE NUMBER(*,0), 
	ZDATE DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS_DM.BANKMON IS '��������� ������';
COMMENT ON COLUMN BARS_DM.BANKMON.PER_ID IS '������������� ������';
COMMENT ON COLUMN BARS_DM.BANKMON.BRANCH IS '³�������';
COMMENT ON COLUMN BARS_DM.BANKMON.KF IS '��� ��';
COMMENT ON COLUMN BARS_DM.BANKMON.VIDP_PERS IS '³���������� �����';
COMMENT ON COLUMN BARS_DM.BANKMON.PHONE IS '���������� ����� �������� ����������';
COMMENT ON COLUMN BARS_DM.BANKMON.NAME_MON IS '����� ������';
COMMENT ON COLUMN BARS_DM.BANKMON.KOD IS '��� ������';
COMMENT ON COLUMN BARS_DM.BANKMON.COUNTRY IS '�����';
COMMENT ON COLUMN BARS_DM.BANKMON.VAGA IS '����';
COMMENT ON COLUMN BARS_DM.BANKMON.VYMIR_OD IS '������� �����';
COMMENT ON COLUMN BARS_DM.BANKMON.TYPE_MET IS '��� ������';
COMMENT ON COLUMN BARS_DM.BANKMON.TEMA IS '��������';
COMMENT ON COLUMN BARS_DM.BANKMON.CARB IS '����� ����������';
COMMENT ON COLUMN BARS_DM.BANKMON.CINA IS 'ֳ�� � �������';
COMMENT ON COLUMN BARS_DM.BANKMON.CNT IS 'ʳ������ ��������� ��� ��������� ����� ';
COMMENT ON COLUMN BARS_DM.BANKMON.CNT_SALE IS 'ʳ������ �������� ����� �� ����� ����';
COMMENT ON COLUMN BARS_DM.BANKMON.ZDATE IS '����� ����';




PROMPT *** Create  constraint FK_BANKMON_PERID_PERIOD_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.BANKMON ADD CONSTRAINT FK_BANKMON_PERID_PERIOD_ID FOREIGN KEY (PER_ID)
	  REFERENCES BARS_DM.PERIODS (ID) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKMON_PERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.BANKMON MODIFY (PER_ID CONSTRAINT CC_BANKMON_PERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKMON_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.BANKMON MODIFY (BRANCH CONSTRAINT CC_BANKMON_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKMON_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.BANKMON MODIFY (KF CONSTRAINT CC_BANKMON_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_BANKMON_PERID ***
begin   
 execute immediate '
  CREATE INDEX BARS_DM.I_BANKMON_PERID ON BARS_DM.BANKMON (PER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BANKMON ***
grant SELECT                                                                 on BANKMON         to BARS;
grant SELECT                                                                 on BANKMON         to BARSUPL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Table/BANKMON.sql =========*** End *** ==
PROMPT ===================================================================================== 
