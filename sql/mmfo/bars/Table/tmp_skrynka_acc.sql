

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SKRYNKA_ACC.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SKRYNKA_ACC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SKRYNKA_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_SKRYNKA_ACC 
   (	ACC NUMBER, 
	N_SK NUMBER, 
	TIP VARCHAR2(1), 
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




PROMPT *** ALTER_POLICIES to TMP_SKRYNKA_ACC ***
 exec bpa.alter_policies('TMP_SKRYNKA_ACC');


COMMENT ON TABLE BARS.TMP_SKRYNKA_ACC IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ACC.ACC IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ACC.N_SK IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ACC.TIP IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ACC.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ACC.KF IS '';




PROMPT *** Create  constraint SYS_C00135483 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ACC MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135484 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ACC MODIFY (N_SK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135485 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ACC MODIFY (TIP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135486 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ACC MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135487 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ACC MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_SKRYNKA_ACC ***
grant SELECT                                                                 on TMP_SKRYNKA_ACC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SKRYNKA_ACC.sql =========*** End *
PROMPT ===================================================================================== 
