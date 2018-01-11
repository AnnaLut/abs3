

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SKRYNKA_ALL.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SKRYNKA_ALL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SKRYNKA_ALL ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_SKRYNKA_ALL 
   (	N_SK NUMBER, 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SKRYNKA_ALL ***
 exec bpa.alter_policies('TMP_SKRYNKA_ALL');


COMMENT ON TABLE BARS.TMP_SKRYNKA_ALL IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ALL.N_SK IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ALL.KF IS '';




PROMPT *** Create  constraint SYS_C00135491 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ALL MODIFY (N_SK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135492 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ALL MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_SKRYNKA_ALL ***
grant SELECT                                                                 on TMP_SKRYNKA_ALL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SKRYNKA_ALL.sql =========*** End *
PROMPT ===================================================================================== 
