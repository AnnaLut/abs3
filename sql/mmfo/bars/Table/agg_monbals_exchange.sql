

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/AGG_MONBALS_EXCHANGE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to AGG_MONBALS_EXCHANGE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''AGG_MONBALS_EXCHANGE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''AGG_MONBALS_EXCHANGE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''AGG_MONBALS_EXCHANGE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table AGG_MONBALS_EXCHANGE ***
begin 
  execute immediate '
  CREATE TABLE BARS.AGG_MONBALS_EXCHANGE 
   (	FDAT DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	ACC NUMBER(*,0), 
	RNK NUMBER(*,0), 
	OST NUMBER(24,0), 
	OSTQ NUMBER(24,0), 
	DOS NUMBER(24,0), 
	DOSQ NUMBER(24,0), 
	KOS NUMBER(24,0), 
	KOSQ NUMBER(24,0), 
	CRDOS NUMBER(24,0) DEFAULT 0, 
	CRDOSQ NUMBER(24,0) DEFAULT 0, 
	CRKOS NUMBER(24,0) DEFAULT 0, 
	CRKOSQ NUMBER(24,0) DEFAULT 0, 
	CUDOS NUMBER(24,0) DEFAULT 0, 
	CUDOSQ NUMBER(24,0) DEFAULT 0, 
	CUKOS NUMBER(24,0) DEFAULT 0, 
	CUKOSQ NUMBER(24,0) DEFAULT 0, 
	CALDT_ID NUMBER GENERATED ALWAYS AS (TO_NUMBER(TO_CHAR(FDAT,''j''))-2447892) VIRTUAL VISIBLE 
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING
  TABLESPACE BRSACCM ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to AGG_MONBALS_EXCHANGE ***
 exec bpa.alter_policies('AGG_MONBALS_EXCHANGE');


COMMENT ON TABLE BARS.AGG_MONBALS_EXCHANGE IS 'Ќакопительные балансы за мес€ц';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE.FDAT IS 'ƒата балансу';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE.KF IS ' од ф≥л≥алу (ћ‘ќ)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE.ACC IS '≤д. рахунка';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE.RNK IS '≤д. кл≥Їнта';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE.OST IS '¬их≥дний залишок по рахунку (ном≥нал)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE.OSTQ IS '¬их≥дний залишок по рахунку (екв≥валент)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE.DOS IS '—ума дебетових оборот≥в (ном≥нал)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE.DOSQ IS '—ума дебетових оборот≥в (екв≥валент)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE.KOS IS '—ума кредитових оборот≥в (ном≥нал)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE.KOSQ IS '—ума кредитових оборот≥в (екв≥валент)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE.CRDOS IS '—ума корегуючих дебетових  оборот≥в (ном≥нал)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE.CRDOSQ IS '—ума корегуючих дебетових  оборот≥в (екв≥валент)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE.CRKOS IS '—ума корегуючих кредитових оборот≥в (ном≥нал)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE.CRKOSQ IS '—ума корегуючих кредитових оборот≥в (екв≥валент)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE.CUDOS IS '—ума корегуючих дебетових  оборот≥в минулого м≥с€ц€ (ном≥нал)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE.CUDOSQ IS '—ума корегуючих дебетових  оборот≥в минулого м≥с€ц€ (екв≥валент)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE.CUKOS IS '—ума корегуючих кредитових оборот≥в минулого м≥с€ц€ (ном≥нал)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE.CUKOSQ IS '—ума корегуючих кредитових оборот≥в минулого м≥с€ц€ (екв≥валент)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE.CALDT_ID IS '≤д. дати балансу';




PROMPT *** Create  constraint CC_AGG_MONBALS_EXG_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS_EXCHANGE MODIFY (FDAT CONSTRAINT CC_AGG_MONBALS_EXG_FDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AGG_MONBALS_EXG_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS_EXCHANGE MODIFY (KF CONSTRAINT CC_AGG_MONBALS_EXG_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AGG_MONBALS_EXG_KOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS_EXCHANGE MODIFY (KOSQ CONSTRAINT CC_AGG_MONBALS_EXG_KOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AGG_MONBALS_EXG_KOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS_EXCHANGE MODIFY (KOS CONSTRAINT CC_AGG_MONBALS_EXG_KOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AGG_MONBALS_EXG_DOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS_EXCHANGE MODIFY (DOSQ CONSTRAINT CC_AGG_MONBALS_EXG_DOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AGG_MONBALS_EXG_DOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS_EXCHANGE MODIFY (DOS CONSTRAINT CC_AGG_MONBALS_EXG_DOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AGG_MONBALS_EXG_OSTQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS_EXCHANGE MODIFY (OSTQ CONSTRAINT CC_AGG_MONBALS_EXG_OSTQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AGG_MONBALS_EXG_OST_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS_EXCHANGE MODIFY (OST CONSTRAINT CC_AGG_MONBALS_EXG_OST_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AGG_MONBALS_EXG_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS_EXCHANGE MODIFY (RNK CONSTRAINT CC_AGG_MONBALS_EXG_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AGG_MONBALS_EXG_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS_EXCHANGE MODIFY (ACC CONSTRAINT CC_AGG_MONBALS_EXG_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_AGG_MONBALS_EXG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_AGG_MONBALS_EXG ON BARS.AGG_MONBALS_EXCHANGE (FDAT, KF, ACC) 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 2 
  TABLESPACE BRSACCM ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  AGG_MONBALS_EXCHANGE ***
grant ALTER,SELECT                                                           on AGG_MONBALS_EXCHANGE to DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/AGG_MONBALS_EXCHANGE.sql =========*** 
PROMPT ===================================================================================== 
