

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_CNG_DATA.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_CNG_DATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_CNG_DATA'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OW_CNG_DATA'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_CNG_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_CNG_DATA 
   (	ID NUMBER(22,0), 
	IDN NUMBER(22,0), 
	CONTRACT_ID VARCHAR2(30), 
	CONTRACT_ACC VARCHAR2(14), 
	CONTRACT_CURRENCY VARCHAR2(3), 
	CONTRACT_NAME VARCHAR2(100), 
	CONTRACT_DATEOPEN DATE, 
	PLASTIC_TITLE VARCHAR2(30), 
	PLASTIC_FIRSTNAME VARCHAR2(30), 
	PLASTIC_LASTNAME VARCHAR2(30), 
	PLASTIC_COMPANYNAME VARCHAR2(100), 
	AVL_AMOUNT NUMBER(20,2), 
	OWN_AMOUNT NUMBER(20,2), 
	BLK_AMOUNT NUMBER(20,2), 
	CR_AMOUNT NUMBER(20,2), 
	ACC NUMBER(22,0), 
	MOB_AMOUNT NUMBER(20,2), 
	SEC_AMOUNT NUMBER(20,2), 
	CNGDATE DATE, 
	AD_AMOUNT NUMBER(20,2), 
	VIRTUAL_AMOUNT NUMBER(20,2), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_CNG_DATA ***
 exec bpa.alter_policies('OW_CNG_DATA');


COMMENT ON TABLE BARS.OW_CNG_DATA IS 'OpenWay. ���������� ����� CNGEXPORT';
COMMENT ON COLUMN BARS.OW_CNG_DATA.CNGDATE IS '';
COMMENT ON COLUMN BARS.OW_CNG_DATA.AD_AMOUNT IS 'ADRESS1 - ?????';
COMMENT ON COLUMN BARS.OW_CNG_DATA.VIRTUAL_AMOUNT IS 'VIRTUAL - �����';
COMMENT ON COLUMN BARS.OW_CNG_DATA.MOB_AMOUNT IS '';
COMMENT ON COLUMN BARS.OW_CNG_DATA.SEC_AMOUNT IS '';
COMMENT ON COLUMN BARS.OW_CNG_DATA.KF IS '';
COMMENT ON COLUMN BARS.OW_CNG_DATA.ID IS '��. �����';
COMMENT ON COLUMN BARS.OW_CNG_DATA.IDN IS '��. ����� � ����';
COMMENT ON COLUMN BARS.OW_CNG_DATA.CONTRACT_ID IS '����� ��������� (OpenWay)';
COMMENT ON COLUMN BARS.OW_CNG_DATA.CONTRACT_ACC IS '����� ����� � ���';
COMMENT ON COLUMN BARS.OW_CNG_DATA.CONTRACT_CURRENCY IS '��� ������ ���������';
COMMENT ON COLUMN BARS.OW_CNG_DATA.CONTRACT_NAME IS '������������ ���������';
COMMENT ON COLUMN BARS.OW_CNG_DATA.CONTRACT_DATEOPEN IS '���� �������� ���������';
COMMENT ON COLUMN BARS.OW_CNG_DATA.PLASTIC_TITLE IS '������ ��� (����� ��������� � �������)';
COMMENT ON COLUMN BARS.OW_CNG_DATA.PLASTIC_FIRSTNAME IS '������ ��� (���)';
COMMENT ON COLUMN BARS.OW_CNG_DATA.PLASTIC_LASTNAME IS '������ ��� (�������)';
COMMENT ON COLUMN BARS.OW_CNG_DATA.PLASTIC_COMPANYNAME IS '������ ��� (������������ ����� � ��� ����.)';
COMMENT ON COLUMN BARS.OW_CNG_DATA.AVL_AMOUNT IS 'AVAILABLE - �����';
COMMENT ON COLUMN BARS.OW_CNG_DATA.OWN_AMOUNT IS 'OWN_BALANCE - �����';
COMMENT ON COLUMN BARS.OW_CNG_DATA.BLK_AMOUNT IS 'BLOCKED - �����';
COMMENT ON COLUMN BARS.OW_CNG_DATA.CR_AMOUNT IS 'CR_LIMIT - �����';
COMMENT ON COLUMN BARS.OW_CNG_DATA.ACC IS 'ACC';




PROMPT *** Create  constraint FK_OWCNGDATA_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CNG_DATA ADD CONSTRAINT FK_OWCNGDATA_ACCOUNTS FOREIGN KEY (ACC)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OWCNGDATA_OWFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CNG_DATA ADD CONSTRAINT FK_OWCNGDATA_OWFILES FOREIGN KEY (ID)
	  REFERENCES BARS.OW_FILES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OWCNGDATA ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CNG_DATA ADD CONSTRAINT PK_OWCNGDATA PRIMARY KEY (ID, IDN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWCNGDATA_IDN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CNG_DATA MODIFY (IDN CONSTRAINT CC_OWCNGDATA_IDN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWCNGDATA_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CNG_DATA MODIFY (ID CONSTRAINT CC_OWCNGDATA_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWCNGDATA_CNGDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CNG_DATA ADD CONSTRAINT CC_OWCNGDATA_CNGDATE_NN CHECK (cngdate is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OWCNGDATA_ACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OWCNGDATA_ACC ON BARS.OW_CNG_DATA (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWCNGDATA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWCNGDATA ON BARS.OW_CNG_DATA (ID, IDN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_CNG_DATA ***
grant SELECT,UPDATE                                                          on OW_CNG_DATA     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_CNG_DATA     to OW;
grant FLASHBACK,SELECT                                                       on OW_CNG_DATA     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_CNG_DATA.sql =========*** End *** =
PROMPT ===================================================================================== 
