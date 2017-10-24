

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBU23_REZ.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBU23_REZ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBU23_REZ'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NBU23_REZ'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBU23_REZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBU23_REZ 
   (	FDAT DATE, 
	ID VARCHAR2(50), 
	RNK NUMBER, 
	NBS CHAR(4), 
	KV NUMBER, 
	ND NUMBER, 
	CC_ID VARCHAR2(50), 
	ACC NUMBER, 
	NLS VARCHAR2(20), 
	BRANCH VARCHAR2(30), 
	FIN NUMBER, 
	OBS NUMBER, 
	KAT NUMBER, 
	K NUMBER, 
	IRR NUMBER, 
	ZAL NUMBER, 
	BV NUMBER, 
	PV NUMBER, 
	REZ NUMBER, 
	REZQ NUMBER, 
	DD CHAR(1), 
	DDD CHAR(3), 
	BVQ NUMBER, 
	CUSTTYPE NUMBER, 
	IDR NUMBER, 
	WDATE DATE, 
	OKPO NUMBER, 
	NMK VARCHAR2(35), 
	RZ NUMBER, 
	PAWN NUMBER, 
	ISTVAL NUMBER, 
	R013 CHAR(1), 
	REZN NUMBER, 
	REZNQ NUMBER, 
	ARJK NUMBER, 
	REZD NUMBER, 
	PVZ NUMBER, 
	PVZQ NUMBER, 
	ZALQ NUMBER, 
	ZPR NUMBER, 
	ZPRQ NUMBER, 
	PVQ NUMBER, 
	RU VARCHAR2(70), 
	INN VARCHAR2(20), 
	NRC VARCHAR2(70), 
	SDATE DATE, 
	IR NUMBER, 
	S031 VARCHAR2(2), 
	K040 VARCHAR2(3), 
	PROD VARCHAR2(50), 
	K110 VARCHAR2(5), 
	K070 VARCHAR2(5), 
	K051 VARCHAR2(2), 
	S260 VARCHAR2(2), 
	R011 VARCHAR2(1), 
	R012 VARCHAR2(1), 
	S240 VARCHAR2(1), 
	S180 VARCHAR2(1), 
	S580 VARCHAR2(1), 
	NLS_REZ VARCHAR2(15), 
	NLS_REZN VARCHAR2(15), 
	S250 CHAR(1), 
	ACC_REZ NUMBER, 
	FIN_R NUMBER(*,0), 
	DISKONT NUMBER, 
	ISP NUMBER(*,0), 
	OB22 CHAR(2), 
	TIP CHAR(3), 
	SPEC CHAR(1), 
	ZAL_BL NUMBER, 
	S280_290 CHAR(1), 
	ZAL_BLQ NUMBER, 
	ACC_REZN NUMBER, 
	OB22_REZ CHAR(2), 
	OB22_REZN CHAR(2), 
	IR0 NUMBER, 
	IRR0 NUMBER, 
	ND_CP VARCHAR2(40), 
	SUM_IMP NUMBER, 
	SUMQ_IMP NUMBER, 
	PV_ZAL NUMBER, 
	VKR VARCHAR2(10), 
	S_L NUMBER, 
	SQ_L NUMBER, 
	ZAL_SV NUMBER, 
	ZAL_SVQ NUMBER, 
	GRP NUMBER(*,0), 
	KOL_SP NUMBER(*,0), 
	REZ39 NUMBER, 
	PVP NUMBER, 
	BV_30 NUMBER, 
	BVQ_30 NUMBER, 
	REZ_30 NUMBER, 
	REZQ_30 NUMBER, 
	NLS_REZ_30 VARCHAR2(15), 
	ACC_REZ_30 NUMBER, 
	OB22_REZ_30 CHAR(2), 
	BV_0 NUMBER, 
	BVQ_0 NUMBER, 
	REZ_0 NUMBER, 
	REZQ_0 NUMBER, 
	NLS_REZ_0 VARCHAR2(15), 
	ACC_REZ_0 NUMBER, 
	OB22_REZ_0 CHAR(2), 
	KAT39 NUMBER, 
	REZQ39 NUMBER, 
	S250_39 VARCHAR2(1), 
	REZ23 NUMBER, 
	REZQ23 NUMBER, 
	KAT23 NUMBER, 
	S250_23 VARCHAR2(1), 
	DAT_MI DATE, 
	TIPA NUMBER(*,0), 
	BVUQ NUMBER, 
	BVU NUMBER, 
	EAD NUMBER, 
	EADQ NUMBER, 
	CR NUMBER, 
	CRQ NUMBER, 
	FIN_351 NUMBER, 
	KOL_351 NUMBER, 
	KPZ NUMBER, 
	KL_351 NUMBER, 
	LGD NUMBER, 
	OVKR VARCHAR2(50), 
	P_DEF VARCHAR2(50), 
	OVD VARCHAR2(50), 
	OPD VARCHAR2(50), 
	ZAL_351 NUMBER, 
	ZALQ_351 NUMBER, 
	RC NUMBER, 
	RCQ NUMBER, 
	CCF NUMBER, 
	TIP_351 NUMBER, 
	PD_0 NUMBER, 
	FIN_Z NUMBER, 
	ISTVAL_351 NUMBER(1,0), 
	RPB NUMBER, 
	S080 VARCHAR2(1), 
	S080_Z VARCHAR2(1), 
	DDD_6B CHAR(3), 
	FIN_P NUMBER(*,0), 
	FIN_D NUMBER(*,0), 
	Z NUMBER, 
	PD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBU23_REZ ***
 exec bpa.alter_policies('NBU23_REZ');


COMMENT ON TABLE BARS.NBU23_REZ IS 'Протокол розрах реп по НБУ-23';
COMMENT ON COLUMN BARS.NBU23_REZ.PD_0 IS 'Безризикові (PD=0)';
COMMENT ON COLUMN BARS.NBU23_REZ.FIN_Z IS 'Клас контрагента, визначений на основі інтегрального показника';
COMMENT ON COLUMN BARS.NBU23_REZ.ISTVAL_351 IS 'Джерело валютної виручки згідно з постановою 351';
COMMENT ON COLUMN BARS.NBU23_REZ.RPB IS 'Рівень покриття боргу';
COMMENT ON COLUMN BARS.NBU23_REZ.S080 IS 'Параметр Фин.класа по FIN_351';
COMMENT ON COLUMN BARS.NBU23_REZ.S080_Z IS 'Параметр Фин.класа по FIN_Z';
COMMENT ON COLUMN BARS.NBU23_REZ.FIN_P IS 'Скоригований клас з вр. прост.';
COMMENT ON COLUMN BARS.NBU23_REZ.FIN_D IS 'Скоригований клас на події/ознаки дефолту';
COMMENT ON COLUMN BARS.NBU23_REZ.Z IS 'Інтегральний показник';
COMMENT ON COLUMN BARS.NBU23_REZ.PD IS 'Коеф. імовірності дефолту';
COMMENT ON COLUMN BARS.NBU23_REZ.KPZ IS 'Коеф-т покриття забезпеченням (Кпз)';
COMMENT ON COLUMN BARS.NBU23_REZ.KL_351 IS 'Коеф.ліквідності забезпечення (351)';
COMMENT ON COLUMN BARS.NBU23_REZ.LGD IS 'Втрати в разі дефолту (LGD)';
COMMENT ON COLUMN BARS.NBU23_REZ.OVKR IS 'Ознаки високого кредитного ризику';
COMMENT ON COLUMN BARS.NBU23_REZ.P_DEF IS 'Події дефолту';
COMMENT ON COLUMN BARS.NBU23_REZ.OVD IS 'Ознаки визнання дефолту';
COMMENT ON COLUMN BARS.NBU23_REZ.OPD IS 'Ознаки припинення дефолту';
COMMENT ON COLUMN BARS.NBU23_REZ.ZAL_351 IS 'Рівень повернення боргу за рахунок реалізації забезпечення ном.(CV*k)';
COMMENT ON COLUMN BARS.NBU23_REZ.ZALQ_351 IS 'Рівень повернення боргу за рахунок реалізації забезпечення екв.(CV*k)';
COMMENT ON COLUMN BARS.NBU23_REZ.RC IS 'Рівень повернення боргу за рахунок інших надходжень ном.(RC)';
COMMENT ON COLUMN BARS.NBU23_REZ.RCQ IS 'Рівень повернення боргу за рахунок інших надходжень екв.(RCQ)';
COMMENT ON COLUMN BARS.NBU23_REZ.CCF IS 'Коефіцієнт кредитної конверсії (CCF)';
COMMENT ON COLUMN BARS.NBU23_REZ.TIP_351 IS 'Тип актива 351 постанова';
COMMENT ON COLUMN BARS.NBU23_REZ.DDD_6B IS 'DDD для файла #6B';
COMMENT ON COLUMN BARS.NBU23_REZ.NLS_REZ_0 IS 'счет резерва по нач.% проср.<30 дней';
COMMENT ON COLUMN BARS.NBU23_REZ.ACC_REZ_0 IS 'acc счета резерва по нач.% проср.<30 дней';
COMMENT ON COLUMN BARS.NBU23_REZ.OB22_REZ_0 IS 'Ob22 счета резерва по нач.% проср.<30 дней';
COMMENT ON COLUMN BARS.NBU23_REZ.KAT39 IS 'Категория риска из FINEVARE';
COMMENT ON COLUMN BARS.NBU23_REZ.REZQ39 IS 'Сумма резерва (экв.) из FINEVARE';
COMMENT ON COLUMN BARS.NBU23_REZ.S250_39 IS 'Метка расчета резерва на индивидуальной или коллективной основе';
COMMENT ON COLUMN BARS.NBU23_REZ.REZ23 IS 'Сумма резерва ПО 23 ПОСТ (ном.)';
COMMENT ON COLUMN BARS.NBU23_REZ.REZQ23 IS 'Сумма резерва ПО 23 ПОСТ (экв.)';
COMMENT ON COLUMN BARS.NBU23_REZ.KAT23 IS 'Категория риска из FINEVARE';
COMMENT ON COLUMN BARS.NBU23_REZ.S250_23 IS 'Метка расчета резерва на индивидуальной или коллективной основе';
COMMENT ON COLUMN BARS.NBU23_REZ.DAT_MI IS 'Дата миграции кредита';
COMMENT ON COLUMN BARS.NBU23_REZ.BVUQ IS 'Зкоригована бал.варт.екв.';
COMMENT ON COLUMN BARS.NBU23_REZ.BVU IS 'Зкоригована бал.варт.ном.';
COMMENT ON COLUMN BARS.NBU23_REZ.TIPA IS 'Тип.актива';
COMMENT ON COLUMN BARS.NBU23_REZ.EAD IS '(BV - SNA) - EAD(ном.) Експозиція під риз-ком на дату оцінки';
COMMENT ON COLUMN BARS.NBU23_REZ.EADQ IS '(BVQ - SNAQ) - EADQ(екв.) Експозиція під риз-ком на дату оцінки';
COMMENT ON COLUMN BARS.NBU23_REZ.CR IS 'Кредитний ризик CR (ном.)';
COMMENT ON COLUMN BARS.NBU23_REZ.CRQ IS 'Кредитний ризик CRQ (екв.)';
COMMENT ON COLUMN BARS.NBU23_REZ.FIN_351 IS 'Скоригований клас (351)';
COMMENT ON COLUMN BARS.NBU23_REZ.KOL_351 IS 'К-ть днів прострочки (351)';
COMMENT ON COLUMN BARS.NBU23_REZ.FDAT IS 'Зв.дата(01.11.2012.';
COMMENT ON COLUMN BARS.NBU23_REZ.ID IS 'Перв ключ:Мод+ид';
COMMENT ON COLUMN BARS.NBU23_REZ.RNK IS 'Рег № кл';
COMMENT ON COLUMN BARS.NBU23_REZ.NBS IS 'Бал.рах';
COMMENT ON COLUMN BARS.NBU23_REZ.KV IS 'Вал дог';
COMMENT ON COLUMN BARS.NBU23_REZ.ND IS 'Реф дог';
COMMENT ON COLUMN BARS.NBU23_REZ.CC_ID IS 'Ид.дог';
COMMENT ON COLUMN BARS.NBU23_REZ.ACC IS 'АСС рах';
COMMENT ON COLUMN BARS.NBU23_REZ.NLS IS '№ рах';
COMMENT ON COLUMN BARS.NBU23_REZ.BRANCH IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.FIN IS 'Фин.клас';
COMMENT ON COLUMN BARS.NBU23_REZ.OBS IS 'Обсуг.';
COMMENT ON COLUMN BARS.NBU23_REZ.KAT IS 'Кат.якост';
COMMENT ON COLUMN BARS.NBU23_REZ.K IS 'Пок.ризик';
COMMENT ON COLUMN BARS.NBU23_REZ.IRR IS 'Эфф.% ст КД - использованная';
COMMENT ON COLUMN BARS.NBU23_REZ.ZAL IS 'Забезпеч.';
COMMENT ON COLUMN BARS.NBU23_REZ.BV IS 'Бал.варт';
COMMENT ON COLUMN BARS.NBU23_REZ.PV IS 'Справ.варт';
COMMENT ON COLUMN BARS.NBU23_REZ.REZ IS 'Рез-ном.';
COMMENT ON COLUMN BARS.NBU23_REZ.REZQ IS 'Рез-екв.';
COMMENT ON COLUMN BARS.NBU23_REZ.DD IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.DDD IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.ZPR IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.ZPRQ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.PVQ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.RU IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.INN IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.NRC IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.PVZQ IS 'Враховане (частина або все Справ.варт) забезпечення, екв в 1.00';
COMMENT ON COLUMN BARS.NBU23_REZ.ZALQ IS 'Лiкв.забез~екв~ZALq';
COMMENT ON COLUMN BARS.NBU23_REZ.SDATE IS 'Дата начала договора';
COMMENT ON COLUMN BARS.NBU23_REZ.IR IS 'Ном.% ст сч - текущая';
COMMENT ON COLUMN BARS.NBU23_REZ.S031 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.K040 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.PROD IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.K110 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.BVQ IS 'Бал.варт активу, екв в 1.00';
COMMENT ON COLUMN BARS.NBU23_REZ.REZ_30 IS 'Резерв свыше 30 дней ном.';
COMMENT ON COLUMN BARS.NBU23_REZ.REZQ_30 IS 'Резерв свыше 30 дней укв.';
COMMENT ON COLUMN BARS.NBU23_REZ.NLS_REZ_30 IS 'счет резерва по нач.% проср.>30 дней';
COMMENT ON COLUMN BARS.NBU23_REZ.ACC_REZ_30 IS 'acc счета резерва по нач.% проср.>30 дней';
COMMENT ON COLUMN BARS.NBU23_REZ.OB22_REZ_30 IS 'Ob22 счета резерва по нач.% проср.>30 дней';
COMMENT ON COLUMN BARS.NBU23_REZ.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.IDR IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.WDATE IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.OKPO IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.NMK IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.RZ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.PAWN IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.ISTVAL IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.R013 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.REZN IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.REZNQ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.ARJK IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.REZD IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.K070 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.BV_0 IS 'Просрочено менее 30 дней ном.';
COMMENT ON COLUMN BARS.NBU23_REZ.BVQ_0 IS 'Просрочено менее 30 дней екв.';
COMMENT ON COLUMN BARS.NBU23_REZ.REZ_0 IS 'Резерв менее 30 дней ном.';
COMMENT ON COLUMN BARS.NBU23_REZ.REZQ_0 IS 'Резерв менее 30 дней укв.';
COMMENT ON COLUMN BARS.NBU23_REZ.K051 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.S260 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.R011 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.R012 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.S240 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.S180 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.S580 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.PVZ IS 'Враховане (частина або все Справ.варт) забезпечення, ном в 1.00';
COMMENT ON COLUMN BARS.NBU23_REZ.ZAL_SV IS 'Справедлива вартість забезпечення (ном.)';
COMMENT ON COLUMN BARS.NBU23_REZ.ZAL_SVQ IS 'Справедлива вартість забезпечення (екв.)';
COMMENT ON COLUMN BARS.NBU23_REZ.SUM_IMP IS 'Затраты на реализацию (ном.)';
COMMENT ON COLUMN BARS.NBU23_REZ.SUMQ_IMP IS 'Затраты на реализацию (экв.)';
COMMENT ON COLUMN BARS.NBU23_REZ.PV_ZAL IS 'Поток*К';
COMMENT ON COLUMN BARS.NBU23_REZ.VKR IS 'Внутр.кред.рейтинг';
COMMENT ON COLUMN BARS.NBU23_REZ.S_L IS 'Залог*коэф.ликв.-затраты на реал.(ном.)';
COMMENT ON COLUMN BARS.NBU23_REZ.SQ_L IS 'Залог*коэф.ликв.-затраты на реал.(экв.)';
COMMENT ON COLUMN BARS.NBU23_REZ.GRP IS 'група активу портфельного методу';
COMMENT ON COLUMN BARS.NBU23_REZ.KOL_SP IS 'Кількість днів прострочки';
COMMENT ON COLUMN BARS.NBU23_REZ.REZ39 IS 'Сумма резерва (ном.) из FINEVARE';
COMMENT ON COLUMN BARS.NBU23_REZ.PVP IS 'Сума очікуваних майбутніх грошових потоків за кредитом відповідно до договору ';
COMMENT ON COLUMN BARS.NBU23_REZ.BV_30 IS 'Просрочено свыше 30 дней ном.';
COMMENT ON COLUMN BARS.NBU23_REZ.BVQ_30 IS 'Просрочено свыше 30 дней укв.';
COMMENT ON COLUMN BARS.NBU23_REZ.ND_CP IS 'Ном.договора для группировки по резервам';
COMMENT ON COLUMN BARS.NBU23_REZ.IR0 IS 'Ном.% ст сч - начальная';
COMMENT ON COLUMN BARS.NBU23_REZ.IRR0 IS 'Эфф.% ст КД - известная';
COMMENT ON COLUMN BARS.NBU23_REZ.S250 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.S280_290 IS 'код количества дней просрочки';
COMMENT ON COLUMN BARS.NBU23_REZ.ZAL_BLQ IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.ACC_REZN IS 'ACC счета резерва не вкл.в налоговый';
COMMENT ON COLUMN BARS.NBU23_REZ.OB22_REZ IS 'OB22 для счета резерва вкл.в налоговый';
COMMENT ON COLUMN BARS.NBU23_REZ.OB22_REZN IS 'OB22 для счета резерва не вкл.в налоговый';
COMMENT ON COLUMN BARS.NBU23_REZ.FIN_R IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.DISKONT IS 'Сума Зменшення рез за рахунок дисконту';
COMMENT ON COLUMN BARS.NBU23_REZ.OB22 IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.TIP IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.SPEC IS '';
COMMENT ON COLUMN BARS.NBU23_REZ.ZAL_BL IS 'Сума Залога балансовая';
COMMENT ON COLUMN BARS.NBU23_REZ.ISP IS 'Виконавець по рахунку актива';
COMMENT ON COLUMN BARS.NBU23_REZ.ACC_REZ IS 'Сума Зменшення рез за рахунок дисконту';
COMMENT ON COLUMN BARS.NBU23_REZ.NLS_REZ IS 'Рахунок для вiдобра~рез~NLS_REZ';
COMMENT ON COLUMN BARS.NBU23_REZ.NLS_REZN IS 'Рахунок для вiдобра~рез(нал)~NLS_REZN';




PROMPT *** Create  constraint PK_NBU23REZ_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBU23_REZ ADD CONSTRAINT PK_NBU23REZ_ID PRIMARY KEY (FDAT, ID, KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NBU23REZ_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NBU23REZ_ID ON BARS.NBU23_REZ (FDAT, ID, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I3_NBU23REZ ***
begin   
 execute immediate '
  CREATE INDEX BARS.I3_NBU23REZ ON BARS.NBU23_REZ (FDAT, RNK, ND, KAT, KV, RZ, DDD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I5_NBU23REZ ***
begin   
 execute immediate '
  CREATE INDEX BARS.I5_NBU23REZ ON BARS.NBU23_REZ (FDAT, ND, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I4_NBU23REZ ***
begin   
 execute immediate '
  CREATE INDEX BARS.I4_NBU23REZ ON BARS.NBU23_REZ (FDAT, ACC, ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBU23_REZ ***
grant SELECT                                                                 on NBU23_REZ       to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on NBU23_REZ       to BARSUPL;
grant INSERT,SELECT,UPDATE                                                   on NBU23_REZ       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBU23_REZ       to BARS_SUP;
grant SELECT                                                                 on NBU23_REZ       to CIG_LOADER;
grant SELECT                                                                 on NBU23_REZ       to RPBN002;
grant INSERT,SELECT,UPDATE                                                   on NBU23_REZ       to START1;
grant SELECT                                                                 on NBU23_REZ       to UPLD;



PROMPT *** Create SYNONYM  to NBU23_REZ ***

  CREATE OR REPLACE PUBLIC SYNONYM NBU23_REZ_P FOR BARS.NBU23_REZ;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBU23_REZ.sql =========*** End *** ===
PROMPT ===================================================================================== 
