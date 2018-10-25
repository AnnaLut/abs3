

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_CR.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_CR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_CR'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''REZ_CR'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_CR ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_CR 
   (	FDAT DATE, 
	RNK NUMBER(*,0), 
	CUSTTYPE NUMBER(1,0), 
	ACC NUMBER(*,0), 
	KV NUMBER(3,0), 
	NBS VARCHAR2(4), 
	TIP CHAR(3), 
	NLS VARCHAR2(15), 
	ND NUMBER, 
	VIDD NUMBER(*,0), 
	FIN NUMBER(*,0), 
	FINP NUMBER(*,0), 
	FINV NUMBER(*,0), 
	VKR VARCHAR2(3), 
	BV NUMBER, 
	BVQ NUMBER, 
	BV02 NUMBER, 
	BV02Q NUMBER, 
	EAD NUMBER, 
	EADQ NUMBER, 
	IDF NUMBER(*,0), 
	PD NUMBER, 
	CR NUMBER, 
	CRQ NUMBER, 
	CR_LGD NUMBER, 
	KOL NUMBER, 
	FIN23 NUMBER, 
	CCF NUMBER, 
	PAWN NUMBER(*,0), 
	TIP_ZAL NUMBER(*,0), 
	KPZ NUMBER, 
	KL_351 NUMBER, 
	ZAL NUMBER, 
	ZALQ NUMBER, 
	ZAL_BV NUMBER, 
	ZAL_BVQ NUMBER, 
	LGD NUMBER, 
	RZ NUMBER, 
	TEXT VARCHAR2(250), 
	NMK VARCHAR2(70), 
	PRINSIDER NUMBER(*,0), 
	COUNTRY NUMBER(3,0), 
	ISE CHAR(5), 
	SDATE DATE, 
	DATE_V DATE, 
	WDATE DATE, 
	S250 NUMBER, 
	ISTVAL NUMBER(1,0), 
	RC NUMBER, 
	RCQ NUMBER, 
	FAKTOR NUMBER, 
	K_FAKTOR NUMBER, 
	K_DEFOLT NUMBER, 
	DV NUMBER, 
	FIN_KOR NUMBER(*,0), 
	TIPA NUMBER(*,0), 
	OVKR VARCHAR2(50), 
	P_DEF VARCHAR2(50), 
	OVD VARCHAR2(50), 
	OPD VARCHAR2(50), 
	KOL23 VARCHAR2(500), 
	KOL24 VARCHAR2(500), 
	KOL25 VARCHAR2(500), 
	KOL26 VARCHAR2(500), 
	KOL27 VARCHAR2(500), 
	KOL28 VARCHAR2(500), 
	KOL29 VARCHAR2(500), 
	FIN_Z NUMBER(*,0), 
	PD_0 NUMBER(*,0), 
	CC_ID VARCHAR2(50), 
	KOL17 VARCHAR2(50), 
	KOL31 VARCHAR2(100), 
	S180 VARCHAR2(1), 
	T4 NUMBER(1,0), 
	RPB NUMBER, 
	GRP NUMBER(*,0), 
	OB22 CHAR(2), 
	KOL30 VARCHAR2(500), 
	S080 VARCHAR2(1), 
	S080_Z VARCHAR2(1), 
	TIP_FIN NUMBER(*,0), 
	DDD_6B CHAR(3), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	LGD_LONG NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_CR ***
 exec bpa.alter_policies('REZ_CR');


COMMENT ON TABLE BARS.REZ_CR IS 'Кредитний ризик за активними банківськими операціями';
COMMENT ON COLUMN BARS.REZ_CR.LGD_LONG IS '';
COMMENT ON COLUMN BARS.REZ_CR.FDAT IS 'Звітна дата';
COMMENT ON COLUMN BARS.REZ_CR.RNK IS 'Код (номер) контрагента';
COMMENT ON COLUMN BARS.REZ_CR.CUSTTYPE IS 'Тип контрагента';
COMMENT ON COLUMN BARS.REZ_CR.ACC IS 'Вн. номер рах.';
COMMENT ON COLUMN BARS.REZ_CR.KV IS 'Код валюти';
COMMENT ON COLUMN BARS.REZ_CR.NBS IS 'Бал. рахунок';
COMMENT ON COLUMN BARS.REZ_CR.TIP IS 'Тип рахунку';
COMMENT ON COLUMN BARS.REZ_CR.NLS IS 'Номер рахунку';
COMMENT ON COLUMN BARS.REZ_CR.ND IS 'Номер договору';
COMMENT ON COLUMN BARS.REZ_CR.VIDD IS 'Вид договору';
COMMENT ON COLUMN BARS.REZ_CR.FIN IS 'PD :Клас боржника, визначений на підставі оцінки фінансового стану';
COMMENT ON COLUMN BARS.REZ_CR.FINP IS '';
COMMENT ON COLUMN BARS.REZ_CR.FINV IS '';
COMMENT ON COLUMN BARS.REZ_CR.VKR IS 'Внутренний кредитный рейтинг';
COMMENT ON COLUMN BARS.REZ_CR.BV IS 'BV - Балансова вартість (ном.)-SNA-SDI';
COMMENT ON COLUMN BARS.REZ_CR.BVQ IS 'BV - Балансова вартість (екв.)-SNA-SDI';
COMMENT ON COLUMN BARS.REZ_CR.BV02 IS 'BV - Балансова вартість (ном.)по балансу';
COMMENT ON COLUMN BARS.REZ_CR.BV02Q IS 'BV - Балансова вартість (екв.)по балансу';
COMMENT ON COLUMN BARS.REZ_CR.EAD IS '(BV - SNA) - EAD(ном.) Експозиція під риз-ком(EAD за акт.операц.,крім над.фін.зобов"язань/EAD*CCF за над. фін-вими зобов.) на дату оцінки';
COMMENT ON COLUMN BARS.REZ_CR.EADQ IS '(BVQ- SNAQ)- EAD(екв.) Експозиція під риз-ком(EAD за акт.операц.,крім над.фін.зобов"язань/EAD*CCF за над. фін-вими зобов.) на дату оцінки';
COMMENT ON COLUMN BARS.REZ_CR.IDF IS 'Тип для определения PD';
COMMENT ON COLUMN BARS.REZ_CR.PD IS 'PD :Значення коефіцієнта PD, застосоване для визначення кредитного ризику';
COMMENT ON COLUMN BARS.REZ_CR.CR IS 'CR :Резерв (ном.) - розмір кредитного ризику за активом';
COMMENT ON COLUMN BARS.REZ_CR.CRQ IS 'CR :Резерв (екв.) - розмір кредитного ризику за активом';
COMMENT ON COLUMN BARS.REZ_CR.CR_LGD IS '';
COMMENT ON COLUMN BARS.REZ_CR.KOL IS '';
COMMENT ON COLUMN BARS.REZ_CR.FIN23 IS '';
COMMENT ON COLUMN BARS.REZ_CR.CCF IS '';
COMMENT ON COLUMN BARS.REZ_CR.PAWN IS 'LGD:Код виду забезпе-чення';
COMMENT ON COLUMN BARS.REZ_CR.TIP_ZAL IS 'LGD:Тип забезпе-чення';
COMMENT ON COLUMN BARS.REZ_CR.KPZ IS 'LGD:Коефіцієнт покриття забезпеченням';
COMMENT ON COLUMN BARS.REZ_CR.KL_351 IS 'Коефіцієнт ліквідності забезпечення';
COMMENT ON COLUMN BARS.REZ_CR.ZAL IS 'LGD:Сума забез-печення (CV*k) ном.';
COMMENT ON COLUMN BARS.REZ_CR.ZALQ IS 'LGD:Сума забез-печення (CV*k) екв.';
COMMENT ON COLUMN BARS.REZ_CR.ZAL_BV IS 'LGD:Сума забез-печення (CV) ном.';
COMMENT ON COLUMN BARS.REZ_CR.ZAL_BVQ IS 'LGD:Сума забез-печення (CV) екв.';
COMMENT ON COLUMN BARS.REZ_CR.LGD IS 'LGD:Значення коефіцієнта LGD (1-RR)';
COMMENT ON COLUMN BARS.REZ_CR.RZ IS '';
COMMENT ON COLUMN BARS.REZ_CR.TEXT IS '';
COMMENT ON COLUMN BARS.REZ_CR.NMK IS 'Наймену-вання контрагента';
COMMENT ON COLUMN BARS.REZ_CR.PRINSIDER IS 'Код типу пов"язаної з банком особи';
COMMENT ON COLUMN BARS.REZ_CR.COUNTRY IS 'Код країни контра-гента';
COMMENT ON COLUMN BARS.REZ_CR.ISE IS 'Код інститу-ційного сектора економіки';
COMMENT ON COLUMN BARS.REZ_CR.SDATE IS 'Дата договору';
COMMENT ON COLUMN BARS.REZ_CR.DATE_V IS 'Дата виникнення боргу/наданих фінансових зобов"язань';
COMMENT ON COLUMN BARS.REZ_CR.WDATE IS 'Дата погашення боргу/наданих фінансових зобов"язань';
COMMENT ON COLUMN BARS.REZ_CR.S250 IS '';
COMMENT ON COLUMN BARS.REZ_CR.ISTVAL IS '';
COMMENT ON COLUMN BARS.REZ_CR.RC IS 'LGD:Інші надход-ження  (RС)';
COMMENT ON COLUMN BARS.REZ_CR.RCQ IS '';
COMMENT ON COLUMN BARS.REZ_CR.FAKTOR IS 'PD :Інформація про наявність факторів, які потребують коригування класу боржника';
COMMENT ON COLUMN BARS.REZ_CR.K_FAKTOR IS 'PD :Код фактору, на підставі якого скоригований клас боржника';
COMMENT ON COLUMN BARS.REZ_CR.K_DEFOLT IS 'PD :Код ознаки дефолту боржника щодо якої банк довів відсутність дефолту';
COMMENT ON COLUMN BARS.REZ_CR.DV IS '';
COMMENT ON COLUMN BARS.REZ_CR.FIN_KOR IS 'PD :Клас боржника з урахуванням коригуючих факторів, що застосований для визначення кредитного ризику';
COMMENT ON COLUMN BARS.REZ_CR.TIPA IS 'Тип актива';
COMMENT ON COLUMN BARS.REZ_CR.OVKR IS '';
COMMENT ON COLUMN BARS.REZ_CR.P_DEF IS '';
COMMENT ON COLUMN BARS.REZ_CR.OVD IS '';
COMMENT ON COLUMN BARS.REZ_CR.OPD IS '';
COMMENT ON COLUMN BARS.REZ_CR.KOL23 IS '';
COMMENT ON COLUMN BARS.REZ_CR.KOL24 IS '';
COMMENT ON COLUMN BARS.REZ_CR.KOL25 IS '';
COMMENT ON COLUMN BARS.REZ_CR.KOL26 IS '';
COMMENT ON COLUMN BARS.REZ_CR.KOL27 IS '';
COMMENT ON COLUMN BARS.REZ_CR.KOL28 IS '';
COMMENT ON COLUMN BARS.REZ_CR.KOL29 IS '';
COMMENT ON COLUMN BARS.REZ_CR.FIN_Z IS '';
COMMENT ON COLUMN BARS.REZ_CR.PD_0 IS '';
COMMENT ON COLUMN BARS.REZ_CR.CC_ID IS '';
COMMENT ON COLUMN BARS.REZ_CR.KOL17 IS '';
COMMENT ON COLUMN BARS.REZ_CR.KOL31 IS '';
COMMENT ON COLUMN BARS.REZ_CR.S180 IS '';
COMMENT ON COLUMN BARS.REZ_CR.T4 IS '';
COMMENT ON COLUMN BARS.REZ_CR.RPB IS 'Група фінансових активів';
COMMENT ON COLUMN BARS.REZ_CR.GRP IS '';
COMMENT ON COLUMN BARS.REZ_CR.OB22 IS 'ОБ22 рахунку';
COMMENT ON COLUMN BARS.REZ_CR.KOL30 IS '';
COMMENT ON COLUMN BARS.REZ_CR.S080 IS 'Параметр Фин.класа по FIN_351';
COMMENT ON COLUMN BARS.REZ_CR.S080_Z IS 'Параметр Фин.класа по FIN_Z';
COMMENT ON COLUMN BARS.REZ_CR.TIP_FIN IS 'Тип Фин.класу: 0 -> 1-2, 1 -> 1-5, 2 -> 1-10';
COMMENT ON COLUMN BARS.REZ_CR.DDD_6B IS 'DDD из kl_f3_29 по kf="6B"';
COMMENT ON COLUMN BARS.REZ_CR.KF IS '';




PROMPT *** Create  constraint FK_REZCR_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_CR ADD CONSTRAINT FK_REZCR_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REZCR_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_CR MODIFY (KF CONSTRAINT CC_REZCR_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_REZ_CR_FDAT_RNK ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_REZ_CR_FDAT_RNK ON BARS.REZ_CR (FDAT, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I3_REZ_CR_FDAT_ND ***
begin   
 execute immediate '
  CREATE INDEX BARS.I3_REZ_CR_FDAT_ND ON BARS.REZ_CR (FDAT, ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index I1_REZ_CR_FDAT_ACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_REZ_CR_FDAT_ACC ON BARS.REZ_CR (FDAT, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin
 execute immediate   'alter table REZ_CR add (z_grp number) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN REZ_CR.Z_GRP  IS 'інтегральний показник групи';

begin
 execute immediate   'alter table REZ_CR add (FIN_GRP number) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN REZ_CR.FIN_GRP  IS 'Клас групи, визначений на підставі оцінки фінансового стану';

begin
 execute immediate   'alter table REZ_CR add (FIN_GRP_KOR number) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN REZ_CR.FIN_GRP_KOR  IS 'скоригований клас групи';

begin
 execute immediate   'alter table REZ_CR add (FIN_RNK_KOR number) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN REZ_CR.FIN_RNK_KOR  IS 'скоригований клас контрагента, який належить до групи пов"язаних контрагентів';

begin
 execute immediate   'alter table REZ_CR add (FIN_RNK number) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN REZ_CR.FIN_RNK  IS 'клас контрагента, який належить до групи пов"язаних контрагентів';

begin
 execute immediate   'alter table REZ_CR add (oz_165_not VARCHAR2(500)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN REZ_CR.oz_165_not  IS 'порядковий номер ознак п. 165 Положення №351 за останнім припиненням визнання дефолту за подіями, визначеними в п. 165 за якими не має винятків';

begin
 execute immediate   'alter table REZ_CR add (Dat_165_not date) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN REZ_CR.Dat_165_not  IS 'дата останнього припинення визнання дефолту ';

begin
 execute immediate   'alter table REZ_CR add (oz_166_not VARCHAR2(500)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN REZ_CR.oz_166_not  IS 'порядковий номер ознак п. 166 Положення №351 за останнім припиненням визнання дефолту за подіями, визначеними в п. 166 за якими не має винятків';

begin
 execute immediate   'alter table REZ_CR add (Dat_166_not date) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN REZ_CR.Dat_166_not  IS 'дата останнього припинення визнання дефолту ';

begin
 execute immediate   'alter table REZ_CR add (oz_165 VARCHAR2(500)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN REZ_CR.oz_165  IS 'порядковий номер ознак п. 165 Положення №351 за останнім припиненням визнання дефолту за подіями, визначеними в п. 165 за якими є виняткі';

begin
 execute immediate   'alter table REZ_CR add (Dat_165 date) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN REZ_CR.Dat_165_not  IS 'дата останнього припинення визнання дефолту ';

begin
 execute immediate   'alter table REZ_CR add (POCI number) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN REZ_CR.POCI  IS 'Признак POCI: 1-Так, 0-Ні ';

begin
 execute immediate   'alter table REZ_CR add (OKPO varchar2(14)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN REZ_CR.OKPO  IS 'ОКПО';

PROMPT *** Create  index I4_REZ_CR_FDAT_OKPO ***
begin   
 execute immediate '
  CREATE INDEX BARS.I4_REZ_CR_FDAT_OKPO ON BARS.REZ_CR (FDAT, OKPO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  REZ_CR ***
grant SELECT                                                                 on REZ_CR          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REZ_CR          to RCC_DEAL;
grant SELECT                                                                 on REZ_CR          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_CR.sql =========*** End *** ======
PROMPT ===================================================================================== 
