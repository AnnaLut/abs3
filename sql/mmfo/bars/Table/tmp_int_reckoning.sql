

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_INT_RECKONING.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_INT_RECKONING ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_INT_RECKONING ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_INT_RECKONING 
   (	RECKONING_ID NUMBER, 
	ACCOUNT_ID NUMBER, 
	INTEREST_KIND NUMBER, 
	DATE_FROM DATE, 
	DATE_THROUGH DATE, 
	INTEREST_AMOUNT NUMBER, 
	NEW_INTEREST_AMOUNT NUMBER, 
	ACCRUAL_DOCUMENT_ID NUMBER, 
	APPROVED_INTEREST_AMOUNT NUMBER, 
	PURPOSE VARCHAR2(160), 
	NEW_DOCUMENT_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_INT_RECKONING ***
 exec bpa.alter_policies('TMP_INT_RECKONING');


COMMENT ON TABLE BARS.TMP_INT_RECKONING IS '';
COMMENT ON COLUMN BARS.TMP_INT_RECKONING.RECKONING_ID IS '';
COMMENT ON COLUMN BARS.TMP_INT_RECKONING.ACCOUNT_ID IS '';
COMMENT ON COLUMN BARS.TMP_INT_RECKONING.INTEREST_KIND IS '';
COMMENT ON COLUMN BARS.TMP_INT_RECKONING.DATE_FROM IS '';
COMMENT ON COLUMN BARS.TMP_INT_RECKONING.DATE_THROUGH IS '';
COMMENT ON COLUMN BARS.TMP_INT_RECKONING.INTEREST_AMOUNT IS '';
COMMENT ON COLUMN BARS.TMP_INT_RECKONING.NEW_INTEREST_AMOUNT IS '';
COMMENT ON COLUMN BARS.TMP_INT_RECKONING.ACCRUAL_DOCUMENT_ID IS '';
COMMENT ON COLUMN BARS.TMP_INT_RECKONING.APPROVED_INTEREST_AMOUNT IS '';
COMMENT ON COLUMN BARS.TMP_INT_RECKONING.PURPOSE IS '';
COMMENT ON COLUMN BARS.TMP_INT_RECKONING.NEW_DOCUMENT_ID IS '';



PROMPT *** Create  grants  TMP_INT_RECKONING ***
grant SELECT                                                                 on TMP_INT_RECKONING to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_INT_RECKONING.sql =========*** End
PROMPT ===================================================================================== 
