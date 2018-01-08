

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_BANK_EMPLOYEE_300465.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_BANK_EMPLOYEE_300465 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_BANK_EMPLOYEE_300465 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_BANK_EMPLOYEE_300465 
   (	OKPO VARCHAR2(14), 
	NMK VARCHAR2(70), 
	BDAY DATE, 
	SER VARCHAR2(10), 
	NUMDOC VARCHAR2(10), 
	START_DAT DATE, 
	IDWORK NUMBER(10,0), 
	TABNOM VARCHAR2(10), 
	STR_ID NUMBER(10,0), 
	END_DAT DATE, 
	PENSIONER NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_BANK_EMPLOYEE_300465 ***
 exec bpa.alter_policies('TMP_BANK_EMPLOYEE_300465');


COMMENT ON TABLE BARS.TMP_BANK_EMPLOYEE_300465 IS '';
COMMENT ON COLUMN BARS.TMP_BANK_EMPLOYEE_300465.OKPO IS '';
COMMENT ON COLUMN BARS.TMP_BANK_EMPLOYEE_300465.NMK IS '';
COMMENT ON COLUMN BARS.TMP_BANK_EMPLOYEE_300465.BDAY IS '';
COMMENT ON COLUMN BARS.TMP_BANK_EMPLOYEE_300465.SER IS '';
COMMENT ON COLUMN BARS.TMP_BANK_EMPLOYEE_300465.NUMDOC IS '';
COMMENT ON COLUMN BARS.TMP_BANK_EMPLOYEE_300465.START_DAT IS '';
COMMENT ON COLUMN BARS.TMP_BANK_EMPLOYEE_300465.IDWORK IS '';
COMMENT ON COLUMN BARS.TMP_BANK_EMPLOYEE_300465.TABNOM IS '';
COMMENT ON COLUMN BARS.TMP_BANK_EMPLOYEE_300465.STR_ID IS '';
COMMENT ON COLUMN BARS.TMP_BANK_EMPLOYEE_300465.END_DAT IS '';
COMMENT ON COLUMN BARS.TMP_BANK_EMPLOYEE_300465.PENSIONER IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_BANK_EMPLOYEE_300465.sql =========
PROMPT ===================================================================================== 
