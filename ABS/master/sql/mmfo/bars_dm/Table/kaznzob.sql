

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/Table/KAZNZOB.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table KAZNZOB ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.KAZNZOB 
   (	PER_ID NUMBER, 
	BRANCH VARCHAR2(30), 
	KF VARCHAR2(12), 
	VIDP_PERS VARCHAR2(100), 
	PHONE VARCHAR2(20), 
	NOMINAL NUMBER, 
	KV NUMBER, 
	CNT NUMBER, 
	CNT_SALE NUMBER, 
	ZDATE DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS_DM.KAZNZOB IS '����������� �����������';
COMMENT ON COLUMN BARS_DM.KAZNZOB.PER_ID IS '������������� ������';
COMMENT ON COLUMN BARS_DM.KAZNZOB.BRANCH IS '³�������';
COMMENT ON COLUMN BARS_DM.KAZNZOB.KF IS '��� ��';
COMMENT ON COLUMN BARS_DM.KAZNZOB.VIDP_PERS IS '³���������� �����';
COMMENT ON COLUMN BARS_DM.KAZNZOB.PHONE IS '���������� ����� �������� ����������';
COMMENT ON COLUMN BARS_DM.KAZNZOB.NOMINAL IS '������';
COMMENT ON COLUMN BARS_DM.KAZNZOB.KV IS '������';
COMMENT ON COLUMN BARS_DM.KAZNZOB.CNT IS 'ʳ������ ��������� ��� ��������� ��';
COMMENT ON COLUMN BARS_DM.KAZNZOB.CNT_SALE IS 'ʳ������ �������� ��';
COMMENT ON COLUMN BARS_DM.KAZNZOB.ZDATE IS '����� ����';




PROMPT *** Create  constraint FK_KAZNZOB_PERID_PERIOD_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.KAZNZOB ADD CONSTRAINT FK_KAZNZOB_PERID_PERIOD_ID FOREIGN KEY (PER_ID)
	  REFERENCES BARS_DM.PERIODS (ID) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KAZNZOB_PERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.KAZNZOB MODIFY (PER_ID CONSTRAINT CC_KAZNZOB_PERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KAZNZOB_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.KAZNZOB MODIFY (BRANCH CONSTRAINT CC_KAZNZOB_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KAZNZOB_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.KAZNZOB MODIFY (KF CONSTRAINT CC_KAZNZOB_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_KAZNZOB_PERID ***
begin   
 execute immediate '
  CREATE INDEX BARS_DM.I_KAZNZOB_PERID ON BARS_DM.KAZNZOB (PER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KAZNZOB ***
grant SELECT                                                                 on KAZNZOB         to BARS;
grant SELECT                                                                 on KAZNZOB         to BARSUPL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Table/KAZNZOB.sql =========*** End *** ==
PROMPT ===================================================================================== 
