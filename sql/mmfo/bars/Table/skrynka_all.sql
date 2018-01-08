

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ALL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_ALL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_ALL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_ALL'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SKRYNKA_ALL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_ALL ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_ALL 
   (	N_SK NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	 CONSTRAINT PK_SKRYNKAALL PRIMARY KEY (N_SK) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSMDLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SKRYNKA_ALL ***
 exec bpa.alter_policies('SKRYNKA_ALL');


COMMENT ON TABLE BARS.SKRYNKA_ALL IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ALL.N_SK IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ALL.KF IS '';




PROMPT *** Create  constraint CC_SKRYNKAALL_NSK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ALL MODIFY (N_SK CONSTRAINT CC_SKRYNKAALL_NSK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKAALL_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ALL MODIFY (KF CONSTRAINT CC_SKRYNKAALL_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SKRYNKAALL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ALL ADD CONSTRAINT PK_SKRYNKAALL PRIMARY KEY (N_SK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_SKRYNKAALL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ALL ADD CONSTRAINT UK_SKRYNKAALL UNIQUE (KF, N_SK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SKRYNKAALL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SKRYNKAALL ON BARS.SKRYNKA_ALL (N_SK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_SKRYNKAALL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_SKRYNKAALL ON BARS.SKRYNKA_ALL (KF, N_SK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_ALL ***
grant SELECT                                                                 on SKRYNKA_ALL     to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SKRYNKA_ALL     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ALL.sql =========*** End *** =
PROMPT ===================================================================================== 
