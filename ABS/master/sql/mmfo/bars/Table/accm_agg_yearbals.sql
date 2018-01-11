

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCM_AGG_YEARBALS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCM_AGG_YEARBALS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCM_AGG_YEARBALS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACCM_AGG_YEARBALS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACCM_AGG_YEARBALS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCM_AGG_YEARBALS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCM_AGG_YEARBALS 
   (	CALDT_ID NUMBER(38,0), 
	ACC NUMBER(38,0), 
	RNK NUMBER(38,0), 
	OST NUMBER(24,0), 
	OSTQ NUMBER(24,0), 
	WSDOS NUMBER(24,0), 
	WSKOS NUMBER(24,0), 
	WCDOS NUMBER(24,0), 
	WCKOS NUMBER(24,0)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSACCM 
  PARTITION BY RANGE (CALDT_ID) INTERVAL (1) 
 (PARTITION P0  VALUES LESS THAN (1) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSACCM ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCM_AGG_YEARBALS ***
 exec bpa.alter_policies('ACCM_AGG_YEARBALS');


COMMENT ON TABLE BARS.ACCM_AGG_YEARBALS IS 'Подсистема накопления. Накопительные балансы за год с проводками перекрытия';
COMMENT ON COLUMN BARS.ACCM_AGG_YEARBALS.CALDT_ID IS 'Ид. даты баланса';
COMMENT ON COLUMN BARS.ACCM_AGG_YEARBALS.ACC IS 'Ид. счета';
COMMENT ON COLUMN BARS.ACCM_AGG_YEARBALS.RNK IS 'Ид. клиента';
COMMENT ON COLUMN BARS.ACCM_AGG_YEARBALS.OST IS 'Исходящий остаток на счете (номинал)';
COMMENT ON COLUMN BARS.ACCM_AGG_YEARBALS.OSTQ IS 'Исходящий остаток на счете (эквивалент)';
COMMENT ON COLUMN BARS.ACCM_AGG_YEARBALS.WSDOS IS 'Сумма дебетовых оборотов перекрытия (номинал)';
COMMENT ON COLUMN BARS.ACCM_AGG_YEARBALS.WSKOS IS 'Сумма кредитовых оборотов перекрытия (номинал)';
COMMENT ON COLUMN BARS.ACCM_AGG_YEARBALS.WCDOS IS 'Сумма корректирующих дебетовых оборотов перекрытия (номинал)';
COMMENT ON COLUMN BARS.ACCM_AGG_YEARBALS.WCKOS IS 'Сумма корректирующих кредитовых оборотов перекрытия (номинал)';




PROMPT *** Create  constraint PK_ACCMAGGYBALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_YEARBALS ADD CONSTRAINT PK_ACCMAGGYBALS PRIMARY KEY (CALDT_ID, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSACCM  LOCAL
 (PARTITION P0 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSACCM )  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMAGGYBALS_CALDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_YEARBALS MODIFY (CALDT_ID CONSTRAINT CC_ACCMAGGYBALS_CALDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMAGGYBALS_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_YEARBALS MODIFY (ACC CONSTRAINT CC_ACCMAGGYBALS_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMAGGYBALS_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_YEARBALS MODIFY (RNK CONSTRAINT CC_ACCMAGGYBALS_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMAGGYBALS_OST_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_YEARBALS MODIFY (OST CONSTRAINT CC_ACCMAGGYBALS_OST_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMAGGYBALS_OSTQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_YEARBALS MODIFY (OSTQ CONSTRAINT CC_ACCMAGGYBALS_OSTQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMAGGYBALS_WSDOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_YEARBALS MODIFY (WSDOS CONSTRAINT CC_ACCMAGGYBALS_WSDOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMAGGYBALS_WSKOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_YEARBALS MODIFY (WSKOS CONSTRAINT CC_ACCMAGGYBALS_WSKOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMAGGYBALS_WCDOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_YEARBALS MODIFY (WCDOS CONSTRAINT CC_ACCMAGGYBALS_WCDOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMAGGYBALS_WCKOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_YEARBALS MODIFY (WCKOS CONSTRAINT CC_ACCMAGGYBALS_WCKOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCMAGGYBALS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCMAGGYBALS ON BARS.ACCM_AGG_YEARBALS (CALDT_ID, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSACCM  LOCAL
 (PARTITION P0 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSACCM ) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCM_AGG_YEARBALS ***
grant SELECT                                                                 on ACCM_AGG_YEARBALS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCM_AGG_YEARBALS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCM_AGG_YEARBALS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCM_AGG_YEARBALS to START1;
grant SELECT                                                                 on ACCM_AGG_YEARBALS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCM_AGG_YEARBALS.sql =========*** End
PROMPT ===================================================================================== 
