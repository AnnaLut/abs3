

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CONTRACTS_TRADE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CONTRACTS_TRADE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CONTRACTS_TRADE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CONTRACTS_TRADE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CONTRACTS_TRADE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CONTRACTS_TRADE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CONTRACTS_TRADE 
   (	CONTR_ID NUMBER, 
	SPEC_ID NUMBER, 
	SUBJECT_ID NUMBER, 
	DEADLINE NUMBER, 
	TRADE_DESC VARCHAR2(250), 
	WITHOUT_ACTS NUMBER DEFAULT 0, 
	P27_F531 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CONTRACTS_TRADE ***
 exec bpa.alter_policies('CIM_CONTRACTS_TRADE');


COMMENT ON TABLE BARS.CIM_CONTRACTS_TRADE IS 'Додаткові дані по торгових контрактах v1.0';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_TRADE.CONTR_ID IS 'ID контракту';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_TRADE.SPEC_ID IS 'ID спеціалізації контракту';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_TRADE.SUBJECT_ID IS 'Предмет контракту';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_TRADE.DEADLINE IS 'Контрольний строк';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_TRADE.TRADE_DESC IS 'Уточнення предмету контракту';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_TRADE.WITHOUT_ACTS IS 'Робота без актів цінової експертизи';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_TRADE.P27_F531 IS 'Показник 27 звіту 531 (#36)';




PROMPT *** Create  constraint CC_CIMCONTRTRADE_SPEC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_TRADE MODIFY (SPEC_ID CONSTRAINT CC_CIMCONTRTRADE_SPEC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONTRTRADE_SUBJ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_TRADE MODIFY (SUBJECT_ID CONSTRAINT CC_CIMCONTRTRADE_SUBJ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONTRTRADE_DEADLINE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_TRADE MODIFY (DEADLINE CONSTRAINT CC_CIMCONTRTRADE_DEADLINE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONTRTRADE_ID_UK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_TRADE ADD CONSTRAINT CC_CIMCONTRTRADE_ID_UK UNIQUE (CONTR_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index CC_CIMCONTRTRADE_ID_UK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.CC_CIMCONTRTRADE_ID_UK ON BARS.CIM_CONTRACTS_TRADE (CONTR_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


begin
    execute immediate 'alter table bars.CIM_CONTRACTS_TRADE add (IS_FRAGMENT NUMBER(1) default 0)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN BARS.CIM_CONTRACTS_TRADE.IS_FRAGMENT IS 'Ознака дроблення:  1 - Так';

begin
    execute immediate 'alter table bars.CIM_CONTRACTS_TRADE add (FRAGMENT_CHG_DATE DATE)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN BARS.CIM_CONTRACTS_TRADE.FRAGMENT_CHG_DATE IS 'Дата зміни Ознаки дроблення';

begin
    execute immediate 'alter table bars.CIM_CONTRACTS_TRADE add (FRAGMENT_CHG_USERID NUMBER)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN BARS.CIM_CONTRACTS_TRADE.FRAGMENT_CHG_USERID IS 'Користувач зміни Ознаки дроблення';




PROMPT *** Create  grants  CIM_CONTRACTS_TRADE ***
grant SELECT                                                                 on CIM_CONTRACTS_TRADE to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONTRACTS_TRADE to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONTRACTS_TRADE to CIM_ROLE;
grant SELECT                                                                 on CIM_CONTRACTS_TRADE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CONTRACTS_TRADE.sql =========*** E
PROMPT ===================================================================================== 
