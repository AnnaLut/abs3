

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_CRVFILES_DATA.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_CRVFILES_DATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_CRVFILES_DATA'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_CRVFILES_DATA'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OW_CRVFILES_DATA'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_CRVFILES_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_CRVFILES_DATA 
   (	ID NUMBER(22,0), 
	IDN NUMBER(22,0), 
	B040 VARCHAR2(20), 
	BRANCH VARCHAR2(30), 
	FIRST_NAME VARCHAR2(70), 
	LAST_NAME VARCHAR2(70), 
	MDL_NAME VARCHAR2(70), 
	OKPO VARCHAR2(14), 
	ADR_PCODE VARCHAR2(20), 
	ADR_DOMAIN VARCHAR2(30), 
	ADR_REGION VARCHAR2(30), 
	ADR_CITY VARCHAR2(30), 
	ADR_STREET VARCHAR2(100), 
	PHONE1 VARCHAR2(20), 
	PHONE2 VARCHAR2(20), 
	PHONE3 VARCHAR2(20), 
	PASSP_SER VARCHAR2(10), 
	PASSP_NUM VARCHAR2(20), 
	PASSP_ORG VARCHAR2(50), 
	PASSP_DATE DATE, 
	BDAY DATE, 
	BPLACE VARCHAR2(70), 
	SEX NUMBER(1,0), 
	WORD VARCHAR2(20), 
	CRV_RNK NUMBER(10,0), 
	CRV_DBCODE VARCHAR2(14), 
	STR_ERR VARCHAR2(254), 
	RNK NUMBER(22,0), 
	ND NUMBER(22,0), 
	CARD_ISSUE_BRANCH VARCHAR2(30), 
	CARD_ISSUE_BRANCH_ADR VARCHAR2(100), 
	CARD_ISSUE_DATE DATE, 
	ERR_CODE NUMBER(1,0), 
	CARD_ISSUE_BRANCH_ABS VARCHAR2(30), 
	PASSP_DOCTYPE NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_CRVFILES_DATA ***
 exec bpa.alter_policies('OW_CRVFILES_DATA');


COMMENT ON TABLE BARS.OW_CRVFILES_DATA IS '���. ����� �� �������� ����';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.KF IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.ID IS 'Id';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.IDN IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.B040 IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.BRANCH IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.FIRST_NAME IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.LAST_NAME IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.MDL_NAME IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.OKPO IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.ADR_PCODE IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.ADR_DOMAIN IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.ADR_REGION IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.ADR_CITY IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.ADR_STREET IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.PHONE1 IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.PHONE2 IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.PHONE3 IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.PASSP_SER IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.PASSP_NUM IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.PASSP_ORG IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.PASSP_DATE IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.BDAY IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.BPLACE IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.SEX IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.WORD IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.CRV_RNK IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.CRV_DBCODE IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.STR_ERR IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.RNK IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.ND IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.CARD_ISSUE_BRANCH IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.CARD_ISSUE_BRANCH_ADR IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.CARD_ISSUE_DATE IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.ERR_CODE IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.CARD_ISSUE_BRANCH_ABS IS '';
COMMENT ON COLUMN BARS.OW_CRVFILES_DATA.PASSP_DOCTYPE IS '';




PROMPT *** Create  constraint PK_OWCRVFILESDATA ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CRVFILES_DATA ADD CONSTRAINT PK_OWCRVFILESDATA PRIMARY KEY (ID, IDN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWCRVFILESDATA_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CRVFILES_DATA MODIFY (KF CONSTRAINT CC_OWCRVFILESDATA_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWCRVFILESDATA_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CRVFILES_DATA MODIFY (ID CONSTRAINT CC_OWCRVFILESDATA_ID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWCRVFILESDATA_IDN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CRVFILES_DATA MODIFY (IDN CONSTRAINT CC_OWCRVFILESDATA_IDN_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWCRVFILESDATA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWCRVFILESDATA ON BARS.OW_CRVFILES_DATA (ID, IDN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_CRVFILES_DATA ***
grant SELECT                                                                 on OW_CRVFILES_DATA to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_CRVFILES_DATA to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_CRVFILES_DATA to OW;
grant SELECT                                                                 on OW_CRVFILES_DATA to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_CRVFILES_DATA.sql =========*** End 
PROMPT ===================================================================================== 
