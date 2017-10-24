

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_VISIT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_VISIT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_VISIT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_VISIT'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''SKRYNKA_VISIT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_VISIT ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_VISIT 
   (	ND NUMBER, 
	DATIN DATE, 
	DATOUT DATE, 
	DATSYS DATE, 
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




PROMPT *** ALTER_POLICIES to SKRYNKA_VISIT ***
 exec bpa.alter_policies('SKRYNKA_VISIT');


COMMENT ON TABLE BARS.SKRYNKA_VISIT IS 'журнал посещений клиентом депозитария';
COMMENT ON COLUMN BARS.SKRYNKA_VISIT.ND IS 'номер договра';
COMMENT ON COLUMN BARS.SKRYNKA_VISIT.DATIN IS 'дата посещения (начало)';
COMMENT ON COLUMN BARS.SKRYNKA_VISIT.DATOUT IS 'дата посещения (конец)';
COMMENT ON COLUMN BARS.SKRYNKA_VISIT.DATSYS IS 'системная дата';
COMMENT ON COLUMN BARS.SKRYNKA_VISIT.BRANCH IS '';
COMMENT ON COLUMN BARS.SKRYNKA_VISIT.KF IS '';




PROMPT *** Create  constraint PK_SKRYNKAVISIT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_VISIT ADD CONSTRAINT PK_SKRYNKAVISIT PRIMARY KEY (ND, DATIN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKAVISIT_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_VISIT ADD CONSTRAINT FK_SKRYNKAVISIT_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKAVISIT_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_VISIT ADD CONSTRAINT FK_SKRYNKAVISIT_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKAVISIT_SKRYNKAND ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_VISIT ADD CONSTRAINT FK_SKRYNKAVISIT_SKRYNKAND FOREIGN KEY (KF, ND)
	  REFERENCES BARS.SKRYNKA_ND (KF, ND) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKAVISIT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_VISIT MODIFY (KF CONSTRAINT CC_SKRYNKAVISIT_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_SKRYNKA_VISIT_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_VISIT MODIFY (ND CONSTRAINT NN_SKRYNKA_VISIT_ND NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_SKRYNKA_VISIT_DATOUT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_VISIT MODIFY (DATOUT CONSTRAINT NN_SKRYNKA_VISIT_DATOUT NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKAVISIT_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_VISIT MODIFY (BRANCH CONSTRAINT CC_SKRYNKAVISIT_BRANCH_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_SKRYNKA_VISIT_DATIN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_VISIT MODIFY (DATIN CONSTRAINT NN_SKRYNKA_VISIT_DATIN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SKRYNKAVISIT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SKRYNKAVISIT ON BARS.SKRYNKA_VISIT (ND, DATIN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_VISIT ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SKRYNKA_VISIT   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SKRYNKA_VISIT   to BARS_DM;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SKRYNKA_VISIT   to DEP_SKRN;
grant SELECT                                                                 on SKRYNKA_VISIT   to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SKRYNKA_VISIT   to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SKRYNKA_VISIT   to WR_REFREAD;



PROMPT *** Create SYNONYM  to SKRYNKA_VISIT ***

  CREATE OR REPLACE PUBLIC SYNONYM SKRYNKA_VISIT FOR BARS.SKRYNKA_VISIT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_VISIT.sql =========*** End ***
PROMPT ===================================================================================== 
