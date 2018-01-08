

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMER_EXTERN_UPDATE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMER_EXTERN_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMER_EXTERN_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_EXTERN_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CUSTOMER_EXTERN_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMER_EXTERN_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTOMER_EXTERN_UPDATE 
   (	IDUPD NUMBER(15,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	ID NUMBER(22,0), 
	NAME VARCHAR2(70), 
	DOC_TYPE NUMBER(22,0), 
	DOC_SERIAL VARCHAR2(30), 
	DOC_NUMBER VARCHAR2(22), 
	DOC_DATE DATE, 
	DOC_ISSUER VARCHAR2(70), 
	BIRTHDAY DATE, 
	BIRTHPLACE VARCHAR2(70), 
	SEX CHAR(1), 
	ADR VARCHAR2(100), 
	TEL VARCHAR2(100), 
	EMAIL VARCHAR2(100), 
	CUSTTYPE NUMBER(1,0), 
	OKPO VARCHAR2(14), 
	COUNTRY NUMBER(3,0), 
	REGION VARCHAR2(2), 
	FS CHAR(2), 
	VED CHAR(5), 
	SED CHAR(4), 
	ISE CHAR(5), 
	NOTES VARCHAR2(80), 
	KF VARCHAR2(6) DEFAULT NULL
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTOMER_EXTERN_UPDATE ***
 exec bpa.alter_policies('CUSTOMER_EXTERN_UPDATE');


COMMENT ON TABLE BARS.CUSTOMER_EXTERN_UPDATE IS '';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN_UPDATE.IDUPD IS 'ѕервичный ключ дл€ таблицы обновлени€';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN_UPDATE.CHGACTION IS ' од обновлени€ (I/U/D)';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN_UPDATE.EFFECTDATE IS 'Ѕанковска€ дата начала действи€ параметров';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN_UPDATE.CHGDATE IS '—истемана€ дата обновлени€';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN_UPDATE.DONEBY IS ' од пользовател€. кто внес обновлени€(если в течении дн€ было несколько обновлений - остаетс€ только последнее)';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN_UPDATE.ID IS '';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN_UPDATE.NAME IS '';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN_UPDATE.DOC_TYPE IS '';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN_UPDATE.DOC_SERIAL IS '';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN_UPDATE.DOC_NUMBER IS '';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN_UPDATE.DOC_DATE IS '';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN_UPDATE.DOC_ISSUER IS '';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN_UPDATE.BIRTHDAY IS '';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN_UPDATE.BIRTHPLACE IS '';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN_UPDATE.SEX IS '';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN_UPDATE.ADR IS '';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN_UPDATE.TEL IS '';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN_UPDATE.EMAIL IS '';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN_UPDATE.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN_UPDATE.OKPO IS '';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN_UPDATE.COUNTRY IS '';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN_UPDATE.REGION IS '';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN_UPDATE.FS IS '';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN_UPDATE.VED IS '';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN_UPDATE.SED IS '';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN_UPDATE.ISE IS '';
COMMENT ON COLUMN BARS.CUSTOMER_EXTERN_UPDATE.NOTES IS '';




PROMPT *** Create  constraint PK_CUSTOMEREXTUPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_EXTERN_UPDATE ADD CONSTRAINT PK_CUSTOMEREXTUPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMEREXTERNUPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_EXTERN_UPDATE MODIFY (KF CONSTRAINT CC_CUSTOMEREXTERNUPDATE_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004912 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_EXTERN_UPDATE MODIFY (ID NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004913 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_EXTERN_UPDATE MODIFY (SEX NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CUSTOMEREXTUPD ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CUSTOMEREXTUPD ON BARS.CUSTOMER_EXTERN_UPDATE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CUSTOMEREXTUPDEFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CUSTOMEREXTUPDEFFDAT ON BARS.CUSTOMER_EXTERN_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTOMEREXTUPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTOMEREXTUPDATE ON BARS.CUSTOMER_EXTERN_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTOMER_EXTERN_UPDATE ***
grant SELECT                                                                 on CUSTOMER_EXTERN_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on CUSTOMER_EXTERN_UPDATE to BARSUPL;
grant SELECT                                                                 on CUSTOMER_EXTERN_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTOMER_EXTERN_UPDATE to BARS_DM;
grant SELECT                                                                 on CUSTOMER_EXTERN_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMER_EXTERN_UPDATE.sql =========**
PROMPT ===================================================================================== 
