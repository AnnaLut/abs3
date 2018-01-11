

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ACC_ARC.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_ACC_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_ACC_ARC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_ACC_ARC'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''SKRYNKA_ACC_ARC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_ACC_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_ACC_ARC 
   (	ACC NUMBER, 
	N_SK NUMBER, 
	TIP VARCHAR2(1), 
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




PROMPT *** ALTER_POLICIES to SKRYNKA_ACC_ARC ***
 exec bpa.alter_policies('SKRYNKA_ACC_ARC');


COMMENT ON TABLE BARS.SKRYNKA_ACC_ARC IS 'индивидуальные счета обслуживающие сейф';
COMMENT ON COLUMN BARS.SKRYNKA_ACC_ARC.ACC IS 'acc - индивидуального лицевого счета сейфа';
COMMENT ON COLUMN BARS.SKRYNKA_ACC_ARC.N_SK IS 'номер сейфа (код)';
COMMENT ON COLUMN BARS.SKRYNKA_ACC_ARC.TIP IS 'тип индивидуального счета';
COMMENT ON COLUMN BARS.SKRYNKA_ACC_ARC.BRANCH IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ACC_ARC.KF IS '';




PROMPT *** Create  constraint PK_SKRYNKA_ACC_ARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ACC_ARC ADD CONSTRAINT PK_SKRYNKA_ACC_ARC PRIMARY KEY (N_SK, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XUK_SKRYNKA_ACC_ARC_N_SK_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ACC_ARC ADD CONSTRAINT XUK_SKRYNKA_ACC_ARC_N_SK_TIP UNIQUE (N_SK, TIP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XUK_SKRYNKA_ACC_ARC_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ACC_ARC ADD CONSTRAINT XUK_SKRYNKA_ACC_ARC_ACC UNIQUE (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_SKRYNKA_ACC_ARC_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ACC_ARC MODIFY (TIP CONSTRAINT NN_SKRYNKA_ACC_ARC_TIP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKAACCARC_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ACC_ARC MODIFY (BRANCH CONSTRAINT CC_SKRYNKAACCARC_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKAACCARC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ACC_ARC MODIFY (KF CONSTRAINT CC_SKRYNKAACCARC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XUK_SKRYNKA_ACC_ARC_N_SK_TIP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XUK_SKRYNKA_ACC_ARC_N_SK_TIP ON BARS.SKRYNKA_ACC_ARC (N_SK, TIP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XUK_SKRYNKA_ACC_ARC_ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XUK_SKRYNKA_ACC_ARC_ACC ON BARS.SKRYNKA_ACC_ARC (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SKRYNKA_ACC_ARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SKRYNKA_ACC_ARC ON BARS.SKRYNKA_ACC_ARC (N_SK, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_ACC_ARC ***
grant SELECT                                                                 on SKRYNKA_ACC_ARC to BARSREADER_ROLE;
grant SELECT                                                                 on SKRYNKA_ACC_ARC to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SKRYNKA_ACC_ARC to BARS_DM;
grant SELECT                                                                 on SKRYNKA_ACC_ARC to CC_DOC;
grant SELECT                                                                 on SKRYNKA_ACC_ARC to DEP_SKRN;
grant SELECT                                                                 on SKRYNKA_ACC_ARC to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SKRYNKA_ACC_ARC to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SKRYNKA_ACC_ARC ***

  CREATE OR REPLACE PUBLIC SYNONYM SKRYNKA_ACC_ARC FOR BARS.SKRYNKA_ACC_ARC;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ACC_ARC.sql =========*** End *
PROMPT ===================================================================================== 
