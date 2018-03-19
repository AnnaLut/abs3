PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_BATCH_OPEN_DATA.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_BATCH_OPEN_DATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_BATCH_OPEN_DATA'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OW_BATCH_OPEN_DATA'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_BATCH_OPEN_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_BATCH_OPEN_DATA 
   (	ID NUMBER(22,0), 
	IDN NUMBER(22,0), 
	OKPO VARCHAR2(14), 
	FIRST_NAME VARCHAR2(70), 
	LAST_NAME VARCHAR2(70), 
	MIDDLE_NAME VARCHAR2(70), 
	TYPE_DOC NUMBER(22,0), 
	PASPSERIES VARCHAR2(16), 
	PASPNUM VARCHAR2(16), 
	PASPISSUER VARCHAR2(128), 
	PASPDATE DATE, 
	BDAY DATE, 
	COUNTRY VARCHAR2(3), 
	RESIDENT VARCHAR2(1), 
	GENDER VARCHAR2(1), 
	PHONE_HOME VARCHAR2(13), 
	PHONE_MOB VARCHAR2(13), 
	EMAIL VARCHAR2(30), 
	ENG_FIRST_NAME VARCHAR2(30), 
	ENG_LAST_NAME VARCHAR2(30), 
	MNAME VARCHAR2(20), 
	ADDR1_CITYNAME VARCHAR2(100), 
	ADDR1_PCODE VARCHAR2(10), 
	ADDR1_DOMAIN VARCHAR2(48), 
	ADDR1_REGION VARCHAR2(48), 
	ADDR1_STREET VARCHAR2(100), 
	ADDR1_STREETTYPE NUMBER(10,0), 
	ADDR1_STREETNAME VARCHAR2(100), 
	ADDR1_BUD VARCHAR2(50), 
	REGION_ID1 NUMBER, 
	AREA_ID1 NUMBER, 
	SETTLEMENT_ID1 NUMBER, 
	STREET_ID1 NUMBER, 
	HOUSE_ID1 NUMBER, 
	ADDR2_CITYNAME VARCHAR2(100), 
	ADDR2_PCODE VARCHAR2(10), 
	ADDR2_DOMAIN VARCHAR2(48), 
	ADDR2_REGION VARCHAR2(48), 
	ADDR2_STREET VARCHAR2(100), 
	ADDR2_STREETTYPE NUMBER(10,0), 
	ADDR2_STREETNAME VARCHAR2(100), 
	ADDR2_BUD VARCHAR2(50), 
	REGION_ID2 NUMBER, 
	AREA_ID2 NUMBER, 
	SETTLEMENT_ID2 NUMBER, 
	STREET_ID2 NUMBER, 
	HOUSE_ID2 NUMBER, 
	WORK VARCHAR2(254), 
	OFFICE VARCHAR2(32), 
	DATE_W DATE, 
	OKPO_W VARCHAR2(14), 
	PERS_CAT VARCHAR2(2), 
	AVER_SUM NUMBER(12,0), 
	TABN VARCHAR2(32), 
	STR_ERR VARCHAR2(254), 
	RNK NUMBER(22,0), 
	ND NUMBER(22,0), 
	FLAG_OPEN NUMBER(1,0), 
	ACC_INSTANT NUMBER(22,0), 
	KK_SECRET_WORD VARCHAR2(32), 
	KK_REGTYPE NUMBER(1,0), 
	KK_CITYAREAID NUMBER(10,0), 
	KK_STREETTYPEID NUMBER(10,0), 
	KK_STREETNAME VARCHAR2(64), 
	KK_APARTMENT VARCHAR2(32), 
	KK_POSTCODE VARCHAR2(5), 
	MAX_TERM NUMBER, 
	PASP_END_DATE DATE, 
	PASP_EDDRID_ID VARCHAR2(14), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_BATCH_OPEN_DATA ***
 exec bpa.alter_policies('OW_BATCH_OPEN_DATA');


COMMENT ON TABLE BARS.OW_BATCH_OPEN_DATA IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.ID IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.IDN IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.OKPO IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.FIRST_NAME IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.LAST_NAME IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.MIDDLE_NAME IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.TYPE_DOC IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.PASPSERIES IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.PASPNUM IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.PASPISSUER IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.PASPDATE IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.BDAY IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.COUNTRY IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.RESIDENT IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.GENDER IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.PHONE_HOME IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.PHONE_MOB IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.EMAIL IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.ENG_FIRST_NAME IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.ENG_LAST_NAME IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.MNAME IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.ADDR1_CITYNAME IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.ADDR1_PCODE IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.ADDR1_DOMAIN IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.ADDR1_REGION IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.ADDR1_STREET IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.ADDR1_STREETTYPE IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.ADDR1_STREETNAME IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.ADDR1_BUD IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.REGION_ID1 IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.AREA_ID1 IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.SETTLEMENT_ID1 IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.STREET_ID1 IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.HOUSE_ID1 IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.ADDR2_CITYNAME IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.ADDR2_PCODE IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.ADDR2_DOMAIN IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.ADDR2_REGION IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.ADDR2_STREET IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.ADDR2_STREETTYPE IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.ADDR2_STREETNAME IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.ADDR2_BUD IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.REGION_ID2 IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.AREA_ID2 IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.SETTLEMENT_ID2 IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.STREET_ID2 IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.HOUSE_ID2 IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.WORK IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.OFFICE IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.DATE_W IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.OKPO_W IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.PERS_CAT IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.AVER_SUM IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.TABN IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.STR_ERR IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.RNK IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.ND IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.FLAG_OPEN IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.ACC_INSTANT IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.KK_SECRET_WORD IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.KK_REGTYPE IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.KK_CITYAREAID IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.KK_STREETTYPEID IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.KK_STREETNAME IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.KK_APARTMENT IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.KK_POSTCODE IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.MAX_TERM IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.PASP_END_DATE IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.PASP_EDDRID_ID IS '';
COMMENT ON COLUMN BARS.OW_BATCH_OPEN_DATA.KF IS '';




PROMPT *** Create  constraint PK_OW_BATCH_OPEN_DATA ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_BATCH_OPEN_DATA ADD CONSTRAINT PK_OW_BATCH_OPEN_DATA PRIMARY KEY (ID, IDN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OW_BATCH_OPEN_DATA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OW_BATCH_OPEN_DATA ON BARS.OW_BATCH_OPEN_DATA (ID, IDN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_BATCH_OPEN_DATA.sql =========*** En
PROMPT ===================================================================================== 
