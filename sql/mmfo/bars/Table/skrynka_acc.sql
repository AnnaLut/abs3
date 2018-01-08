

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ACC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_ACC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_ACC'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''SKRYNKA_ACC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_ACC 
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




PROMPT *** ALTER_POLICIES to SKRYNKA_ACC ***
 exec bpa.alter_policies('SKRYNKA_ACC');


COMMENT ON TABLE BARS.SKRYNKA_ACC IS 'индивидуальные счета обслуживающие сейф';
COMMENT ON COLUMN BARS.SKRYNKA_ACC.ACC IS 'acc - индивидуального лицевого счета сейфа';
COMMENT ON COLUMN BARS.SKRYNKA_ACC.N_SK IS 'номер сейфа (код)';
COMMENT ON COLUMN BARS.SKRYNKA_ACC.TIP IS 'тип индивидуального счета';
COMMENT ON COLUMN BARS.SKRYNKA_ACC.BRANCH IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ACC.KF IS '';




PROMPT *** Create  constraint PK_SKRYNKAACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ACC ADD CONSTRAINT PK_SKRYNKAACC PRIMARY KEY (ACC, N_SK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XUK_SKRYNKA_ACC_N_SK_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ACC ADD CONSTRAINT XUK_SKRYNKA_ACC_N_SK_TIP UNIQUE (N_SK, TIP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XUK_SKRYNKA_ACC_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ACC ADD CONSTRAINT XUK_SKRYNKA_ACC_ACC UNIQUE (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKAACC_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ACC MODIFY (ACC CONSTRAINT CC_SKRYNKAACC_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKAACC_NSK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ACC MODIFY (N_SK CONSTRAINT CC_SKRYNKAACC_NSK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_SKRYNKA_ACC_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ACC MODIFY (TIP CONSTRAINT NN_SKRYNKA_ACC_TIP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKAACC_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ACC MODIFY (BRANCH CONSTRAINT CC_SKRYNKAACC_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKAACC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ACC MODIFY (KF CONSTRAINT CC_SKRYNKAACC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SKRYNKAACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SKRYNKAACC ON BARS.SKRYNKA_ACC (ACC, N_SK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XUK_SKRYNKA_ACC_N_SK_TIP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XUK_SKRYNKA_ACC_N_SK_TIP ON BARS.SKRYNKA_ACC (N_SK, TIP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XUK_SKRYNKA_ACC_ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XUK_SKRYNKA_ACC_ACC ON BARS.SKRYNKA_ACC (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_ACC ***
grant SELECT                                                                 on SKRYNKA_ACC     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SKRYNKA_ACC     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SKRYNKA_ACC     to BARS_DM;
grant SELECT                                                                 on SKRYNKA_ACC     to CC_DOC;
grant DELETE,INSERT,SELECT,UPDATE                                            on SKRYNKA_ACC     to DEP_SKRN;
grant SELECT                                                                 on SKRYNKA_ACC     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SKRYNKA_ACC     to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SKRYNKA_ACC ***

  CREATE OR REPLACE PUBLIC SYNONYM SKRYNKA_ACC FOR BARS.SKRYNKA_ACC;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ACC.sql =========*** End *** =
PROMPT ===================================================================================== 
