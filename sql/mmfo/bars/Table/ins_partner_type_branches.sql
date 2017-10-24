

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_PARTNER_TYPE_BRANCHES.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_PARTNER_TYPE_BRANCHES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_PARTNER_TYPE_BRANCHES'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''INS_PARTNER_TYPE_BRANCHES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_PARTNER_TYPE_BRANCHES ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_PARTNER_TYPE_BRANCHES 
   (	ID NUMBER, 
	BRANCH VARCHAR2(30), 
	PARTNER_ID NUMBER, 
	TYPE_ID NUMBER, 
	TARIFF_ID VARCHAR2(100), 
	FEE_ID VARCHAR2(100), 
	LIMIT_ID VARCHAR2(100), 
	APPLY_HIER NUMBER DEFAULT 1, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_PARTNER_TYPE_BRANCHES ***
 exec bpa.alter_policies('INS_PARTNER_TYPE_BRANCHES');


COMMENT ON TABLE BARS.INS_PARTNER_TYPE_BRANCHES IS 'Доступність СК та типів СД у відділеннях';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_BRANCHES.KF IS '';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_BRANCHES.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_BRANCHES.BRANCH IS 'Код відділення';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_BRANCHES.PARTNER_ID IS 'Ідентифікатор СК';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_BRANCHES.TYPE_ID IS 'Ідентифікатор типу страхового договору';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_BRANCHES.TARIFF_ID IS 'Ід. тарифу на компанію та тип та відділення';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_BRANCHES.FEE_ID IS 'Ід. комісії на компанію та тип та відділення';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_BRANCHES.LIMIT_ID IS 'Ід. ліміту на тип даної СК у відділенні';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_BRANCHES.APPLY_HIER IS 'Застосовувати до залежних';




PROMPT *** Create  constraint FK_PTNTYPEBRHS__LID_LIMITS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_BRANCHES ADD CONSTRAINT FK_PTNTYPEBRHS__LID_LIMITS FOREIGN KEY (LIMIT_ID, KF)
	  REFERENCES BARS.INS_LIMITS (ID, KF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PTNTYPEBRHS_FID_FEES ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_BRANCHES ADD CONSTRAINT FK_PTNTYPEBRHS_FID_FEES FOREIGN KEY (FEE_ID, KF)
	  REFERENCES BARS.INS_FEES (ID, KF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PTNTYPEBRHS_AH ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_BRANCHES ADD CONSTRAINT CC_PTNTYPEBRHS_AH CHECK (apply_hier in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PTNTYPEBRHS_TID_TYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_BRANCHES ADD CONSTRAINT FK_PTNTYPEBRHS_TID_TYPES FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.INS_TYPES (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PTNTYPEBRHS_B_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_BRANCHES ADD CONSTRAINT FK_PTNTYPEBRHS_B_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PTNTYPEBRANCHES_AH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_BRANCHES MODIFY (APPLY_HIER CONSTRAINT CC_PTNTYPEBRANCHES_AH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PTNTYPEBRANCHES_BRH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_BRANCHES MODIFY (BRANCH CONSTRAINT CC_PTNTYPEBRANCHES_BRH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PTNTYPEBRANCHES ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_BRANCHES ADD CONSTRAINT PK_PTNTYPEBRANCHES PRIMARY KEY (ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PTNTYPEBRHS_TID_TARIFFS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_BRANCHES ADD CONSTRAINT FK_PTNTYPEBRHS_TID_TARIFFS FOREIGN KEY (TARIFF_ID, KF)
	  REFERENCES BARS.INS_TARIFFS (ID, KF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_PTNTYPEBRANCHES ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_BRANCHES ADD CONSTRAINT UK_PTNTYPEBRANCHES UNIQUE (BRANCH, PARTNER_ID, TYPE_ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0033368 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_BRANCHES MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PTNTYPEBRANCHES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PTNTYPEBRANCHES ON BARS.INS_PARTNER_TYPE_BRANCHES (ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_PTNTYPEBRANCHES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_PTNTYPEBRANCHES ON BARS.INS_PARTNER_TYPE_BRANCHES (BRANCH, PARTNER_ID, TYPE_ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_PARTNER_TYPE_BRANCHES.sql ========
PROMPT ===================================================================================== 
