

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_NOTARY.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_NOTARY ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_NOTARY ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_NOTARY 
   (	ID NUMBER(10,0), 
	TIN VARCHAR2(10 CHAR), 
	FIRST_NAME VARCHAR2(100 CHAR), 
	MIDDLE_NAME VARCHAR2(100 CHAR), 
	LAST_NAME VARCHAR2(100 CHAR), 
	DATE_OF_BIRTH DATE, 
	PASSPORT_SERIES VARCHAR2(2 CHAR), 
	PASSPORT_NUMBER VARCHAR2(6 CHAR), 
	ADDRESS VARCHAR2(4000), 
	PASSPORT_ISSUER VARCHAR2(70), 
	PASSPORT_ISSUED DATE, 
	PHONE_NUMBER VARCHAR2(100 CHAR), 
	MOBILE_PHONE_NUMBER VARCHAR2(100 CHAR), 
	EMAIL VARCHAR2(100 CHAR), 
	NOTARY_TYPE NUMBER(5,0), 
	CERTIFICATE_NUMBER VARCHAR2(30 CHAR), 
	CERTIFICATE_ISSUE_DATE DATE, 
	CERTIFICATE_CANCELATION_DATE DATE, 
	STATE_ID NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_NOTARY ***
 exec bpa.alter_policies('TMP_NOTARY');


COMMENT ON TABLE BARS.TMP_NOTARY IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY.ID IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY.TIN IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY.FIRST_NAME IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY.MIDDLE_NAME IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY.LAST_NAME IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY.DATE_OF_BIRTH IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY.PASSPORT_SERIES IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY.PASSPORT_NUMBER IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY.ADDRESS IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY.PASSPORT_ISSUER IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY.PASSPORT_ISSUED IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY.PHONE_NUMBER IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY.MOBILE_PHONE_NUMBER IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY.EMAIL IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY.NOTARY_TYPE IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY.CERTIFICATE_NUMBER IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY.CERTIFICATE_ISSUE_DATE IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY.CERTIFICATE_CANCELATION_DATE IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY.STATE_ID IS '';




PROMPT *** Create  constraint SYS_C00119239 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NOTARY MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_NOTARY ***
grant SELECT                                                                 on TMP_NOTARY      to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_NOTARY      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_NOTARY.sql =========*** End *** ==
PROMPT ===================================================================================== 
