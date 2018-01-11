

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ATTORNEY.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_ATTORNEY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_ATTORNEY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_ATTORNEY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_ATTORNEY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_ATTORNEY ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_ATTORNEY 
   (	ND NUMBER, 
	RNK NUMBER(38,0), 
	DATE_FROM DATE, 
	DATE_TO DATE, 
	CANCEL_DATE DATE, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SKRYNKA_ATTORNEY ***
 exec bpa.alter_policies('SKRYNKA_ATTORNEY');


COMMENT ON TABLE BARS.SKRYNKA_ATTORNEY IS 'Довіреності депозитних сейфів';
COMMENT ON COLUMN BARS.SKRYNKA_ATTORNEY.ND IS 'Номер договору';
COMMENT ON COLUMN BARS.SKRYNKA_ATTORNEY.RNK IS 'Номер довіреної особи';
COMMENT ON COLUMN BARS.SKRYNKA_ATTORNEY.DATE_FROM IS 'Дата початку';
COMMENT ON COLUMN BARS.SKRYNKA_ATTORNEY.DATE_TO IS 'Дата завершення';
COMMENT ON COLUMN BARS.SKRYNKA_ATTORNEY.CANCEL_DATE IS 'Дата дострокового завершення';
COMMENT ON COLUMN BARS.SKRYNKA_ATTORNEY.BRANCH IS 'Hierarchical Branch Code';
COMMENT ON COLUMN BARS.SKRYNKA_ATTORNEY.KF IS '';




PROMPT *** Create  constraint SYS_C0010114 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ATTORNEY MODIFY (ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010115 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ATTORNEY MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010116 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ATTORNEY MODIFY (DATE_FROM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010117 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ATTORNEY MODIFY (DATE_TO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKAATTORNEY_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ATTORNEY MODIFY (BRANCH CONSTRAINT CC_SKRYNKAATTORNEY_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKAATTORNEY_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ATTORNEY MODIFY (KF CONSTRAINT CC_SKRYNKAATTORNEY_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_ATTORNEY ***
grant SELECT                                                                 on SKRYNKA_ATTORNEY to BARSREADER_ROLE;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on SKRYNKA_ATTORNEY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SKRYNKA_ATTORNEY to BARS_DM;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on SKRYNKA_ATTORNEY to DEP_SKRN;
grant SELECT                                                                 on SKRYNKA_ATTORNEY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ATTORNEY.sql =========*** End 
PROMPT ===================================================================================== 
