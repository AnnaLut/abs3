

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ARC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_ARC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_ARC'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''SKRYNKA_ARC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_ARC 
   (	O_SK NUMBER, 
	N_SK NUMBER, 
	SNUM VARCHAR2(64 CHAR), 
	KEYUSED NUMBER, 
	ISP_MO NUMBER, 
	KEYNUMBER VARCHAR2(30), 
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




PROMPT *** ALTER_POLICIES to SKRYNKA_ARC ***
 exec bpa.alter_policies('SKRYNKA_ARC');


COMMENT ON TABLE BARS.SKRYNKA_ARC IS 'портфель закрытых депозитных сейфов';
COMMENT ON COLUMN BARS.SKRYNKA_ARC.O_SK IS 'вид сейфа';
COMMENT ON COLUMN BARS.SKRYNKA_ARC.N_SK IS 'номер сейфа (системный референс)';
COMMENT ON COLUMN BARS.SKRYNKA_ARC.SNUM IS 'номер сейфа (символьный для документов)';
COMMENT ON COLUMN BARS.SKRYNKA_ARC.KEYUSED IS 'флаг - признак ключ выдан = 1, не выдан = 0';
COMMENT ON COLUMN BARS.SKRYNKA_ARC.ISP_MO IS 'материально ответственное за сейф лицо';
COMMENT ON COLUMN BARS.SKRYNKA_ARC.KEYNUMBER IS 'номер ключа';
COMMENT ON COLUMN BARS.SKRYNKA_ARC.BRANCH IS 'код отделения';
COMMENT ON COLUMN BARS.SKRYNKA_ARC.KF IS '';




PROMPT *** Create  constraint PK_SKRYNKA_ARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ARC ADD CONSTRAINT PK_SKRYNKA_ARC PRIMARY KEY (N_SK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKAARC_BRANCH_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ARC ADD CONSTRAINT CC_SKRYNKAARC_BRANCH_CC CHECK (branch like ''/''||kf||''/%'') ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_SKRYNKAARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ARC ADD CONSTRAINT UK_SKRYNKAARC UNIQUE (KF, N_SK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_SKRYNKA_ARC_SNUM ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ARC MODIFY (SNUM CONSTRAINT NN_SKRYNKA_ARC_SNUM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKAARC_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ARC MODIFY (BRANCH CONSTRAINT CC_SKRYNKAARC_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKAARC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ARC MODIFY (KF CONSTRAINT CC_SKRYNKAARC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_SKRYNKAARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_SKRYNKAARC ON BARS.SKRYNKA_ARC (KF, N_SK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SKRYNKA_ARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SKRYNKA_ARC ON BARS.SKRYNKA_ARC (N_SK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_ARC ***
grant SELECT                                                                 on SKRYNKA_ARC     to BARSREADER_ROLE;
grant SELECT                                                                 on SKRYNKA_ARC     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SKRYNKA_ARC     to BARS_DM;
grant SELECT                                                                 on SKRYNKA_ARC     to DEP_SKRN;
grant SELECT                                                                 on SKRYNKA_ARC     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SKRYNKA_ARC     to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SKRYNKA_ARC ***

  CREATE OR REPLACE PUBLIC SYNONYM SKRYNKA_ARC FOR BARS.SKRYNKA_ARC;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ARC.sql =========*** End *** =
PROMPT ===================================================================================== 
