

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCM_SNAP_BALANCES_OLD.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCM_SNAP_BALANCES_OLD ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCM_SNAP_BALANCES_OLD ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCM_SNAP_BALANCES_OLD 
   (	CALDT_ID NUMBER(38,0), 
	ACC NUMBER(38,0), 
	RNK NUMBER(38,0), 
	OST NUMBER(24,0), 
	OSTQ NUMBER(24,0), 
	DOS NUMBER(24,0), 
	DOSQ NUMBER(24,0), 
	KOS NUMBER(24,0), 
	KOSQ NUMBER(24,0)
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




PROMPT *** ALTER_POLICIES to ACCM_SNAP_BALANCES_OLD ***
 exec bpa.alter_policies('ACCM_SNAP_BALANCES_OLD');


COMMENT ON TABLE BARS.ACCM_SNAP_BALANCES_OLD IS 'Подсистема накопления. Срезы балансов';
COMMENT ON COLUMN BARS.ACCM_SNAP_BALANCES_OLD.CALDT_ID IS 'Ид. даты баланса';
COMMENT ON COLUMN BARS.ACCM_SNAP_BALANCES_OLD.ACC IS 'Ид. счета';
COMMENT ON COLUMN BARS.ACCM_SNAP_BALANCES_OLD.RNK IS 'Ид. клиента';
COMMENT ON COLUMN BARS.ACCM_SNAP_BALANCES_OLD.OST IS 'Исходящий остаток на счете (номинал)';
COMMENT ON COLUMN BARS.ACCM_SNAP_BALANCES_OLD.OSTQ IS 'Исходящий остаток на счете (эквивалент)';
COMMENT ON COLUMN BARS.ACCM_SNAP_BALANCES_OLD.DOS IS 'Сумма дебетовых оборотов (номинал)';
COMMENT ON COLUMN BARS.ACCM_SNAP_BALANCES_OLD.DOSQ IS 'Сумма дебетовых оборотов (эквивалент)';
COMMENT ON COLUMN BARS.ACCM_SNAP_BALANCES_OLD.KOS IS 'Сумма кредитовых оборотов (номинал)';
COMMENT ON COLUMN BARS.ACCM_SNAP_BALANCES_OLD.KOSQ IS 'Сумма кредитовых оборотов (эквивалент)';




PROMPT *** Create  constraint PK_ACCMSNAPBALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_SNAP_BALANCES_OLD ADD CONSTRAINT PK_ACCMSNAPBALS PRIMARY KEY (CALDT_ID, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSACCM  LOCAL
 (PARTITION P0 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSACCM )  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSNAPBALS_CALDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_SNAP_BALANCES_OLD MODIFY (CALDT_ID CONSTRAINT CC_ACCMSNAPBALS_CALDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSNAPBALS_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_SNAP_BALANCES_OLD MODIFY (ACC CONSTRAINT CC_ACCMSNAPBALS_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSNAPBALS_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_SNAP_BALANCES_OLD MODIFY (RNK CONSTRAINT CC_ACCMSNAPBALS_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSNAPBALS_OST_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_SNAP_BALANCES_OLD MODIFY (OST CONSTRAINT CC_ACCMSNAPBALS_OST_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSNAPBALS_OSTQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_SNAP_BALANCES_OLD MODIFY (OSTQ CONSTRAINT CC_ACCMSNAPBALS_OSTQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSNAPBALS_DOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_SNAP_BALANCES_OLD MODIFY (DOS CONSTRAINT CC_ACCMSNAPBALS_DOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSNAPBALS_DOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_SNAP_BALANCES_OLD MODIFY (DOSQ CONSTRAINT CC_ACCMSNAPBALS_DOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSNAPBALS_KOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_SNAP_BALANCES_OLD MODIFY (KOS CONSTRAINT CC_ACCMSNAPBALS_KOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSNAPBALS_KOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_SNAP_BALANCES_OLD MODIFY (KOSQ CONSTRAINT CC_ACCMSNAPBALS_KOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCMSNAPBALS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCMSNAPBALS ON BARS.ACCM_SNAP_BALANCES_OLD (CALDT_ID, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSACCM  LOCAL
 (PARTITION P0 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSACCM ) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCM_SNAP_BALANCES_OLD ***
grant SELECT                                                                 on ACCM_SNAP_BALANCES_OLD to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on ACCM_SNAP_BALANCES_OLD to BARSREADER_ROLE;
grant SELECT                                                                 on ACCM_SNAP_BALANCES_OLD to BARSUPL;
grant SELECT                                                                 on ACCM_SNAP_BALANCES_OLD to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCM_SNAP_BALANCES_OLD to BARS_DM;
grant SELECT                                                                 on ACCM_SNAP_BALANCES_OLD to START1;
grant SELECT                                                                 on ACCM_SNAP_BALANCES_OLD to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCM_SNAP_BALANCES_OLD.sql =========**
PROMPT ===================================================================================== 
