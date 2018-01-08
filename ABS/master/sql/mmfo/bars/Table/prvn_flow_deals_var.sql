

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRVN_FLOW_DEALS_VAR.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRVN_FLOW_DEALS_VAR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PRVN_FLOW_DEALS_VAR'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PRVN_FLOW_DEALS_VAR'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''PRVN_FLOW_DEALS_VAR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PRVN_FLOW_DEALS_VAR ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRVN_FLOW_DEALS_VAR 
   (	ID NUMBER(38,0), 
	ZDAT DATE, 
	K NUMBER(38,4), 
	OST NUMBER(38,0), 
	OST8 NUMBER(38,0), 
	OSTQ NUMBER(38,0), 
	OST8Q NUMBER(38,0), 
	IR NUMBER(38,8), 
	IRR0 NUMBER(38,8), 
	PV NUMBER(38,0), 
	PV0 NUMBER(38,0), 
	WDATE DATE, 
	SN NUMBER(38,0), 
	CR9 NUMBER(38,0), 
	SPN NUMBER(38,0), 
	SNO NUMBER(38,0), 
	SN8 NUMBER(38,0), 
	SK0 NUMBER(38,0), 
	SK9 NUMBER(38,0), 
	SDI NUMBER(38,0), 
	S36 NUMBER(38,0), 
	SP NUMBER(38,0), 
	K1 NUMBER(38,4), 
	VIDD NUMBER, 
	RNK NUMBER, 
	I_CR9 NUMBER(1,0), 
	PR_TR NUMBER(1,0), 
	BV NUMBER(38,0), 
	S36U NUMBER, 
	ZO NUMBER(*,0), 
	FV_REZB NUMBER, 
	FV_REZ9 NUMBER, 
	SNA NUMBER(38,0), 
	SD1 NUMBER(38,0), 
	SD2 NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PRVN_FLOW_DEALS_VAR ***
 exec bpa.alter_policies('PRVN_FLOW_DEALS_VAR');


COMMENT ON TABLE BARS.PRVN_FLOW_DEALS_VAR IS 'Таблиця КД-угод для сховища с доп. инфо на звитну дату';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.KF IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.ID IS 'Ід в табл prvn_flow_deals_const';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.ZDAT IS 'Ост.звітна дата';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.K IS 'Коеф~`SS~:~Сум(`SS) по угоді в цілому';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.OST IS 'Залишок по рах';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.OST8 IS 'Залишок по дог';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.OSTQ IS 'Залишок-екв по рах';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.OST8Q IS 'Залишок-екв по дог';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.IR IS 'Діюча ном.ставка по рах.';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.IRR0 IS 'Діюча еф.ставка по КД';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.PV IS 'Спр.вартість КД (дисконт.эфф/ном ставку)';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.PV0 IS 'Спр.вартість КД (не дисконтована)';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.WDATE IS 'Дата заверш КД (Діюча на зв.дату)';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.SN IS 'Нарах відсотки';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.CR9 IS 'Невикористаний ліміт';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.SPN IS 'Простроч.нарах відсотки';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.SNO IS 'Нараховані та відкладені відсотки';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.SN8 IS 'Пеня';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.SK0 IS 'Нарахована комісія';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.SK9 IS 'простроч Нарахована комісія';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.SDI IS 'Дисконт/Премія';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.S36 IS 'Дох.майбутніх періодів(загальна сума)';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.SP IS 'Простроч.тілу кредиту';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.K1 IS 'Коеф~ SS~:~Сум( SS) по угоді + по вал';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.VIDD IS 'Вид КД';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.RNK IS 'РНК позичальника';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.I_CR9 IS 'Востанавл=0, НеВостанавл CR9=1';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.PR_TR IS 'Признак траншей (0-НЕТ/1-ДА)';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.BV IS 'Балансова вартість';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.S36U IS 'Дох.майбутніх періодів(врахована сума)';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.ZO IS '=0 без корр, =1-з корр';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.FV_REZB IS '=PRVN_FV_REZ.PROV_BALANCE_CCY=Резерв по балансовой части договора. Расчетный параметр Finevare';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.FV_REZ9 IS '=PRVN_FV_REZ.PROV_OFFBALANCE_CCY=Резерв по внебалансовой части договора. Расчетный параметр Finevare';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.SNA IS 'НЕвизнані дох % ';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.SD1 IS 'Загальні нара. проц з поч звітного року';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.SD2 IS 'Загальна амортизацыя з поч звітного року';




PROMPT *** Create  constraint PK_PRVN_F_D_VAR ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_FLOW_DEALS_VAR ADD CONSTRAINT PK_PRVN_F_D_VAR PRIMARY KEY (ID, ZDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRVNDEALSVAR_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_FLOW_DEALS_VAR MODIFY (KF CONSTRAINT CC_PRVNDEALSVAR_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PRVN_F_D_VAR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PRVN_F_D_VAR ON BARS.PRVN_FLOW_DEALS_VAR (ID, ZDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_PRVNDEALSVAR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_PRVNDEALSVAR ON BARS.PRVN_FLOW_DEALS_VAR (ZDAT, KF, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 2 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PRVN_FLOW_DEALS_VAR ***
grant SELECT                                                                 on PRVN_FLOW_DEALS_VAR to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on PRVN_FLOW_DEALS_VAR to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PRVN_FLOW_DEALS_VAR to BARS_DM;
grant SELECT,UPDATE                                                          on PRVN_FLOW_DEALS_VAR to START1;
grant SELECT                                                                 on PRVN_FLOW_DEALS_VAR to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRVN_FLOW_DEALS_VAR.sql =========*** E
PROMPT ===================================================================================== 
