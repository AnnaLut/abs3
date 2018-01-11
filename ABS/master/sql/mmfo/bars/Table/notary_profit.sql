

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NOTARY_PROFIT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NOTARY_PROFIT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NOTARY_PROFIT'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NOTARY_PROFIT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NOTARY_PROFIT'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NOTARY_PROFIT ***
begin 
  execute immediate '
  CREATE TABLE BARS.NOTARY_PROFIT 
   (	ID NUMBER(*,0), 
	NOTARY_ID NUMBER(10,0), 
	ACCR_ID NUMBER(10,0), 
	BRANCH VARCHAR2(30), 
	NBSOB22 VARCHAR2(6), 
	REF_OPER NUMBER, 
	DAT_OPER DATE, 
	PROFIT NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NOTARY_PROFIT ***
 exec bpa.alter_policies('NOTARY_PROFIT');


COMMENT ON TABLE BARS.NOTARY_PROFIT IS 'Доходи по оперціях нотаріусів з кредитами';
COMMENT ON COLUMN BARS.NOTARY_PROFIT.ID IS 'Унікальний ідентифікатор';
COMMENT ON COLUMN BARS.NOTARY_PROFIT.NOTARY_ID IS 'Ідентифікатор нотаріуса';
COMMENT ON COLUMN BARS.NOTARY_PROFIT.ACCR_ID IS 'Акредитація нотаріуса';
COMMENT ON COLUMN BARS.NOTARY_PROFIT.BRANCH IS 'Бранч';
COMMENT ON COLUMN BARS.NOTARY_PROFIT.NBSOB22 IS 'Балансовий рахунок та ОБ22';
COMMENT ON COLUMN BARS.NOTARY_PROFIT.REF_OPER IS 'Референс операції';
COMMENT ON COLUMN BARS.NOTARY_PROFIT.DAT_OPER IS 'Дата операції';
COMMENT ON COLUMN BARS.NOTARY_PROFIT.PROFIT IS 'Сума доходу';




PROMPT *** Create  constraint PK_NOTARY_PROFIT ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_PROFIT ADD CONSTRAINT PK_NOTARY_PROFIT PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NOTARY_PROFIT_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_PROFIT MODIFY (ID CONSTRAINT CC_NOTARY_PROFIT_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NOTARY_PROFIT_NOTARY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_PROFIT MODIFY (NOTARY_ID CONSTRAINT CC_NOTARY_PROFIT_NOTARY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NOTARY_PROFIT_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_PROFIT MODIFY (BRANCH CONSTRAINT CC_NOTARY_PROFIT_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NOTARY_PROFIT_NBSOB22_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_PROFIT MODIFY (NBSOB22 CONSTRAINT CC_NOTARY_PROFIT_NBSOB22_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NOTARY_PROFIT_REFOPER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_PROFIT MODIFY (REF_OPER CONSTRAINT CC_NOTARY_PROFIT_REFOPER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NOTARY_PROFIT_DATOPER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_PROFIT MODIFY (DAT_OPER CONSTRAINT CC_NOTARY_PROFIT_DATOPER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NOTARY_PROFIT_PROFIT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_PROFIT MODIFY (PROFIT CONSTRAINT CC_NOTARY_PROFIT_PROFIT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NOTARY_PROFIT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NOTARY_PROFIT ON BARS.NOTARY_PROFIT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_NOTARY_PROFIT_BRANCH_REF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.IDX_NOTARY_PROFIT_BRANCH_REF ON BARS.NOTARY_PROFIT (SUBSTR(BRANCH,2,6), REF_OPER) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NOTARY_PROFIT ***
grant SELECT                                                                 on NOTARY_PROFIT   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on NOTARY_PROFIT   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NOTARY_PROFIT   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NOTARY_PROFIT.sql =========*** End ***
PROMPT ===================================================================================== 
