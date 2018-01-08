

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ND_ACC.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_ND_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_ND_ACC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_ND_ACC'', ''FILIAL'' , ''Q'', ''Q'', ''Q'', ''Q'');
               bpa.alter_policy_info(''SKRYNKA_ND_ACC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_ND_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_ND_ACC 
   (	ACC NUMBER(38,0), 
	TIP VARCHAR2(1), 
	ND NUMBER(38,0), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	RNK NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SKRYNKA_ND_ACC ***
 exec bpa.alter_policies('SKRYNKA_ND_ACC');


COMMENT ON TABLE BARS.SKRYNKA_ND_ACC IS 'Регистрация счетов за договорами по депозитным сейфам';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ACC.RNK IS 'RNK клієнта';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ACC.ACC IS 'acc счета';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ACC.TIP IS 'тим счета';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ACC.ND IS 'номер договора';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ACC.BRANCH IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ACC.KF IS '';




PROMPT *** Create  constraint PK_SKRYNKANDACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_ACC ADD CONSTRAINT PK_SKRYNKANDACC PRIMARY KEY (ACC, TIP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKANDACC_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_ACC MODIFY (BRANCH CONSTRAINT CC_SKRYNKANDACC_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKANDACC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_ACC MODIFY (KF CONSTRAINT CC_SKRYNKANDACC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SKRYNKANDACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SKRYNKANDACC ON BARS.SKRYNKA_ND_ACC (ACC, TIP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_ND_ACC ***
grant SELECT                                                                 on SKRYNKA_ND_ACC  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SKRYNKA_ND_ACC  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SKRYNKA_ND_ACC  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SKRYNKA_ND_ACC  to DEP_SKRN;
grant SELECT                                                                 on SKRYNKA_ND_ACC  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SKRYNKA_ND_ACC  to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SKRYNKA_ND_ACC ***

  CREATE OR REPLACE PUBLIC SYNONYM SKRYNKA_ND_ACC FOR BARS.SKRYNKA_ND_ACC;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ND_ACC.sql =========*** End **
PROMPT ===================================================================================== 
