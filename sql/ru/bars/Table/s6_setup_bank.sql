

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_SETUP_BANK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_SETUP_BANK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''S6_SETUP_BANK'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_SETUP_BANK ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_SETUP_BANK 
   (	C_MFO NUMBER(10,0), 
	C_NB VARCHAR2(60), 
	C_ADRESS VARCHAR2(60), 
	C_POSIT_1 VARCHAR2(40), 
	C_FIO_1 VARCHAR2(40), 
	C_POSIT_2 VARCHAR2(40), 
	C_FIO_2 VARCHAR2(40), 
	C_NIV NUMBER(5,0), 
	C_NIV_ED CHAR(3), 
	C_NIV_SOT CHAR(3), 
	C_KSH VARCHAR2(25), 
	C_IDEN CHAR(4), 
	C_KC NUMBER(5,0), 
	C_KO NUMBER(5,0), 
	C_NLGI CHAR(1), 
	C_PROB NUMBER(5,0), 
	C_SIGN NUMBER(3,0), 
	C_START DATE, 
	C_END DATE, 
	C_PR_END NUMBER(3,0), 
	C_PATH_ABS VARCHAR2(255), 
	C_ID VARCHAR2(14), 
	VerDB NUMBER(5,0), 
	MaxTimeLPMB NUMBER(5,0), 
	TermStDoc NUMBER(5,0), 
	C_IDEN2 CHAR(4), 
	C_MB DATE, 
	C_UserDB NUMBER(5,0), 
	C_DEPART NUMBER(5,0), 
	MaskAdjust NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_SETUP_BANK ***
 exec bpa.alter_policies('S6_SETUP_BANK');


COMMENT ON TABLE BARS.S6_SETUP_BANK IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.C_MFO IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.C_NB IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.C_ADRESS IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.C_POSIT_1 IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.C_FIO_1 IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.C_POSIT_2 IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.C_FIO_2 IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.C_NIV IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.C_NIV_ED IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.C_NIV_SOT IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.C_KSH IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.C_IDEN IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.C_KC IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.C_KO IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.C_NLGI IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.C_PROB IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.C_SIGN IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.C_START IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.C_END IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.C_PR_END IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.C_PATH_ABS IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.C_ID IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.VerDB IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.MaxTimeLPMB IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.TermStDoc IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.C_IDEN2 IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.C_MB IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.C_UserDB IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.C_DEPART IS '';
COMMENT ON COLUMN BARS.S6_SETUP_BANK.MaskAdjust IS '';




PROMPT *** Create  constraint SYS_C0097508 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SETUP_BANK MODIFY (C_MB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097507 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SETUP_BANK MODIFY (VerDB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097506 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SETUP_BANK MODIFY (C_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097505 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SETUP_BANK MODIFY (C_PR_END NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097504 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SETUP_BANK MODIFY (C_END NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097503 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SETUP_BANK MODIFY (C_START NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097502 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SETUP_BANK MODIFY (C_SIGN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097501 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SETUP_BANK MODIFY (C_PROB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097500 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SETUP_BANK MODIFY (C_NLGI NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097499 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SETUP_BANK MODIFY (C_KO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097498 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SETUP_BANK MODIFY (C_KC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097497 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SETUP_BANK MODIFY (C_IDEN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097496 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SETUP_BANK MODIFY (C_KSH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097495 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SETUP_BANK MODIFY (C_NIV_SOT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097494 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SETUP_BANK MODIFY (C_NIV_ED NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097493 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SETUP_BANK MODIFY (C_NIV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097492 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SETUP_BANK MODIFY (C_MFO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_SETUP_BANK.sql =========*** End ***
PROMPT ===================================================================================== 
