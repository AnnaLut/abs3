

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_FINMON_PERSON_BANK.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_FINMON_PERSON_BANK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_FINMON_PERSON_BANK ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_FINMON_PERSON_BANK 
   (	ID VARCHAR2(15), 
	BANK_IDCODE VARCHAR2(25), 
	BANK_NAME VARCHAR2(254), 
	BANK_CNTRY VARCHAR2(3), 
	BANK_ADRES VARCHAR2(254), 
	BRANCH_ID VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_FINMON_PERSON_BANK ***
 exec bpa.alter_policies('TMP_FINMON_PERSON_BANK');


COMMENT ON TABLE BARS.TMP_FINMON_PERSON_BANK IS '';
COMMENT ON COLUMN BARS.TMP_FINMON_PERSON_BANK.ID IS '';
COMMENT ON COLUMN BARS.TMP_FINMON_PERSON_BANK.BANK_IDCODE IS '';
COMMENT ON COLUMN BARS.TMP_FINMON_PERSON_BANK.BANK_NAME IS '';
COMMENT ON COLUMN BARS.TMP_FINMON_PERSON_BANK.BANK_CNTRY IS '';
COMMENT ON COLUMN BARS.TMP_FINMON_PERSON_BANK.BANK_ADRES IS '';
COMMENT ON COLUMN BARS.TMP_FINMON_PERSON_BANK.BRANCH_ID IS '';




PROMPT *** Create  constraint SYS_C00132689 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_FINMON_PERSON_BANK MODIFY (BANK_IDCODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132690 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_FINMON_PERSON_BANK MODIFY (BRANCH_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_FINMON_PERSON_BANK ***
grant SELECT                                                                 on TMP_FINMON_PERSON_BANK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_FINMON_PERSON_BANK.sql =========**
PROMPT ===================================================================================== 
