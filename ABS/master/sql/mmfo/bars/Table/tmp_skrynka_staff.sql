

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SKRYNKA_STAFF.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SKRYNKA_STAFF ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SKRYNKA_STAFF ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_SKRYNKA_STAFF 
   (	USERID NUMBER, 
	TIP NUMBER, 
	FIO VARCHAR2(160), 
	FIO_R VARCHAR2(160), 
	DOVER VARCHAR2(240), 
	POSADA VARCHAR2(260), 
	POSADA_R VARCHAR2(260), 
	TOWN VARCHAR2(40), 
	ADRESS VARCHAR2(170), 
	MFO VARCHAR2(12), 
	TELEFON VARCHAR2(30), 
	BRANCH VARCHAR2(30), 
	KF VARCHAR2(6), 
	MODE_TIME VARCHAR2(11), 
	WEEKEND VARCHAR2(254), 
	APPROVED VARCHAR2(254), 
	ID NUMBER, 
	ACTIV NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SKRYNKA_STAFF ***
 exec bpa.alter_policies('TMP_SKRYNKA_STAFF');


COMMENT ON TABLE BARS.TMP_SKRYNKA_STAFF IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_STAFF.USERID IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_STAFF.TIP IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_STAFF.FIO IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_STAFF.FIO_R IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_STAFF.DOVER IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_STAFF.POSADA IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_STAFF.POSADA_R IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_STAFF.TOWN IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_STAFF.ADRESS IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_STAFF.MFO IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_STAFF.TELEFON IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_STAFF.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_STAFF.KF IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_STAFF.MODE_TIME IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_STAFF.WEEKEND IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_STAFF.APPROVED IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_STAFF.ID IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_STAFF.ACTIV IS '';




PROMPT *** Create  constraint SYS_C00132435 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_STAFF MODIFY (USERID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132436 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_STAFF MODIFY (TIP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132437 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_STAFF MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132438 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_STAFF MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_SKRYNKA_STAFF ***
grant SELECT                                                                 on TMP_SKRYNKA_STAFF to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SKRYNKA_STAFF.sql =========*** End
PROMPT ===================================================================================== 
