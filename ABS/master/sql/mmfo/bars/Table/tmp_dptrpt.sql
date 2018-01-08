

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_DPTRPT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_DPTRPT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_DPTRPT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_DPTRPT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_DPTRPT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_DPTRPT ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_DPTRPT 
   (	RECID NUMBER(38,0), 
	CODE NUMBER(38,0), 
	DPTID NUMBER(38,0), 
	DPTNUM VARCHAR2(35), 
	DPTDAT DATE, 
	DATBEG DATE, 
	DATEND DATE, 
	DEPACCNUM VARCHAR2(15), 
	DEPACCNAME VARCHAR2(70), 
	INTACCNUM VARCHAR2(15), 
	INTACCNAME VARCHAR2(70), 
	CURID NUMBER(3,0), 
	CURCODE CHAR(3), 
	CURNAME VARCHAR2(35), 
	TYPEID NUMBER(38,0), 
	TYPENAME VARCHAR2(50), 
	CUSTID NUMBER(38,0), 
	CUSTNAME VARCHAR2(70), 
	DOCTYPE CHAR(3), 
	ISAL_GEN NUMBER(38,0), 
	OSAL_GEN NUMBER(38,0), 
	FDAT DATE, 
	PDAT DATE, 
	ISAL_DAT NUMBER(38,0), 
	OSAL_DAT NUMBER(38,0), 
	DOCREF NUMBER(38,0), 
	DOCNUM VARCHAR2(10), 
	DOCTT CHAR(3), 
	DOCDK NUMBER(1,0), 
	DOCSUM NUMBER(24,0), 
	DOCSK NUMBER(2,0), 
	DOCUSER NUMBER(38,0), 
	DOCDTL VARCHAR2(160), 
	CORRMFO VARCHAR2(12), 
	CORRACC VARCHAR2(15), 
	CORRNAME VARCHAR2(38), 
	CORRCODE VARCHAR2(14), 
	USERID NUMBER(38,0), 
	USERNAME VARCHAR2(60), 
	BRN4ID VARCHAR2(30), 
	BRN4NAME VARCHAR2(70)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_DPTRPT ***
 exec bpa.alter_policies('TMP_DPTRPT');


COMMENT ON TABLE BARS.TMP_DPTRPT IS 'Врем.таблица для выписок по вкладам физ.лиц';
COMMENT ON COLUMN BARS.TMP_DPTRPT.RECID IS 'Идентификатор записи';
COMMENT ON COLUMN BARS.TMP_DPTRPT.CODE IS 'Код отчета';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DPTID IS 'Референс договора';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DPTNUM IS 'Номер договора';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DPTDAT IS 'Дата договора';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DATBEG IS 'Дата начала договора';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DATEND IS 'Дата окончания договора';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DEPACCNUM IS 'Номер депозитного счета';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DEPACCNAME IS 'Название депозитного счета';
COMMENT ON COLUMN BARS.TMP_DPTRPT.INTACCNUM IS 'Номер процентного счета';
COMMENT ON COLUMN BARS.TMP_DPTRPT.INTACCNAME IS 'Название процентного счета';
COMMENT ON COLUMN BARS.TMP_DPTRPT.CURID IS 'Числ.код валюты';
COMMENT ON COLUMN BARS.TMP_DPTRPT.CURCODE IS 'Симв.код валюты';
COMMENT ON COLUMN BARS.TMP_DPTRPT.CURNAME IS 'Название валюты';
COMMENT ON COLUMN BARS.TMP_DPTRPT.TYPEID IS 'Код типа договора';
COMMENT ON COLUMN BARS.TMP_DPTRPT.TYPENAME IS 'Название типа договора';
COMMENT ON COLUMN BARS.TMP_DPTRPT.CUSTID IS 'Регистр.номер клиента';
COMMENT ON COLUMN BARS.TMP_DPTRPT.CUSTNAME IS 'Наименование клиента';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DOCTYPE IS 'Тип счета: DEN/INT';
COMMENT ON COLUMN BARS.TMP_DPTRPT.ISAL_GEN IS 'Вход.остаток на отчетный период';
COMMENT ON COLUMN BARS.TMP_DPTRPT.OSAL_GEN IS 'Исх.остаток на отчетный период';
COMMENT ON COLUMN BARS.TMP_DPTRPT.FDAT IS 'Дата движения';
COMMENT ON COLUMN BARS.TMP_DPTRPT.PDAT IS 'Дата пред.движения';
COMMENT ON COLUMN BARS.TMP_DPTRPT.ISAL_DAT IS 'Вход.остаток на дату движения';
COMMENT ON COLUMN BARS.TMP_DPTRPT.OSAL_DAT IS 'Исх.остаток на дату движения';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DOCREF IS 'Референс документа';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DOCNUM IS 'Номер документа';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DOCTT IS 'Код операции';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DOCDK IS 'Тип операции';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DOCSUM IS 'Сумма документа';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DOCSK IS 'Символ кассплана';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DOCUSER IS 'Код исполнителя';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DOCDTL IS 'Назначение платежа';
COMMENT ON COLUMN BARS.TMP_DPTRPT.CORRMFO IS 'МФО корреспондента';
COMMENT ON COLUMN BARS.TMP_DPTRPT.CORRACC IS 'Счет корреспондента';
COMMENT ON COLUMN BARS.TMP_DPTRPT.CORRNAME IS 'Наименование корреспондента';
COMMENT ON COLUMN BARS.TMP_DPTRPT.CORRCODE IS 'Идентиф.код корреспондента';
COMMENT ON COLUMN BARS.TMP_DPTRPT.USERID IS 'Код ответ.исп.по договору';
COMMENT ON COLUMN BARS.TMP_DPTRPT.USERNAME IS 'ФИО ответ.исп.по договору';
COMMENT ON COLUMN BARS.TMP_DPTRPT.BRN4ID IS 'Код подразделения банка';
COMMENT ON COLUMN BARS.TMP_DPTRPT.BRN4NAME IS 'Наименование подразделения банка';




PROMPT *** Create  constraint PK_TMPDPTRPT ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT ADD CONSTRAINT PK_TMPDPTRPT PRIMARY KEY (RECID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_DPTNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (DPTNUM CONSTRAINT CC_TMPDPTRPT_DPTNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_DPTDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (DPTDAT CONSTRAINT CC_TMPDPTRPT_DPTDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_DATBEG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (DATBEG CONSTRAINT CC_TMPDPTRPT_DATBEG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_DEPACCNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (DEPACCNUM CONSTRAINT CC_TMPDPTRPT_DEPACCNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_DEPACCNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (DEPACCNAME CONSTRAINT CC_TMPDPTRPT_DEPACCNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_INTACCNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (INTACCNUM CONSTRAINT CC_TMPDPTRPT_INTACCNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_INTACCNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (INTACCNAME CONSTRAINT CC_TMPDPTRPT_INTACCNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_CURID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (CURID CONSTRAINT CC_TMPDPTRPT_CURID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_CURCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (CURCODE CONSTRAINT CC_TMPDPTRPT_CURCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_CURNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (CURNAME CONSTRAINT CC_TMPDPTRPT_CURNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (TYPEID CONSTRAINT CC_TMPDPTRPT_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_TYPENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (TYPENAME CONSTRAINT CC_TMPDPTRPT_TYPENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_CUSTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (CUSTID CONSTRAINT CC_TMPDPTRPT_CUSTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_CUSTNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (CUSTNAME CONSTRAINT CC_TMPDPTRPT_CUSTNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_DOCTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (DOCTYPE CONSTRAINT CC_TMPDPTRPT_DOCTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_RECID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (RECID CONSTRAINT CC_TMPDPTRPT_RECID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (CODE CONSTRAINT CC_TMPDPTRPT_CODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_DPTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (DPTID CONSTRAINT CC_TMPDPTRPT_DPTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMPDPTRPT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMPDPTRPT ON BARS.TMP_DPTRPT (RECID) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_DPTRPT ***
grant SELECT                                                                 on TMP_DPTRPT      to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on TMP_DPTRPT      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_DPTRPT      to RPBN001;
grant SELECT                                                                 on TMP_DPTRPT      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_DPTRPT      to WR_ALL_RIGHTS;
grant SELECT                                                                 on TMP_DPTRPT      to WR_CREPORTS;



PROMPT *** Create SYNONYM  to TMP_DPTRPT ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_DPTRPT FOR BARS.TMP_DPTRPT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_DPTRPT.sql =========*** End *** ==
PROMPT ===================================================================================== 
