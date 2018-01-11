

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SKRYNKA_ARC.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SKRYNKA_ARC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SKRYNKA_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_SKRYNKA_ARC 
   (	O_SK NUMBER, 
	N_SK NUMBER, 
	SNUM VARCHAR2(64 CHAR), 
	KEYUSED NUMBER, 
	ISP_MO NUMBER, 
	KEYNUMBER VARCHAR2(30), 
	BRANCH VARCHAR2(30), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SKRYNKA_ARC ***
 exec bpa.alter_policies('TMP_SKRYNKA_ARC');


COMMENT ON TABLE BARS.TMP_SKRYNKA_ARC IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ARC.O_SK IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ARC.N_SK IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ARC.SNUM IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ARC.KEYUSED IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ARC.ISP_MO IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ARC.KEYNUMBER IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ARC.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ARC.KF IS '';




PROMPT *** Create  constraint SYS_C00135493 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ARC MODIFY (SNUM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135494 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ARC MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135495 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ARC MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_SKRYNKA_ARC ***
grant SELECT                                                                 on TMP_SKRYNKA_ARC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SKRYNKA_ARC.sql =========*** End *
PROMPT ===================================================================================== 
