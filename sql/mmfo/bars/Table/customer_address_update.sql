

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMER_ADDRESS_UPDATE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMER_ADDRESS_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMER_ADDRESS_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_ADDRESS_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CUSTOMER_ADDRESS_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMER_ADDRESS_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTOMER_ADDRESS_UPDATE 
   (	IDUPD NUMBER(38,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER(38,0), 
	RNK NUMBER(38,0), 
	TYPE_ID NUMBER(38,0), 
	COUNTRY NUMBER(3,0), 
	ZIP VARCHAR2(20), 
	DOMAIN VARCHAR2(30), 
	REGION VARCHAR2(30), 
	LOCALITY VARCHAR2(30), 
	ADDRESS VARCHAR2(100), 
	TERRITORY_ID NUMBER(22,0), 
	LOCALITY_TYPE NUMBER(22,0), 
	STREET_TYPE NUMBER(22,0), 
	STREET VARCHAR2(100 CHAR), 
	HOME_TYPE NUMBER(22,0), 
	HOME VARCHAR2(100 CHAR), 
	HOMEPART_TYPE NUMBER(22,0), 
	HOMEPART VARCHAR2(100 CHAR), 
	ROOM_TYPE NUMBER(22,0), 
	ROOM VARCHAR2(100 CHAR), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTOMER_ADDRESS_UPDATE ***
 exec bpa.alter_policies('CUSTOMER_ADDRESS_UPDATE');


COMMENT ON TABLE BARS.CUSTOMER_ADDRESS_UPDATE IS '������ ��� ����� �볺���';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS_UPDATE.IDUPD IS '������������� ����';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS_UPDATE.CHGACTION IS '��� ���� ����';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS_UPDATE.EFFECTDATE IS '��������� ���� ���� ���������';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS_UPDATE.CHGDATE IS '���������� ���� ���� ���������';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS_UPDATE.DONEBY IS '������������� �����������, �� ������� ����';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS_UPDATE.RNK IS '';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS_UPDATE.TYPE_ID IS '';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS_UPDATE.COUNTRY IS '';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS_UPDATE.ZIP IS '';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS_UPDATE.DOMAIN IS '';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS_UPDATE.REGION IS '';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS_UPDATE.LOCALITY IS '';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS_UPDATE.ADDRESS IS '';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS_UPDATE.TERRITORY_ID IS '';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS_UPDATE.LOCALITY_TYPE IS '';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS_UPDATE.STREET_TYPE IS '';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS_UPDATE.STREET IS '';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS_UPDATE.HOME_TYPE IS '';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS_UPDATE.HOME IS '';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS_UPDATE.HOMEPART_TYPE IS '';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS_UPDATE.HOMEPART IS '';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS_UPDATE.ROOM_TYPE IS '';
COMMENT ON COLUMN BARS.CUSTOMER_ADDRESS_UPDATE.ROOM IS '';




PROMPT *** Create  constraint PK_CUSTADDRUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS_UPDATE ADD CONSTRAINT PK_CUSTADDRUPD PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERADDRESSUPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS_UPDATE MODIFY (KF CONSTRAINT CC_CUSTOMERADDRESSUPDATE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTADDRUPD_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS_UPDATE MODIFY (IDUPD CONSTRAINT CC_CUSTADDRUPD_IDUPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTADDRUPD_CHGACTION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS_UPDATE MODIFY (CHGACTION CONSTRAINT CC_CUSTADDRUPD_CHGACTION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTADDRUPD_EFFECTDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS_UPDATE MODIFY (EFFECTDATE CONSTRAINT CC_CUSTADDRUPD_EFFECTDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTADDRUPD_CHGDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS_UPDATE MODIFY (CHGDATE CONSTRAINT CC_CUSTADDRUPD_CHGDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTADDRUPD_DONEBY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS_UPDATE MODIFY (DONEBY CONSTRAINT CC_CUSTADDRUPD_DONEBY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTADDRUPD_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS_UPDATE MODIFY (RNK CONSTRAINT CC_CUSTADDRUPD_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTADDRUPD_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS_UPDATE MODIFY (TYPE_ID CONSTRAINT CC_CUSTADDRUPD_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTADDRUPD_COUNTRY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_ADDRESS_UPDATE MODIFY (COUNTRY CONSTRAINT CC_CUSTADDRUPD_COUNTRY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_CUSTADDRUPD_RNK_TYPEID ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CUSTADDRUPD_RNK_TYPEID ON BARS.CUSTOMER_ADDRESS_UPDATE (RNK, TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_CUSTADDRUPD_EFFECTDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CUSTADDRUPD_EFFECTDATE ON BARS.CUSTOMER_ADDRESS_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTADDRUPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTADDRUPD ON BARS.CUSTOMER_ADDRESS_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTOMER_ADDRESS_UPDATE ***
grant SELECT                                                                 on CUSTOMER_ADDRESS_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on CUSTOMER_ADDRESS_UPDATE to BARSUPL;
grant SELECT                                                                 on CUSTOMER_ADDRESS_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTOMER_ADDRESS_UPDATE to BARS_DM;
grant SELECT                                                                 on CUSTOMER_ADDRESS_UPDATE to START1;
grant SELECT                                                                 on CUSTOMER_ADDRESS_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMER_ADDRESS_UPDATE.sql =========*
PROMPT ===================================================================================== 
