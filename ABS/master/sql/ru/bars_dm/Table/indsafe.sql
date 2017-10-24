

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/Table/INDSAFE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table INDSAFE ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.INDSAFE 
   (	PER_ID NUMBER, 
	BRANCH VARCHAR2(30), 
	KF VARCHAR2(12), 
	VIDP_PERS VARCHAR2(100), 
	PHONE VARCHAR2(20), 
	SAFENUM NUMBER(*,0), 
	STAN VARCHAR2(20), 
	NTYPE VARCHAR2(50), 
	HEIGHT NUMBER, 
	WIDTH NUMBER, 
	DEPTH NUMBER, 
	PRICE NUMBER, 
	CUST_BRANCH VARCHAR2(30), 
	CUST_KF VARCHAR2(12), 
	CUST_RNK NUMBER, 
	DAT_BEGIN DATE, 
	NDOG VARCHAR2(20), 
	DAT_END DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS_DM.INDSAFE IS '������������� ����';
COMMENT ON COLUMN BARS_DM.INDSAFE.PER_ID IS '������������� ������';
COMMENT ON COLUMN BARS_DM.INDSAFE.BRANCH IS '³�������';
COMMENT ON COLUMN BARS_DM.INDSAFE.KF IS '��� ��';
COMMENT ON COLUMN BARS_DM.INDSAFE.VIDP_PERS IS '³���������� �����';
COMMENT ON COLUMN BARS_DM.INDSAFE.PHONE IS '���������� ����� �������� ����������';
COMMENT ON COLUMN BARS_DM.INDSAFE.SAFENUM IS '����� �����';
COMMENT ON COLUMN BARS_DM.INDSAFE.STAN IS '����';
COMMENT ON COLUMN BARS_DM.INDSAFE.NTYPE IS '����� ���� ��������';
COMMENT ON COLUMN BARS_DM.INDSAFE.HEIGHT IS '������, ��';
COMMENT ON COLUMN BARS_DM.INDSAFE.WIDTH IS '������, ��';
COMMENT ON COLUMN BARS_DM.INDSAFE.DEPTH IS '�������, ��';
COMMENT ON COLUMN BARS_DM.INDSAFE.PRICE IS '�������';
COMMENT ON COLUMN BARS_DM.INDSAFE.CUST_BRANCH IS '�볺��, ³�������';
COMMENT ON COLUMN BARS_DM.INDSAFE.CUST_KF IS '�볺��, ���������� ���������';
COMMENT ON COLUMN BARS_DM.INDSAFE.CUST_RNK IS '�볺��, ���';
COMMENT ON COLUMN BARS_DM.INDSAFE.DAT_BEGIN IS '������ �� ';
COMMENT ON COLUMN BARS_DM.INDSAFE.NDOG IS '� ��������';
COMMENT ON COLUMN BARS_DM.INDSAFE.DAT_END IS '���� ��������� ��������';




PROMPT *** Create  constraint FK_INDSAFE_PERID_PERIOD_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.INDSAFE ADD CONSTRAINT FK_INDSAFE_PERID_PERIOD_ID FOREIGN KEY (PER_ID)
	  REFERENCES BARS_DM.PERIODS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INDSAFE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.INDSAFE MODIFY (KF CONSTRAINT CC_INDSAFE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INDSAFE_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.INDSAFE MODIFY (BRANCH CONSTRAINT CC_INDSAFE_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INDSAFE_PERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.INDSAFE MODIFY (PER_ID CONSTRAINT CC_INDSAFE_PERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_INDSAFE_PERID ***
begin   
 execute immediate '
  CREATE INDEX BARS_DM.I_INDSAFE_PERID ON BARS_DM.INDSAFE (PER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INDSAFE ***
grant SELECT                                                                 on INDSAFE         to BARS;
grant SELECT                                                                 on INDSAFE         to BARSUPL;
grant SELECT                                                                 on INDSAFE         to BARS_SUP;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Table/INDSAFE.sql =========*** End *** ==
PROMPT ===================================================================================== 
