

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_SPLITTING_AMOUNT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_SPLITTING_AMOUNT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_SPLITTING_AMOUNT'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ZAY_SPLITTING_AMOUNT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ZAY_SPLITTING_AMOUNT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAY_SPLITTING_AMOUNT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAY_SPLITTING_AMOUNT 
   (	ID NUMBER(38,0), 
	KF VARCHAR2(6), 
	REF NUMBER(38,0), 
	SALE_TP NUMBER(1,0), 
	AMNT NUMBER(24,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAY_SPLITTING_AMOUNT ***
 exec bpa.alter_policies('ZAY_SPLITTING_AMOUNT');


COMMENT ON TABLE BARS.ZAY_SPLITTING_AMOUNT IS 'Дані про Розподіл/Розщеплення валютних надходжень';
COMMENT ON COLUMN BARS.ZAY_SPLITTING_AMOUNT.ID IS '';
COMMENT ON COLUMN BARS.ZAY_SPLITTING_AMOUNT.KF IS 'Код філіалу';
COMMENT ON COLUMN BARS.ZAY_SPLITTING_AMOUNT.REF IS 'Ідентифікаторк документу надходження валюти';
COMMENT ON COLUMN BARS.ZAY_SPLITTING_AMOUNT.SALE_TP IS 'Ідентифікатор Ознаки продажу';
COMMENT ON COLUMN BARS.ZAY_SPLITTING_AMOUNT.AMNT IS 'Сума';




PROMPT *** Create  constraint CC_ZAYSPLITTINGAMNT_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_SPLITTING_AMOUNT MODIFY (ID CONSTRAINT CC_ZAYSPLITTINGAMNT_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYSPLITTINGAMNT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_SPLITTING_AMOUNT MODIFY (KF CONSTRAINT CC_ZAYSPLITTINGAMNT_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYSPLITTINGAMNT_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_SPLITTING_AMOUNT MODIFY (REF CONSTRAINT CC_ZAYSPLITTINGAMNT_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYSPLITTINGAMNT_SALETP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_SPLITTING_AMOUNT MODIFY (SALE_TP CONSTRAINT CC_ZAYSPLITTINGAMNT_SALETP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYSPLITTINGAMNT_AMNT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_SPLITTING_AMOUNT MODIFY (AMNT CONSTRAINT CC_ZAYSPLITTINGAMNT_AMNT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYSPLITTINGAMNT_AMNT ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_SPLITTING_AMOUNT ADD CONSTRAINT CC_ZAYSPLITTINGAMNT_AMNT CHECK ( AMNT > 0 ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ZAYSPLITTINGAMNT ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_SPLITTING_AMOUNT ADD CONSTRAINT PK_ZAYSPLITTINGAMNT PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYSPLITTINGAMNT_ZAYSALETPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_SPLITTING_AMOUNT ADD CONSTRAINT FK_ZAYSPLITTINGAMNT_ZAYSALETPS FOREIGN KEY (SALE_TP)
	  REFERENCES BARS.ZAY_SALE_TYPES (TP_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_ZAYSPLITTINGAMNT ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_SPLITTING_AMOUNT ADD CONSTRAINT UK_ZAYSPLITTINGAMNT UNIQUE (REF, SALE_TP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZAYSPLITTINGAMNT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ZAYSPLITTINGAMNT ON BARS.ZAY_SPLITTING_AMOUNT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_ZAYSPLITTINGAMNT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_ZAYSPLITTINGAMNT ON BARS.ZAY_SPLITTING_AMOUNT (REF, SALE_TP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_ZAYSPLITTINGAMNT ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_ZAYSPLITTINGAMNT ON BARS.ZAY_SPLITTING_AMOUNT (KF, REF, SALE_TP) 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 1 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAY_SPLITTING_AMOUNT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAY_SPLITTING_AMOUNT to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAY_SPLITTING_AMOUNT to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAY_SPLITTING_AMOUNT.sql =========*** 
PROMPT ===================================================================================== 
