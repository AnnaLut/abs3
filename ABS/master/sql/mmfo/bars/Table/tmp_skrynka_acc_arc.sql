

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SKRYNKA_ACC_ARC.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SKRYNKA_ACC_ARC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SKRYNKA_ACC_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_SKRYNKA_ACC_ARC 
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




PROMPT *** ALTER_POLICIES to TMP_SKRYNKA_ACC_ARC ***
 exec bpa.alter_policies('TMP_SKRYNKA_ACC_ARC');


COMMENT ON TABLE BARS.TMP_SKRYNKA_ACC_ARC IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ACC_ARC.ACC IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ACC_ARC.N_SK IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ACC_ARC.TIP IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ACC_ARC.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ACC_ARC.KF IS '';




PROMPT *** Create  constraint SYS_C00119313 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ACC_ARC MODIFY (TIP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119314 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ACC_ARC MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119315 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ACC_ARC MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_SKRYNKA_ACC_ARC ***
grant SELECT                                                                 on TMP_SKRYNKA_ACC_ARC to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_SKRYNKA_ACC_ARC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SKRYNKA_ACC_ARC.sql =========*** E
PROMPT ===================================================================================== 
