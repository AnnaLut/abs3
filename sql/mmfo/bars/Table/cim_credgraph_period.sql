

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CREDGRAPH_PERIOD.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CREDGRAPH_PERIOD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CREDGRAPH_PERIOD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CREDGRAPH_PERIOD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CREDGRAPH_PERIOD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CREDGRAPH_PERIOD ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CREDGRAPH_PERIOD 
   (	CONTR_ID NUMBER, 
	END_DATE DATE, 
	CR_METHOD NUMBER DEFAULT 2, 
	PAYMENT_PERIOD NUMBER, 
	PAYMENT_DELAY NUMBER DEFAULT 0, 
	Z NUMBER DEFAULT 0, 
	ADAPTIVE NUMBER, 
	PERCENT NUMBER, 
	PERCENT_NBU NUMBER, 
	PERCENT_BASE NUMBER, 
	PERCENT_PERIOD NUMBER, 
	PERCENT_DELAY NUMBER DEFAULT 0, 
	GET_DAY NUMBER, 
	PAY_DAY NUMBER, 
	PAYMENT_DAY NUMBER DEFAULT 1, 
	PERCENT_DAY NUMBER DEFAULT 1
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CREDGRAPH_PERIOD ***
 exec bpa.alter_policies('CIM_CREDGRAPH_PERIOD');


COMMENT ON TABLE BARS.CIM_CREDGRAPH_PERIOD IS 'Періоди графіка погашення';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_PERIOD.CONTR_ID IS 'ID контракту';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_PERIOD.END_DATE IS 'Дата закінчення періоду';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_PERIOD.CR_METHOD IS 'Медтод погашення тіла';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_PERIOD.PAYMENT_PERIOD IS 'Періодичність погашення тіла';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_PERIOD.PAYMENT_DELAY IS '';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_PERIOD.Z IS 'Залишок тіла на кінець періоду';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_PERIOD.ADAPTIVE IS '';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_PERIOD.PERCENT IS 'Процентна ставка';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_PERIOD.PERCENT_NBU IS '';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_PERIOD.PERCENT_BASE IS 'База нарахування відсотків';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_PERIOD.PERCENT_PERIOD IS 'Періодичність погашення відсотків';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_PERIOD.PERCENT_DELAY IS '';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_PERIOD.GET_DAY IS 'Врахування дня видачі кредиту при нарахуванні відсотків';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_PERIOD.PAY_DAY IS 'Врахування дня погашення кредиту при нарахуванні відсотків';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_PERIOD.PAYMENT_DAY IS 'Дата погашення тіла';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_PERIOD.PERCENT_DAY IS 'Дата погашення відсотків';




PROMPT *** Create  constraint CC_CIMCGPERIOD_PAYDELAY_CHECK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDGRAPH_PERIOD ADD CONSTRAINT CC_CIMCGPERIOD_PAYDELAY_CHECK CHECK (payment_delay>=0) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCGPERIOD_PERCDELAY_CHECK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDGRAPH_PERIOD ADD CONSTRAINT CC_CIMCGPERIOD_PERCDELAY_CHECK CHECK (percent_delay>=0) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCGPERIOD_CONTRID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDGRAPH_PERIOD MODIFY (CONTR_ID CONSTRAINT CC_CIMCGPERIOD_CONTRID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCGPERIOD_ENDDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDGRAPH_PERIOD MODIFY (END_DATE CONSTRAINT CC_CIMCGPERIOD_ENDDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCGPERIOD_CRMETHOD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDGRAPH_PERIOD MODIFY (CR_METHOD CONSTRAINT CC_CIMCGPERIOD_CRMETHOD_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCGPERIOD_PAYPERIOD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDGRAPH_PERIOD MODIFY (PAYMENT_PERIOD CONSTRAINT CC_CIMCGPERIOD_PAYPERIOD_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCGPERIOD_Z_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDGRAPH_PERIOD MODIFY (Z CONSTRAINT CC_CIMCGPERIOD_Z_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCGPERIOD_ADAPTIVE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDGRAPH_PERIOD MODIFY (ADAPTIVE CONSTRAINT CC_CIMCGPERIOD_ADAPTIVE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCGPERIOD_PERCENT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDGRAPH_PERIOD MODIFY (PERCENT CONSTRAINT CC_CIMCGPERIOD_PERCENT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCGPERIOD_PERCENTNBU_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDGRAPH_PERIOD MODIFY (PERCENT_NBU CONSTRAINT CC_CIMCGPERIOD_PERCENTNBU_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCGPERIOD_PERCENTBASE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDGRAPH_PERIOD MODIFY (PERCENT_BASE CONSTRAINT CC_CIMCGPERIOD_PERCENTBASE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCGPERIOD_PERCPERIOD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDGRAPH_PERIOD MODIFY (PERCENT_PERIOD CONSTRAINT CC_CIMCGPERIOD_PERCPERIOD_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCGPERIOD_GETDAY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDGRAPH_PERIOD MODIFY (GET_DAY CONSTRAINT CC_CIMCGPERIOD_GETDAY_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCGPERIOD_PAYDAY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDGRAPH_PERIOD MODIFY (PAY_DAY CONSTRAINT CC_CIMCGPERIOD_PAYDAY_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCGPERIOD_PAYMENTDAY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDGRAPH_PERIOD MODIFY (PAYMENT_DAY CONSTRAINT CC_CIMCGPERIOD_PAYMENTDAY_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCGPERIOD_PERCENTDAY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDGRAPH_PERIOD MODIFY (PERCENT_DAY CONSTRAINT CC_CIMCGPERIOD_PERCENTDAY_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_CREDGRAPH_PERIOD ***
grant SELECT                                                                 on CIM_CREDGRAPH_PERIOD to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDGRAPH_PERIOD to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CREDGRAPH_PERIOD to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDGRAPH_PERIOD to CIM_ROLE;
grant SELECT                                                                 on CIM_CREDGRAPH_PERIOD to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CREDGRAPH_PERIOD.sql =========*** 
PROMPT ===================================================================================== 
