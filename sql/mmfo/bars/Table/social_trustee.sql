

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SOCIAL_TRUSTEE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SOCIAL_TRUSTEE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SOCIAL_TRUSTEE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SOCIAL_TRUSTEE'', ''FILIAL'' , ''F'', ''F'', ''F'', ''F'');
               bpa.alter_policy_info(''SOCIAL_TRUSTEE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SOCIAL_TRUSTEE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SOCIAL_TRUSTEE 
   (	TRUST_ID NUMBER(38,0), 
	TRUST_TYPE CHAR(1), 
	TRUST_RNK NUMBER(38,0), 
	CONTRACT_ID NUMBER(38,0), 
	RNK NUMBER(38,0), 
	ADD_NUM VARCHAR2(30), 
	ADD_DAT DATE, 
	FL_ACT NUMBER(1,0), 
	UNDO_ID NUMBER(38,0), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	TEMPLATE_ID VARCHAR2(35), 
	DPTRUSTID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SOCIAL_TRUSTEE ***
 exec bpa.alter_policies('SOCIAL_TRUSTEE');


COMMENT ON TABLE BARS.SOCIAL_TRUSTEE IS 'Справочник доверенных лиц для клиентов-пенсионеров и безработных';
COMMENT ON COLUMN BARS.SOCIAL_TRUSTEE.TRUST_ID IS 'Код доверенного лица';
COMMENT ON COLUMN BARS.SOCIAL_TRUSTEE.TRUST_TYPE IS 'Тип доверенного лица';
COMMENT ON COLUMN BARS.SOCIAL_TRUSTEE.TRUST_RNK IS 'Рег.№ доверенного лица';
COMMENT ON COLUMN BARS.SOCIAL_TRUSTEE.CONTRACT_ID IS 'Референс контракта';
COMMENT ON COLUMN BARS.SOCIAL_TRUSTEE.RNK IS 'Рег.номер клиента';
COMMENT ON COLUMN BARS.SOCIAL_TRUSTEE.ADD_NUM IS 'Номер доп.соглашения';
COMMENT ON COLUMN BARS.SOCIAL_TRUSTEE.ADD_DAT IS 'Дата доп.соглашения';
COMMENT ON COLUMN BARS.SOCIAL_TRUSTEE.FL_ACT IS 'Признак активности доп.соглашения';
COMMENT ON COLUMN BARS.SOCIAL_TRUSTEE.UNDO_ID IS 'Код первичного доп.согл, кот аннулирует данное доп. согл';
COMMENT ON COLUMN BARS.SOCIAL_TRUSTEE.BRANCH IS 'Код подразделения';
COMMENT ON COLUMN BARS.SOCIAL_TRUSTEE.TEMPLATE_ID IS 'Название шаблона для печати';
COMMENT ON COLUMN BARS.SOCIAL_TRUSTEE.DPTRUSTID IS '';




PROMPT *** Create  constraint CC_SOCTRUSTEE_FLACT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_TRUSTEE ADD CONSTRAINT CC_SOCTRUSTEE_FLACT CHECK (fl_act IN (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SOCTRUSTEE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_TRUSTEE ADD CONSTRAINT PK_SOCTRUSTEE PRIMARY KEY (TRUST_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCTRUSTEE_TRUSTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_TRUSTEE MODIFY (TRUST_ID CONSTRAINT CC_SOCTRUSTEE_TRUSTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCTRUSTEE_TRUSTTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_TRUSTEE MODIFY (TRUST_TYPE CONSTRAINT CC_SOCTRUSTEE_TRUSTTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCTRUSTEE_TRUSTRNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_TRUSTEE MODIFY (TRUST_RNK CONSTRAINT CC_SOCTRUSTEE_TRUSTRNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCTRUSTEE_CONTRACTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_TRUSTEE MODIFY (CONTRACT_ID CONSTRAINT CC_SOCTRUSTEE_CONTRACTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCTRUSTEE_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_TRUSTEE MODIFY (RNK CONSTRAINT CC_SOCTRUSTEE_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCTRUSTEE_ADDNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_TRUSTEE MODIFY (ADD_NUM CONSTRAINT CC_SOCTRUSTEE_ADDNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCTRUSTEE_ADDDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_TRUSTEE MODIFY (ADD_DAT CONSTRAINT CC_SOCTRUSTEE_ADDDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCTRUSTEE_FLACT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_TRUSTEE MODIFY (FL_ACT CONSTRAINT CC_SOCTRUSTEE_FLACT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCTRUSTEE_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_TRUSTEE MODIFY (BRANCH CONSTRAINT CC_SOCTRUSTEE_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SOCTRUSTEE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SOCTRUSTEE ON BARS.SOCIAL_TRUSTEE (TRUST_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_SOCTRUSTEE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_SOCTRUSTEE ON BARS.SOCIAL_TRUSTEE (CONTRACT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SOCIAL_TRUSTEE ***
grant SELECT                                                                 on SOCIAL_TRUSTEE  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SOCIAL_TRUSTEE  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SOCIAL_TRUSTEE  to DPT_ROLE;
grant SELECT                                                                 on SOCIAL_TRUSTEE  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SOCIAL_TRUSTEE  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SOCIAL_TRUSTEE.sql =========*** End **
PROMPT ===================================================================================== 
