

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ND_REF.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_ND_REF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_ND_REF'', ''FILIAL'' , ''Q'', ''Q'', ''Q'', ''Q'');
               bpa.alter_policy_info(''SKRYNKA_ND_REF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_ND_REF ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_ND_REF 
   (	ND NUMBER, 
	REF NUMBER, 
	BDATE DATE, 
	RENT NUMBER(1,0) DEFAULT 0, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SKRYNKA_ND_REF ***
 exec bpa.alter_policies('SKRYNKA_ND_REF');


COMMENT ON TABLE BARS.SKRYNKA_ND_REF IS '��������� ���������� �� ��������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_REF.BRANCH IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ND_REF.KF IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ND_REF.ND IS '����� ��������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_REF.REF IS 'ref ���������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_REF.BDATE IS '���� ���������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_REF.RENT IS '������� ����� - 0 - ��, 1 - ���, null - ������� ��';




PROMPT *** Create  constraint FK_SKRYNKANDREF_SKRYNKAND ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_REF ADD CONSTRAINT FK_SKRYNKANDREF_SKRYNKAND FOREIGN KEY (KF, ND)
	  REFERENCES BARS.SKRYNKA_ND (KF, ND) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKANDREF_OPER ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_REF ADD CONSTRAINT FK_SKRYNKANDREF_OPER FOREIGN KEY (KF, REF)
	  REFERENCES BARS.OPER (KF, REF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKANDREF_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_REF ADD CONSTRAINT FK_SKRYNKANDREF_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKANDREF_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_REF ADD CONSTRAINT FK_SKRYNKANDREF_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CH_SKRYNKA_ND_REF_RENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_REF ADD CONSTRAINT CH_SKRYNKA_ND_REF_RENT CHECK (rent = 0 OR rent = 1) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SKRYNKANDREF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_REF ADD CONSTRAINT PK_SKRYNKANDREF PRIMARY KEY (ND, REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKANDREF_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_REF MODIFY (KF CONSTRAINT CC_SKRYNKANDREF_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKANDREF_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_REF MODIFY (BRANCH CONSTRAINT CC_SKRYNKANDREF_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SKRYNKANDREF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SKRYNKANDREF ON BARS.SKRYNKA_ND_REF (ND, REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_ND_REF ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SKRYNKA_ND_REF  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SKRYNKA_ND_REF  to DEP_SKRN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SKRYNKA_ND_REF  to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SKRYNKA_ND_REF ***

  CREATE OR REPLACE PUBLIC SYNONYM SKRYNKA_ND_REF FOR BARS.SKRYNKA_ND_REF;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ND_REF.sql =========*** End **
PROMPT ===================================================================================== 
