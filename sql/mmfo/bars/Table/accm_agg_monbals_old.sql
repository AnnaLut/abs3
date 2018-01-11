

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCM_AGG_MONBALS_OLD.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCM_AGG_MONBALS_OLD ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCM_AGG_MONBALS_OLD ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCM_AGG_MONBALS_OLD 
   (	CALDT_ID NUMBER(38,0), 
	ACC NUMBER(38,0), 
	RNK NUMBER(38,0), 
	OST NUMBER(24,0), 
	OSTQ NUMBER(24,0), 
	DOS NUMBER(24,0), 
	DOSQ NUMBER(24,0), 
	KOS NUMBER(24,0), 
	KOSQ NUMBER(24,0), 
	CRDOS NUMBER(24,0), 
	CRDOSQ NUMBER(24,0), 
	CRKOS NUMBER(24,0), 
	CRKOSQ NUMBER(24,0), 
	CUDOS NUMBER(24,0), 
	CUDOSQ NUMBER(24,0), 
	CUKOS NUMBER(24,0), 
	CUKOSQ NUMBER(24,0)
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




PROMPT *** ALTER_POLICIES to ACCM_AGG_MONBALS_OLD ***
 exec bpa.alter_policies('ACCM_AGG_MONBALS_OLD');


COMMENT ON TABLE BARS.ACCM_AGG_MONBALS_OLD IS 'Подсистема накопления. Накопительные балансы за месяц';
COMMENT ON COLUMN BARS.ACCM_AGG_MONBALS_OLD.CALDT_ID IS 'Ид. даты баланса';
COMMENT ON COLUMN BARS.ACCM_AGG_MONBALS_OLD.ACC IS 'Ид. счета';
COMMENT ON COLUMN BARS.ACCM_AGG_MONBALS_OLD.RNK IS 'Ид. клиента';
COMMENT ON COLUMN BARS.ACCM_AGG_MONBALS_OLD.OST IS 'Исходящий остаток на счете (номинал)';
COMMENT ON COLUMN BARS.ACCM_AGG_MONBALS_OLD.OSTQ IS 'Исходящий остаток на счете (эквивалент)';
COMMENT ON COLUMN BARS.ACCM_AGG_MONBALS_OLD.DOS IS 'Сумма дебетовых оборотов (номинал)';
COMMENT ON COLUMN BARS.ACCM_AGG_MONBALS_OLD.DOSQ IS 'Сумма дебетовых оборотов (эквивалент)';
COMMENT ON COLUMN BARS.ACCM_AGG_MONBALS_OLD.KOS IS 'Сумма кредитовых оборотов (номинал)';
COMMENT ON COLUMN BARS.ACCM_AGG_MONBALS_OLD.KOSQ IS 'Сумма кредитовых оборотов (эквивалент)';
COMMENT ON COLUMN BARS.ACCM_AGG_MONBALS_OLD.CRDOS IS 'Сумма корректирующих дебетовых оборотов (номинал)';
COMMENT ON COLUMN BARS.ACCM_AGG_MONBALS_OLD.CRDOSQ IS 'Сумма корректирующих дебетовых оборотов (эквивалент)';
COMMENT ON COLUMN BARS.ACCM_AGG_MONBALS_OLD.CRKOS IS 'Сумма корректирующих кредитовых оборотов (номинал)';
COMMENT ON COLUMN BARS.ACCM_AGG_MONBALS_OLD.CRKOSQ IS 'Сумма корректирующих кредитовых оборотов (эквивалент)';
COMMENT ON COLUMN BARS.ACCM_AGG_MONBALS_OLD.CUDOS IS 'Сумма корректирующих дебетовых оборотов прошлого месяца (номинал)';
COMMENT ON COLUMN BARS.ACCM_AGG_MONBALS_OLD.CUDOSQ IS 'Сумма корректирующих дебетовых оборотов прошлого месяца (эквивалент)';
COMMENT ON COLUMN BARS.ACCM_AGG_MONBALS_OLD.CUKOS IS 'Сумма корректирующих кредитовых оборотов прошлого месяца (номинал)';
COMMENT ON COLUMN BARS.ACCM_AGG_MONBALS_OLD.CUKOSQ IS 'Сумма корректирующих кредитовых оборотов прошлого месяца (эквивалент)';




PROMPT *** Create  constraint PK_ACCMAGGBALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_MONBALS_OLD ADD CONSTRAINT PK_ACCMAGGBALS PRIMARY KEY (CALDT_ID, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSACCM  LOCAL
 (PARTITION P0 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSACCM )  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMAGGMBALS_CALDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_MONBALS_OLD MODIFY (CALDT_ID CONSTRAINT CC_ACCMAGGMBALS_CALDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMAGGMBALS_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_MONBALS_OLD MODIFY (ACC CONSTRAINT CC_ACCMAGGMBALS_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMAGGMBALS_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_MONBALS_OLD MODIFY (RNK CONSTRAINT CC_ACCMAGGMBALS_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMAGGMBALS_OST_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_MONBALS_OLD MODIFY (OST CONSTRAINT CC_ACCMAGGMBALS_OST_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMAGGMBALS_OSTQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_MONBALS_OLD MODIFY (OSTQ CONSTRAINT CC_ACCMAGGMBALS_OSTQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMAGGMBALS_DOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_MONBALS_OLD MODIFY (DOS CONSTRAINT CC_ACCMAGGMBALS_DOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMAGGMBALS_DOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_MONBALS_OLD MODIFY (DOSQ CONSTRAINT CC_ACCMAGGMBALS_DOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMAGGMBALS_KOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_MONBALS_OLD MODIFY (KOS CONSTRAINT CC_ACCMAGGMBALS_KOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMAGGMBALS_KOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_MONBALS_OLD MODIFY (KOSQ CONSTRAINT CC_ACCMAGGMBALS_KOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMAGGMBALS_CRDOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_MONBALS_OLD MODIFY (CRDOS CONSTRAINT CC_ACCMAGGMBALS_CRDOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMAGGMBALS_CRDOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_MONBALS_OLD MODIFY (CRDOSQ CONSTRAINT CC_ACCMAGGMBALS_CRDOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMAGGMBALS_CRKOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_MONBALS_OLD MODIFY (CRKOS CONSTRAINT CC_ACCMAGGMBALS_CRKOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMAGGMBALS_CRKOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_MONBALS_OLD MODIFY (CRKOSQ CONSTRAINT CC_ACCMAGGMBALS_CRKOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMAGGMBALS_CUDOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_MONBALS_OLD MODIFY (CUDOS CONSTRAINT CC_ACCMAGGMBALS_CUDOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMAGGMBALS_CUDOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_MONBALS_OLD MODIFY (CUDOSQ CONSTRAINT CC_ACCMAGGMBALS_CUDOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMAGGMBALS_CUKOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_MONBALS_OLD MODIFY (CUKOS CONSTRAINT CC_ACCMAGGMBALS_CUKOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMAGGMBALS_CUKOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_MONBALS_OLD MODIFY (CUKOSQ CONSTRAINT CC_ACCMAGGMBALS_CUKOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCMAGGBALS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCMAGGBALS ON BARS.ACCM_AGG_MONBALS_OLD (CALDT_ID, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSACCM  LOCAL
 (PARTITION P0 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSACCM ) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCM_AGG_MONBALS_OLD ***
grant SELECT                                                                 on ACCM_AGG_MONBALS_OLD to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on ACCM_AGG_MONBALS_OLD to BARSREADER_ROLE;
grant SELECT                                                                 on ACCM_AGG_MONBALS_OLD to BARSUPL;
grant SELECT                                                                 on ACCM_AGG_MONBALS_OLD to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCM_AGG_MONBALS_OLD to BARS_DM;
grant SELECT                                                                 on ACCM_AGG_MONBALS_OLD to SALGL;
grant SELECT                                                                 on ACCM_AGG_MONBALS_OLD to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCM_AGG_MONBALS_OLD.sql =========*** 
PROMPT ===================================================================================== 
