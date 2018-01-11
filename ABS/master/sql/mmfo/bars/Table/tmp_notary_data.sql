

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_NOTARY_DATA.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_NOTARY_DATA ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_NOTARY_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_NOTARY_DATA 
   (	ID NUMBER(10,0), 
	REGION_NAME VARCHAR2(300 CHAR), 
	NOTARY_NAME VARCHAR2(300 CHAR), 
	NOTARY_DATE_OF_BIRTH DATE, 
	NOTARY_PASSPORT_NUMBER VARCHAR2(9 CHAR), 
	NOTARY_PASSPORT_ISSUED DATE, 
	NOTARY_PASSPORT_ISSUER VARCHAR2(300 CHAR), 
	NOTARY_TIN VARCHAR2(10 CHAR), 
	ACCREDITATION_STATE_NAME VARCHAR2(30 CHAR), 
	ACCREDITATION_RESOLUTION_DATE DATE, 
	NOTARY_CITY VARCHAR2(150 CHAR), 
	NOTARY_ADDRESS VARCHAR2(500 CHAR), 
	NOTARY_PHONE VARCHAR2(100 CHAR), 
	NOTARY_EMAIL VARCHAR2(100 CHAR), 
	ACCR_SEGMENTS_OF_BUSINESS VARCHAR2(30 CHAR), 
	ACCREDITATION_MFO VARCHAR2(30 CHAR), 
	ACCREDITATION_ACCOUNT VARCHAR2(30 CHAR), 
	NOTARY_CERTIFICATE_NUMBER VARCHAR2(30 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_NOTARY_DATA ***
 exec bpa.alter_policies('TMP_NOTARY_DATA');


COMMENT ON TABLE BARS.TMP_NOTARY_DATA IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY_DATA.ID IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY_DATA.REGION_NAME IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY_DATA.NOTARY_NAME IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY_DATA.NOTARY_DATE_OF_BIRTH IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY_DATA.NOTARY_PASSPORT_NUMBER IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY_DATA.NOTARY_PASSPORT_ISSUED IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY_DATA.NOTARY_PASSPORT_ISSUER IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY_DATA.NOTARY_TIN IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY_DATA.ACCREDITATION_STATE_NAME IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY_DATA.ACCREDITATION_RESOLUTION_DATE IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY_DATA.NOTARY_CITY IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY_DATA.NOTARY_ADDRESS IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY_DATA.NOTARY_PHONE IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY_DATA.NOTARY_EMAIL IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY_DATA.ACCR_SEGMENTS_OF_BUSINESS IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY_DATA.ACCREDITATION_MFO IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY_DATA.ACCREDITATION_ACCOUNT IS '';
COMMENT ON COLUMN BARS.TMP_NOTARY_DATA.NOTARY_CERTIFICATE_NUMBER IS '';



PROMPT *** Create  grants  TMP_NOTARY_DATA ***
grant SELECT                                                                 on TMP_NOTARY_DATA to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_NOTARY_DATA to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_NOTARY_DATA.sql =========*** End *
PROMPT ===================================================================================== 
