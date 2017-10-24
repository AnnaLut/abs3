

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SOCIAL_CONTRACTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SOCIAL_CONTRACTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SOCIAL_CONTRACTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SOCIAL_CONTRACTS'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''SOCIAL_CONTRACTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SOCIAL_CONTRACTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.SOCIAL_CONTRACTS 
   (	CONTRACT_ID NUMBER(38,0), 
	TYPE_ID NUMBER(38,0), 
	AGENCY_ID NUMBER(38,0), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	RNK NUMBER(38,0), 
	ACC NUMBER(38,0), 
	CONTRACT_NUM VARCHAR2(30), 
	CONTRACT_DATE DATE, 
	CLOSED_DATE DATE, 
	CARD_ACCOUNT VARCHAR2(20), 
	PENSION_NUM VARCHAR2(30), 
	DETAILS VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SOCIAL_CONTRACTS ***
 exec bpa.alter_policies('SOCIAL_CONTRACTS');


COMMENT ON TABLE BARS.SOCIAL_CONTRACTS IS 'Договора клиентов в ОСЗ';
COMMENT ON COLUMN BARS.SOCIAL_CONTRACTS.CONTRACT_ID IS 'Референс договра';
COMMENT ON COLUMN BARS.SOCIAL_CONTRACTS.TYPE_ID IS 'Тип договора';
COMMENT ON COLUMN BARS.SOCIAL_CONTRACTS.AGENCY_ID IS 'Код ОСЗ';
COMMENT ON COLUMN BARS.SOCIAL_CONTRACTS.BRANCH IS 'Підрозділ';
COMMENT ON COLUMN BARS.SOCIAL_CONTRACTS.RNK IS 'Рег. № клиента';
COMMENT ON COLUMN BARS.SOCIAL_CONTRACTS.ACC IS 'Внутр.номер счета';
COMMENT ON COLUMN BARS.SOCIAL_CONTRACTS.CONTRACT_NUM IS '№ договора';
COMMENT ON COLUMN BARS.SOCIAL_CONTRACTS.CONTRACT_DATE IS 'Дата договора';
COMMENT ON COLUMN BARS.SOCIAL_CONTRACTS.CLOSED_DATE IS 'Дата закрытия договора';
COMMENT ON COLUMN BARS.SOCIAL_CONTRACTS.CARD_ACCOUNT IS 'Номер карточного счета';
COMMENT ON COLUMN BARS.SOCIAL_CONTRACTS.PENSION_NUM IS '№ пенсионного дела';
COMMENT ON COLUMN BARS.SOCIAL_CONTRACTS.DETAILS IS 'Комментарии';




PROMPT *** Create  constraint CC_SOCIALCONTR_DATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_CONTRACTS ADD CONSTRAINT CC_SOCIALCONTR_DATES CHECK (contract_date <= nvl(closed_date, contract_date + 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SOCIALCONTR ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_CONTRACTS ADD CONSTRAINT PK_SOCIALCONTR PRIMARY KEY (CONTRACT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SOCIALCONTR_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_CONTRACTS ADD CONSTRAINT FK_SOCIALCONTR_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SOCIALCONTR_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_CONTRACTS ADD CONSTRAINT FK_SOCIALCONTR_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SOCIALCONTR_SOCIALDPTTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_CONTRACTS ADD CONSTRAINT FK_SOCIALCONTR_SOCIALDPTTYPES FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.SOCIAL_DPT_TYPES (TYPE_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SOCIALCONTR_SOCIALAGENCY ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_CONTRACTS ADD CONSTRAINT FK_SOCIALCONTR_SOCIALAGENCY FOREIGN KEY (AGENCY_ID)
	  REFERENCES BARS.SOCIAL_AGENCY (AGENCY_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCIALCONTR_CONTRDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_CONTRACTS MODIFY (CONTRACT_DATE CONSTRAINT CC_SOCIALCONTR_CONTRDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCIALCONTR_AGENCYID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_CONTRACTS MODIFY (AGENCY_ID CONSTRAINT CC_SOCIALCONTR_AGENCYID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCIALCONTR_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_CONTRACTS MODIFY (BRANCH CONSTRAINT CC_SOCIALCONTR_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCIALCONTR_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_CONTRACTS MODIFY (RNK CONSTRAINT CC_SOCIALCONTR_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCIALCONTR_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_CONTRACTS MODIFY (ACC CONSTRAINT CC_SOCIALCONTR_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCIALCONTR_CONTRNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_CONTRACTS MODIFY (CONTRACT_NUM CONSTRAINT CC_SOCIALCONTR_CONTRNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCIALCONTR_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_CONTRACTS MODIFY (TYPE_ID CONSTRAINT CC_SOCIALCONTR_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I5_SOCIALCONTRACTS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I5_SOCIALCONTRACTS ON BARS.SOCIAL_CONTRACTS (CONTRACT_NUM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_SOCIALCONTR ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_SOCIALCONTR ON BARS.SOCIAL_CONTRACTS (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SOCIALCONTR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SOCIALCONTR ON BARS.SOCIAL_CONTRACTS (CONTRACT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_SOCIALCONTR ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_SOCIALCONTR ON BARS.SOCIAL_CONTRACTS (CONTRACT_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I3_SOCIALCONTR ***
begin   
 execute immediate '
  CREATE INDEX BARS.I3_SOCIALCONTR ON BARS.SOCIAL_CONTRACTS (TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I4_SOCIALCONTR ***
begin   
 execute immediate '
  CREATE INDEX BARS.I4_SOCIALCONTR ON BARS.SOCIAL_CONTRACTS (CARD_ACCOUNT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SOCIAL_CONTRACTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SOCIAL_CONTRACTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SOCIAL_CONTRACTS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SOCIAL_CONTRACTS to DPT_ROLE;
grant SELECT                                                                 on SOCIAL_CONTRACTS to KLBX;
grant SELECT                                                                 on SOCIAL_CONTRACTS to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SOCIAL_CONTRACTS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SOCIAL_CONTRACTS.sql =========*** End 
PROMPT ===================================================================================== 
