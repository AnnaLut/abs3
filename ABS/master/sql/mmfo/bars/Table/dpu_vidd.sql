

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPU_VIDD.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPU_VIDD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPU_VIDD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPU_VIDD'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPU_VIDD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPU_VIDD ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPU_VIDD 
   (	VIDD NUMBER(38,0), 
	NAME VARCHAR2(50), 
	KV NUMBER(3,0), 
	SROK NUMBER(7,2), 
	BSD CHAR(4), 
	BSN CHAR(4), 
	BASEY NUMBER(*,0), 
	METR NUMBER(*,0), 
	BR_ID NUMBER(38,0), 
	FREQ_N NUMBER(3,0), 
	FREQ_V NUMBER(3,0), 
	ACC7 NUMBER(38,0), 
	TT CHAR(3), 
	COMPROC NUMBER(1,0) DEFAULT 0, 
	ID_STOP NUMBER(38,0), 
	MIN_SUMM NUMBER(24,0), 
	LIMIT NUMBER(24,0), 
	PENYA NUMBER(24,0), 
	SHABLON VARCHAR2(35), 
	COMMENTS VARCHAR2(128), 
	FLAG NUMBER(1,0) DEFAULT 0, 
	FL_ADD NUMBER(1,0) DEFAULT 0, 
	FL_EXTEND NUMBER(1,0) DEFAULT 0, 
	TIP_OST NUMBER(1,0) DEFAULT 1, 
	DPU_TYPE NUMBER(1,0), 
	FL_AUTOEXTEND NUMBER(1,0) DEFAULT 0, 
	DPU_CODE CHAR(4), 
	MAX_SUMM NUMBER(24,0), 
	TYPE_ID NUMBER(38,0) DEFAULT 0, 
	TERM_TYPE NUMBER(1,0) DEFAULT 1, 
	TERM_MIN NUMBER(6,4), 
	TERM_MAX NUMBER(6,4) DEFAULT 0, 
	TERM_ADD NUMBER(6,4), 
	IRVK NUMBER(1,0) DEFAULT 1, 
	EXN_MTH_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPU_VIDD ***
 exec bpa.alter_policies('DPU_VIDD');


COMMENT ON TABLE BARS.DPU_VIDD IS 'Виды вкладов для ЮЛ';
COMMENT ON COLUMN BARS.DPU_VIDD.EXN_MTH_ID IS 'Ідентифікатор методу автопролонгації депозиту';
COMMENT ON COLUMN BARS.DPU_VIDD.VIDD IS 'Вид вклада';
COMMENT ON COLUMN BARS.DPU_VIDD.NAME IS 'Название вклада';
COMMENT ON COLUMN BARS.DPU_VIDD.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.DPU_VIDD.SROK IS 'Длительность вида депозитного договора ЮЛ';
COMMENT ON COLUMN BARS.DPU_VIDD.BSD IS 'Бал.счет депозита';
COMMENT ON COLUMN BARS.DPU_VIDD.BSN IS 'Бал.счет начисл.%%';
COMMENT ON COLUMN BARS.DPU_VIDD.BASEY IS '###Код базы начисления %%';
COMMENT ON COLUMN BARS.DPU_VIDD.METR IS 'Код метода начичления %%';
COMMENT ON COLUMN BARS.DPU_VIDD.BR_ID IS 'Код базовой %% ставки';
COMMENT ON COLUMN BARS.DPU_VIDD.FREQ_N IS 'Периодичность начисления %%';
COMMENT ON COLUMN BARS.DPU_VIDD.FREQ_V IS 'Frequency of interest payment';
COMMENT ON COLUMN BARS.DPU_VIDD.ACC7 IS '###Внутр.номер счета расходов';
COMMENT ON COLUMN BARS.DPU_VIDD.TT IS 'Код операции по начислению %%';
COMMENT ON COLUMN BARS.DPU_VIDD.COMPROC IS 'Allowed compound interest';
COMMENT ON COLUMN BARS.DPU_VIDD.ID_STOP IS 'Код штрафа за досрочное расторжение договора';
COMMENT ON COLUMN BARS.DPU_VIDD.MIN_SUMM IS 'Миним.сумма депозита';
COMMENT ON COLUMN BARS.DPU_VIDD.LIMIT IS 'Миним.сумма пополнения депозита';
COMMENT ON COLUMN BARS.DPU_VIDD.PENYA IS 'Пеня за несвоевременный возврат депозита';
COMMENT ON COLUMN BARS.DPU_VIDD.SHABLON IS 'Шаблон договора';
COMMENT ON COLUMN BARS.DPU_VIDD.COMMENTS IS 'Комментарий';
COMMENT ON COLUMN BARS.DPU_VIDD.FLAG IS 'Флаг активности вида депозита';
COMMENT ON COLUMN BARS.DPU_VIDD.FL_ADD IS 'Флаг пополнения депозита';
COMMENT ON COLUMN BARS.DPU_VIDD.FL_EXTEND IS 'Флаг депозитной линии';
COMMENT ON COLUMN BARS.DPU_VIDD.TIP_OST IS 'Тип начисления';
COMMENT ON COLUMN BARS.DPU_VIDD.DPU_TYPE IS 'Тип депозита: 0-до востреб, 1-краткоср., 2-долгоср.';
COMMENT ON COLUMN BARS.DPU_VIDD.FL_AUTOEXTEND IS 'Признак автомат.переоформления договора';
COMMENT ON COLUMN BARS.DPU_VIDD.DPU_CODE IS 'Символьный код вида договора';
COMMENT ON COLUMN BARS.DPU_VIDD.MAX_SUMM IS 'Макс.сумма депозита';
COMMENT ON COLUMN BARS.DPU_VIDD.TYPE_ID IS 'Числ.код типа договора';
COMMENT ON COLUMN BARS.DPU_VIDD.TERM_TYPE IS 'Тип терміну депозиту (1 - фікований, 2 - діапазон)';
COMMENT ON COLUMN BARS.DPU_VIDD.TERM_MIN IS 'Мінімальний термін дії депозиту';
COMMENT ON COLUMN BARS.DPU_VIDD.TERM_MAX IS 'Максимальний термін дії депозиту';
COMMENT ON COLUMN BARS.DPU_VIDD.TERM_ADD IS 'Термін протягом якого дозволено поповнення депозиту';
COMMENT ON COLUMN BARS.DPU_VIDD.IRVK IS '1 - Irrevocable (terminable) / 0 - Revocable (on demand)';




PROMPT *** Create  constraint CC_DPUVIDD_COMPROC_FREQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD ADD CONSTRAINT CC_DPUVIDD_COMPROC_FREQ CHECK ( COMPROC = decode(FREQ_V,5,COMPROC,0) ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_VIDD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD MODIFY (VIDD CONSTRAINT CC_DPUVIDD_VIDD_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD MODIFY (NAME CONSTRAINT CC_DPUVIDD_NAME_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD MODIFY (KV CONSTRAINT CC_DPUVIDD_KV_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_BSD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD MODIFY (BSD CONSTRAINT CC_DPUVIDD_BSD_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_BSN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD MODIFY (BSN CONSTRAINT CC_DPUVIDD_BSN_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_BASEY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD MODIFY (BASEY CONSTRAINT CC_DPUVIDD_BASEY_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_METR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD MODIFY (METR CONSTRAINT CC_DPUVIDD_METR_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_FREQN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD MODIFY (FREQ_N CONSTRAINT CC_DPUVIDD_FREQN_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_FREQV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD MODIFY (FREQ_V CONSTRAINT CC_DPUVIDD_FREQV_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD MODIFY (TT CONSTRAINT CC_DPUVIDD_TT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_COMPROC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD MODIFY (COMPROC CONSTRAINT CC_DPUVIDD_COMPROC_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_IDSTOP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD MODIFY (ID_STOP CONSTRAINT CC_DPUVIDD_IDSTOP_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_FLAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD MODIFY (FLAG CONSTRAINT CC_DPUVIDD_FLAG_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_FLADD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD MODIFY (FL_ADD CONSTRAINT CC_DPUVIDD_FLADD_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_FLEXTEND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD MODIFY (FL_EXTEND CONSTRAINT CC_DPUVIDD_FLEXTEND_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_TIPOST_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD MODIFY (TIP_OST CONSTRAINT CC_DPUVIDD_TIPOST_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_DPUTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD MODIFY (DPU_TYPE CONSTRAINT CC_DPUVIDD_DPUTYPE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_FLAUTOEXTEND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD MODIFY (FL_AUTOEXTEND CONSTRAINT CC_DPUVIDD_FLAUTOEXTEND_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD MODIFY (TYPE_ID CONSTRAINT CC_DPUVIDD_TYPEID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_TERMMAX_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD MODIFY (TERM_MAX CONSTRAINT CC_DPUVIDD_TERMMAX_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_IRREVOCABLE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD MODIFY (IRVK CONSTRAINT CC_DPUVIDD_IRREVOCABLE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_TERMTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD ADD CONSTRAINT CC_DPUVIDD_TERMTYPE CHECK (TERM_TYPE in ( 1, 2 )) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_IRREVOCABLE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD ADD CONSTRAINT CC_DPUVIDD_IRREVOCABLE CHECK (IRVK=0 OR IRVK=1) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_COMPROC ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD ADD CONSTRAINT CC_DPUVIDD_COMPROC CHECK (comproc   in (0,1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_DPUTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD ADD CONSTRAINT CC_DPUVIDD_DPUTYPE CHECK (dpu_type in (0,1,2)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_FLADD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD ADD CONSTRAINT CC_DPUVIDD_FLADD CHECK (fl_add    in (0,1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_FLAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD ADD CONSTRAINT CC_DPUVIDD_FLAG CHECK (flag      in (0,1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_FLAUTOEXTEND ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD ADD CONSTRAINT CC_DPUVIDD_FLAUTOEXTEND CHECK (fl_autoextend in (0,1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_FLEXTEND ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD ADD CONSTRAINT CC_DPUVIDD_FLEXTEND CHECK (fl_extend in (0,1,2)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDD_TIPOST ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD ADD CONSTRAINT CC_DPUVIDD_TIPOST CHECK (tip_ost   in (0,1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPUVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD ADD CONSTRAINT PK_DPUVIDD PRIMARY KEY (VIDD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_DPUVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD ADD CONSTRAINT UK_DPUVIDD UNIQUE (VIDD, TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_DPUVIDD_VIDD_TYPEID ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DPUVIDD_VIDD_TYPEID ON BARS.DPU_VIDD (VIDD, TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_DPUVIDD_TYPEID_KV ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DPUVIDD_TYPEID_KV ON BARS.DPU_VIDD (TYPE_ID, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPU_VIDD ***
grant SELECT                                                                 on DPU_VIDD        to BARSREADER_ROLE;
grant SELECT                                                                 on DPU_VIDD        to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPU_VIDD        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPU_VIDD        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_VIDD        to DPT_ADMIN;
grant SELECT                                                                 on DPU_VIDD        to DPT_ROLE;
grant SELECT                                                                 on DPU_VIDD        to START1;
grant SELECT                                                                 on DPU_VIDD        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPU_VIDD        to WR_ALL_RIGHTS;
grant SELECT                                                                 on DPU_VIDD        to WR_DEPOSIT_U;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPU_VIDD.sql =========*** End *** ====
PROMPT ===================================================================================== 
