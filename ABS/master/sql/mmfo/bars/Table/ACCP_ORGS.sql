

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCP_ORGS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCP_ORGS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCP_ORGS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ACCP_ORGS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCP_ORGS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCP_ORGS 
   (	NAME VARCHAR2(70), 
	NDOG VARCHAR2(20), 
	DDOG DATE, 
	OKPO VARCHAR2(10), 
	SCOPE_DOG NUMBER(2,0), 
	FEE_TYPE_ID NUMBER(1,0), 
	FEE_BY_TARIF NUMBER, 
	ORDER_FEE NUMBER(2,0), 
	AMOUNT_FEE NUMBER(5,2), 
	FEE_MFO VARCHAR2(6), 
	FEE_NLS VARCHAR2(15), 
	FEE_OKPO VARCHAR2(10), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCP_ORGS ***
 exec bpa.alter_policies('ACCP_ORGS');


COMMENT ON TABLE BARS.ACCP_ORGS IS 'довідник організацій для автоматичного формування Актів виконаних робіт на відшкодування комісійної винагороди';
COMMENT ON COLUMN BARS.ACCP_ORGS.NAME IS 'Назва організації';
COMMENT ON COLUMN BARS.ACCP_ORGS.NDOG IS '№ договору';
COMMENT ON COLUMN BARS.ACCP_ORGS.DDOG IS 'Дата договору ';
COMMENT ON COLUMN BARS.ACCP_ORGS.OKPO IS 'Код ЄДРПОУ організації';
COMMENT ON COLUMN BARS.ACCP_ORGS.SCOPE_DOG IS 'Область дії договору';
COMMENT ON COLUMN BARS.ACCP_ORGS.FEE_TYPE_ID IS 'Тип тарифу для коміс. винагороди (1-фіксований,2-ступінчатий(по тарифу))';
COMMENT ON COLUMN BARS.ACCP_ORGS.FEE_BY_TARIF IS 'Код тарифу';
COMMENT ON COLUMN BARS.ACCP_ORGS.ORDER_FEE IS 'Порядок зняття комісійної винагороди';
COMMENT ON COLUMN BARS.ACCP_ORGS.AMOUNT_FEE IS 'Фіксований розмір комісійної винагороди';
COMMENT ON COLUMN BARS.ACCP_ORGS.FEE_MFO IS 'Код банку (для перерахунку комісійної винагороди) ';
COMMENT ON COLUMN BARS.ACCP_ORGS.FEE_NLS IS 'Розрахунковий рахунок  банку (для перерахунку комісійної винагороди)';
COMMENT ON COLUMN BARS.ACCP_ORGS.FEE_OKPO IS 'Код ЄДРПОУ банку (для перерахунку комісійної винагороди)';
COMMENT ON COLUMN BARS.ACCP_ORGS.KF IS '';




PROMPT *** Create  constraint CC_ACCPORGS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_ORGS MODIFY (NAME CONSTRAINT CC_ACCPORGS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCPORGS_NDOG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_ORGS MODIFY (NDOG CONSTRAINT CC_ACCPORGS_NDOG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCPORGS_DDOG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_ORGS MODIFY (DDOG CONSTRAINT CC_ACCPORGS_DDOG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCPORGS_OKPO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_ORGS MODIFY (OKPO CONSTRAINT CC_ACCPORGS_OKPO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCPORGS_SCOPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_ORGS MODIFY (SCOPE_DOG CONSTRAINT CC_ACCPORGS_SCOPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCPORGS_ORDERFEE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_ORGS MODIFY (ORDER_FEE CONSTRAINT CC_ACCPORGS_ORDERFEE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCPORGS_AMFEE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_ORGS MODIFY (AMOUNT_FEE CONSTRAINT CC_ACCPORGS_AMFEE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCPORGS_FEEMFO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_ORGS MODIFY (FEE_MFO CONSTRAINT CC_ACCPORGS_FEEMFO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCPORGS_FEENLS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_ORGS MODIFY (FEE_NLS CONSTRAINT CC_ACCPORGS_FEENLS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCPORGS_FEEOKPO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_ORGS MODIFY (FEE_OKPO CONSTRAINT CC_ACCPORGS_FEEOKPO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACCPORGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_ORGS ADD CONSTRAINT PK_ACCPORGS PRIMARY KEY (OKPO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCPORGS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_ORGS MODIFY (KF CONSTRAINT CC_ACCPORGS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCPORGS_FEETYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_ORGS MODIFY (FEE_TYPE_ID CONSTRAINT CC_ACCPORGS_FEETYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCPORGS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCPORGS ON BARS.ACCP_ORGS (OKPO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCP_ORGS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCP_ORGS       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCP_ORGS       to UPLD;
grant FLASHBACK,SELECT                                                       on ACCP_ORGS       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCP_ORGS.sql =========*** End *** ===
PROMPT ===================================================================================== 
