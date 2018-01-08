

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SOCIAL_AGENCY_NEW.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SOCIAL_AGENCY_NEW ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SOCIAL_AGENCY_NEW ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_SOCIAL_AGENCY_NEW 
   (	AGENCY_ID NUMBER(38,0), 
	NAME VARCHAR2(100), 
	BRANCH VARCHAR2(30), 
	DEBIT_ACC NUMBER(38,0), 
	CREDIT_ACC NUMBER(38,0), 
	CARD_ACC NUMBER(38,0), 
	CONTRACT VARCHAR2(30), 
	DATE_ON DATE, 
	DATE_OFF DATE, 
	ADDRESS VARCHAR2(100), 
	PHONE VARCHAR2(20), 
	DETAILS VARCHAR2(100), 
	TYPE_ID NUMBER(38,0), 
	COMISS_ACC NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SOCIAL_AGENCY_NEW ***
 exec bpa.alter_policies('TMP_SOCIAL_AGENCY_NEW');


COMMENT ON TABLE BARS.TMP_SOCIAL_AGENCY_NEW IS '';
COMMENT ON COLUMN BARS.TMP_SOCIAL_AGENCY_NEW.AGENCY_ID IS '';
COMMENT ON COLUMN BARS.TMP_SOCIAL_AGENCY_NEW.NAME IS '';
COMMENT ON COLUMN BARS.TMP_SOCIAL_AGENCY_NEW.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_SOCIAL_AGENCY_NEW.DEBIT_ACC IS '';
COMMENT ON COLUMN BARS.TMP_SOCIAL_AGENCY_NEW.CREDIT_ACC IS '';
COMMENT ON COLUMN BARS.TMP_SOCIAL_AGENCY_NEW.CARD_ACC IS '';
COMMENT ON COLUMN BARS.TMP_SOCIAL_AGENCY_NEW.CONTRACT IS '';
COMMENT ON COLUMN BARS.TMP_SOCIAL_AGENCY_NEW.DATE_ON IS '';
COMMENT ON COLUMN BARS.TMP_SOCIAL_AGENCY_NEW.DATE_OFF IS '';
COMMENT ON COLUMN BARS.TMP_SOCIAL_AGENCY_NEW.ADDRESS IS '';
COMMENT ON COLUMN BARS.TMP_SOCIAL_AGENCY_NEW.PHONE IS '';
COMMENT ON COLUMN BARS.TMP_SOCIAL_AGENCY_NEW.DETAILS IS '';
COMMENT ON COLUMN BARS.TMP_SOCIAL_AGENCY_NEW.TYPE_ID IS '';
COMMENT ON COLUMN BARS.TMP_SOCIAL_AGENCY_NEW.COMISS_ACC IS '';



PROMPT *** Create  grants  TMP_SOCIAL_AGENCY_NEW ***
grant SELECT                                                                 on TMP_SOCIAL_AGENCY_NEW to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SOCIAL_AGENCY_NEW.sql =========***
PROMPT ===================================================================================== 
