

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_ACCC.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_ACCC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_ACCC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CP_ACCC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_ACCC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_ACCC ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_ACCC 
   (	VIDD NUMBER, 
	RYN NUMBER, 
	NLSA VARCHAR2(15), 
	NLSD VARCHAR2(15), 
	NLSP VARCHAR2(15), 
	NLSR VARCHAR2(15), 
	NLSS VARCHAR2(15), 
	NLSZ VARCHAR2(15), 
	NLSN1 VARCHAR2(15), 
	NLSN2 VARCHAR2(15), 
	NLSN3 VARCHAR2(15), 
	NLSN4 VARCHAR2(15), 
	NLSE VARCHAR2(15), 
	NLSG VARCHAR2(15), 
	NLSR2 VARCHAR2(15), 
	EMI NUMBER, 
	PF NUMBER, 
	IDB NUMBER, 
	NLSZF VARCHAR2(15), 
	NLS_FXP VARCHAR2(15), 
	NLSSN VARCHAR2(15), 
	NLS71 VARCHAR2(15), 
	S605 VARCHAR2(15), 
	S605P VARCHAR2(15), 
	NLS_PR VARCHAR2(15), 
	NLS_FXR VARCHAR2(15), 
	S2VD VARCHAR2(15), 
	S2VP VARCHAR2(15), 
	S2VD0 VARCHAR2(15), 
	S2VP0 VARCHAR2(15), 
	S2VD1 VARCHAR2(15), 
	S2VP1 VARCHAR2(15), 
	B4621R VARCHAR2(15), 
	S6499 VARCHAR2(15), 
	S7499 VARCHAR2(15), 
	NLSS5 VARCHAR2(15), 
	NLS_5040 VARCHAR2(15), 
	S2VD2 VARCHAR2(15), 
	S2VP2 VARCHAR2(15), 
	NLS_5040_2 VARCHAR2(15), 
	NLS_5040_3 VARCHAR2(15), 
	NLSEXPN VARCHAR2(15), 
	NLSEXPR VARCHAR2(15), 
	NLSR3 VARCHAR2(15), 
	NLS_1819 VARCHAR2(15), 
	NLS_1919 VARCHAR2(15), 
	UNREC VARCHAR2(15), 
	NLSFD VARCHAR2(15),
        D_Close date
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin EXECUTE IMMEDIATE 'alter table bars.CP_ACCC add ( D_Close date) ';
exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/





PROMPT *** ALTER_POLICIES to CP_ACCC ***
 exec bpa.alter_policies('CP_ACCC');


COMMENT ON TABLE BARS.CP_ACCC IS 'Справочник консолид.сч. ФУ пр ЦБ';
COMMENT ON COLUMN BARS.CP_ACCC.VIDD IS 'Вид учета (БС)';
COMMENT ON COLUMN BARS.CP_ACCC.RYN IS 'СубПортфель';
COMMENT ON COLUMN BARS.CP_ACCC.NLSA IS 'Cчет номинала';
COMMENT ON COLUMN BARS.CP_ACCC.NLSD IS 'Счет дисконта';
COMMENT ON COLUMN BARS.CP_ACCC.NLSP IS 'Cчет премии';
COMMENT ON COLUMN BARS.CP_ACCC.NLSR IS 'Счет начис. %';
COMMENT ON COLUMN BARS.CP_ACCC.NLSS IS 'Cчет переоценки';
COMMENT ON COLUMN BARS.CP_ACCC.NLSZ IS 'Счет резервного фонда';
COMMENT ON COLUMN BARS.CP_ACCC.NLSN1 IS 'Внеб.сч.9201-купл.,не получ.';
COMMENT ON COLUMN BARS.CP_ACCC.NLSN2 IS 'Внеб.сч.9219-активы до отправки';
COMMENT ON COLUMN BARS.CP_ACCC.NLSN3 IS 'Внеб.сч.9211-проданы,не отправл.';
COMMENT ON COLUMN BARS.CP_ACCC.NLSN4 IS 'Внеб.сч.9209-активы до получения';
COMMENT ON COLUMN BARS.CP_ACCC.NLSE IS 'Cчет эмиссии';
COMMENT ON COLUMN BARS.CP_ACCC.NLSG IS 'Счет торг.резудьтата';
COMMENT ON COLUMN BARS.CP_ACCC.NLSR2 IS 'Счет накоп. %';
COMMENT ON COLUMN BARS.CP_ACCC.EMI IS 'Вид эмитента';
COMMENT ON COLUMN BARS.CP_ACCC.PF IS 'Портфель';
COMMENT ON COLUMN BARS.CP_ACCC.IDB IS 'Код источника цены';
COMMENT ON COLUMN BARS.CP_ACCC.NLSZF IS 'Счет ....';
COMMENT ON COLUMN BARS.CP_ACCC.NLS_FXP IS 'Рах.FXP~НЕреалiз.рез~переоц';
COMMENT ON COLUMN BARS.CP_ACCC.NLSSN IS 'Рах.3811~для переоц.ПОЗАБАЛ';
COMMENT ON COLUMN BARS.CP_ACCC.NLS71 IS 'Рах.ком.~видаткiв';
COMMENT ON COLUMN BARS.CP_ACCC.S605 IS 'Рах.амортиз~Дисконту';
COMMENT ON COLUMN BARS.CP_ACCC.S605P IS 'Рах.амортиз~Премiї';
COMMENT ON COLUMN BARS.CP_ACCC.NLS_PR IS 'Рах.проц.~доходiв';
COMMENT ON COLUMN BARS.CP_ACCC.NLS_FXR IS 'Рах.FXR~РЕАЛIЗОВ.рез~переоц';
COMMENT ON COLUMN BARS.CP_ACCC.S2VD IS 'Сист.Счет виртуального Дисконта';
COMMENT ON COLUMN BARS.CP_ACCC.S2VP IS 'Сист.Счет виртуальной  Премии';
COMMENT ON COLUMN BARS.CP_ACCC.S2VD0 IS 'Сист.Счет создания вирт.Дисконта';
COMMENT ON COLUMN BARS.CP_ACCC.S2VP0 IS 'Сист.Счет создания вирт.Премии';
COMMENT ON COLUMN BARS.CP_ACCC.S2VD1 IS 'Сист.Счет амортиз. вирт.Дисконта';
COMMENT ON COLUMN BARS.CP_ACCC.S2VP1 IS 'Сист.Счет амортиз. вирт.Премии';
COMMENT ON COLUMN BARS.CP_ACCC.B4621R IS 'Транзитний рах-к';
COMMENT ON COLUMN BARS.CP_ACCC.S6499 IS 'Сч дох.6499 для слияния Р+В Д/П';
COMMENT ON COLUMN BARS.CP_ACCC.S7499 IS 'Сч расх.7499 для слияния Р+В Д/П';
COMMENT ON COLUMN BARS.CP_ACCC.NLSS5 IS 'НБУ.Род.счет 5121.';
COMMENT ON COLUMN BARS.CP_ACCC.NLS_5040 IS 'НБУ.Счет ФУ 5040. Используем при продаже';
COMMENT ON COLUMN BARS.CP_ACCC.S2VD2 IS 'Сист.Счет рез-та продажи вирт.Д/П';
COMMENT ON COLUMN BARS.CP_ACCC.S2VP2 IS 'Сист.Счет рез-та продажи вирт.Д/П';
COMMENT ON COLUMN BARS.CP_ACCC.NLS_5040_2 IS '5040/2.Положительный результат переоценки (6класс Кт) ';
COMMENT ON COLUMN BARS.CP_ACCC.NLS_5040_3 IS '5040/3.Отрицательный результат переоценки (6класс Дт)';
COMMENT ON COLUMN BARS.CP_ACCC.NLSEXPN IS 'Сч просрочки номинала';
COMMENT ON COLUMN BARS.CP_ACCC.NLSEXPR IS 'Сч просрочки купона';
COMMENT ON COLUMN BARS.CP_ACCC.NLSR3 IS 'Счет "кривого" накоп. %';
COMMENT ON COLUMN BARS.CP_ACCC.NLS_1819 IS 'Рах-к Деб. заборгованост_';
COMMENT ON COLUMN BARS.CP_ACCC.NLS_1919 IS 'Рах-к Кред. заборгованост_';
COMMENT ON COLUMN BARS.CP_ACCC.UNREC IS 'Сч невизнаних доходів';
COMMENT ON COLUMN BARS.CP_ACCC.NLSFD IS 'Сч ФинДебеторки для портфеля ФД(-3)';
COMMENT ON COLUMN BARS.CP_ACCC.D_Close IS 'Дата закр Суб.Портф';



PROMPT *** Create  constraint XPK_CP_ACCC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCC ADD CONSTRAINT XPK_CP_ACCC PRIMARY KEY (VIDD, EMI, PF, RYN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_ACCC_BYR ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCC ADD CONSTRAINT FK_CP_ACCC_BYR FOREIGN KEY (IDB)
	  REFERENCES BARS.CP_BYR (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005263 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCC MODIFY (VIDD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005264 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCC MODIFY (RYN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005265 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCC MODIFY (EMI NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005266 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCC MODIFY (PF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_ACCC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_ACCC ON BARS.CP_ACCC (VIDD, EMI, PF, RYN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin 
  EXECUTE IMMEDIATE 'alter table bars.CP_ACCC add (NLSRD VARCHAR2(15)) ';
  exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/
COMMENT ON COLUMN BARS.CP_ACCC.NLSRD IS 'Рах нарах. % дивідентів';

begin 
  EXECUTE IMMEDIATE 'alter table bars.CP_ACCC add (NLSRD_6 VARCHAR2(15)) ';
  exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/
COMMENT ON COLUMN BARS.CP_ACCC.NLSRD_6 IS 'Рах дох.6300 нарах. % дивідентів';

begin 
  EXECUTE IMMEDIATE 'alter table bars.CP_ACCC add (NLSS2 VARCHAR2(15)) ';
  exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/
COMMENT ON COLUMN BARS.CP_ACCC.NLSS2 IS 'Рах переоцінки по опціону';

begin 
  EXECUTE IMMEDIATE 'alter table bars.CP_ACCC add (NLSS2_6 VARCHAR2(15)) ';
  exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/
COMMENT ON COLUMN BARS.CP_ACCC.NLSS2_6 IS 'Рах 6 класу для переоцінки по опціону';

begin 
  EXECUTE IMMEDIATE 'alter table bars.CP_ACCC add (NLS_3620 VARCHAR2(15)) ';
  exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/
COMMENT ON COLUMN BARS.CP_ACCC.NLS_3620 IS 'Рах 3620 (при виплаті дивідентів)';

begin 
  EXECUTE IMMEDIATE 'alter table bars.CP_ACCC add (NLS_7419 VARCHAR2(15)) ';
  exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/
COMMENT ON COLUMN BARS.CP_ACCC.NLS_7419 IS 'Рах 7419 (при виплаті дивідентів)';

begin 
  EXECUTE IMMEDIATE 'alter table bars.CP_ACCC add (NLS_7500 VARCHAR2(15)) ';
  exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/
COMMENT ON COLUMN BARS.CP_ACCC.NLS_7419 IS 'Рах 7500 (при виплаті дивідентів)';

begin 
  EXECUTE IMMEDIATE 'alter table bars.CP_ACCC add (NLS_7503 VARCHAR2(15)) ';
  exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/
COMMENT ON COLUMN BARS.CP_ACCC.NLS_7419 IS 'Рах 7503 (при виплаті дивідентів)';


PROMPT *** Create  grants  CP_ACCC ***
grant SELECT                                                                 on CP_ACCC         to BARSUPL;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CP_ACCC         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_ACCC         to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CP_ACCC         to CP_ROLE;
grant SELECT                                                                 on CP_ACCC         to RPBN001;
grant SELECT                                                                 on CP_ACCC         to UPLD;
grant FLASHBACK,SELECT                                                       on CP_ACCC         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_ACCC.sql =========*** End *** =====
PROMPT ===================================================================================== 
