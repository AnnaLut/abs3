

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/DOC_IMPORT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  table DOC_IMPORT ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.DOC_IMPORT 
   (	EXT_REF VARCHAR2(40), 
	REF NUMBER, 
	TT CHAR(3), 
	ND VARCHAR2(10), 
	VOB NUMBER, 
	VDAT DATE, 
	DATD DATE, 
	DATP DATE, 
	DK NUMBER, 
	KV NUMBER, 
	S NUMBER, 
	KV2 NUMBER, 
	S2 NUMBER, 
	SQ NUMBER, 
	SK NUMBER, 
	MFO_A VARCHAR2(6), 
	NAM_A VARCHAR2(38), 
	NLS_A VARCHAR2(14), 
	ID_A VARCHAR2(10), 
	MFO_B VARCHAR2(6), 
	NAM_B VARCHAR2(38), 
	NLS_B VARCHAR2(14), 
	ID_B VARCHAR2(10), 
	NAZN VARCHAR2(160), 
	USERID NUMBER, 
	ID_O VARCHAR2(6), 
	SIGN RAW(256), 
	INSERTION_DATE DATE DEFAULT sysdate, 
	VERIFICATION_FLAG VARCHAR2(1), 
	VERIFICATION_ERR_CODE NUMBER, 
	VERIFICATION_ERR_MSG VARCHAR2(4000), 
	VERIFICATION_DATE DATE, 
	CONFIRMATION_FLAG VARCHAR2(1), 
	CONFIRMATION_DATE DATE, 
	BOOKING_FLAG VARCHAR2(1), 
	BOOKING_ERR_CODE NUMBER, 
	BOOKING_ERR_MSG VARCHAR2(4000), 
	BOOKING_DATE DATE, 
	REMOVAL_FLAG VARCHAR2(1), 
	REMOVAL_DATE DATE, 
	IGNORE_ERR_CODE NUMBER(*,0), 
	IGNORE_ERR_MSG VARCHAR2(4000), 
	IGNORE_COUNT NUMBER(*,0), 
	IGNORE_DATE DATE, 
	PRTY NUMBER(*,0), 
	NOTIFICATION_FLAG VARCHAR2(1), 
	NOTIFICATION_DATE DATE, 
	SYSTEM_ERR_CODE NUMBER(*,0), 
	SYSTEM_ERR_MSG VARCHAR2(4000), 
	SYSTEM_ERR_DATE DATE,
        FLG_AUTO_PAY  smallint
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.DOC_IMPORT IS 'Документы для импорта в АБС';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.EXT_REF IS 'External Reference';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.REF IS 'Референс документа в АБС';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.TT IS 'Код операции';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.ND IS 'Операционный номер документа';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.VOB IS 'Вид документа';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.VDAT IS 'Дата валютирования';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.DATD IS 'Дата документа';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.DATP IS 'Дата поступления документа в банк';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.DK IS 'Признак дебет/кредит:
0 - прямое списание(direct debit),
1 - кредитовый документ,
2 - информационный запрос,
3 - информационное сообщение';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.KV IS 'Код валюты А';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.S IS 'Сумма А';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.KV2 IS 'Код валюты Б';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.S2 IS 'Сумма Б';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.SQ IS 'Эквивалент суммы А';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.SK IS 'Символ кассового плана';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.MFO_A IS 'Код банка плательщика(МФО)';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.NAM_A IS 'Наименование плательщика';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.NLS_A IS 'Счет плательщика';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.ID_A IS 'Идент. код плательщика';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.MFO_B IS 'Код банка получателя(МФО)';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.NAM_B IS 'Наименование получателя';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.NLS_B IS 'Счет получателя';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.ID_B IS 'Идент. код получателя';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.NAZN IS 'Назначение платежа';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.USERID IS 'ID пользователя - исполнителя';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.ID_O IS 'Идентификатор ключа операциониста';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.SIGN IS 'ЭЦП документа на внутреннем буффере';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.INSERTION_DATE IS 'Дата вставки документа';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.VERIFICATION_FLAG IS 'Флаг верификации';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.VERIFICATION_ERR_CODE IS 'Код ошибки при верификации';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.VERIFICATION_ERR_MSG IS 'Сообщение об ошибке при верификации';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.VERIFICATION_DATE IS 'Дата верификации';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.CONFIRMATION_FLAG IS 'Флаг подтверждения оплаты документа';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.CONFIRMATION_DATE IS 'Дата подтверждения оплаты';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.BOOKING_FLAG IS 'Флаг плановой оплаты';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.BOOKING_ERR_CODE IS 'Код ошибки плановой оплаты';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.BOOKING_ERR_MSG IS 'Сообщение об ошибке при плановой оплате';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.BOOKING_DATE IS 'Дата плановой оплаты';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.REMOVAL_FLAG IS 'Флаг пометки на удаление';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.REMOVAL_DATE IS 'Дата после которой документ необходимо удалить';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.IGNORE_ERR_CODE IS 'Код ошибки, который мы игнорируем';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.IGNORE_ERR_MSG IS 'Сообщение об ошибке';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.IGNORE_COUNT IS 'Кол-во попыток с игнорированием ошибки';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.IGNORE_DATE IS 'Дата возникновения ошибки, которую проигнорировали';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.PRTY IS '';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.NOTIFICATION_FLAG IS 'Флаг уведомления Интернет-банкинга об оплате(удачной или нет) док-та';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.NOTIFICATION_DATE IS 'Дата уведомления Интернет-банкинга об оплате(удачной или нет) док-та';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.SYSTEM_ERR_CODE IS 'Системный код ошибки при оплате';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.SYSTEM_ERR_MSG IS 'Описание системной ошибки при оплате';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT.SYSTEM_ERR_DATE IS 'Дата возникновения системной ошибки';



begin   
   execute immediate 'alter table barsaq.doc_import add flg_auto_pay smallint';
exception when others then
  if  sqlcode=-1430 or  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_VRFL ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT ADD CONSTRAINT CC_DOCIMPORT_VRFL CHECK (verification_flag in (''Y'',''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT *** Create  constraint CC_DOCIMPORT_CFFL ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT ADD CONSTRAINT CC_DOCIMPORT_CFFL CHECK (confirmation_flag=''Y'') ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_BKFL ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT ADD CONSTRAINT CC_DOCIMPORT_BKFL CHECK (booking_flag in (''Y'',''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_RMFL ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT ADD CONSTRAINT CC_DOCIMPORT_RMFL CHECK (removal_flag=''Y'') ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DOCIMPORT ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT ADD CONSTRAINT PK_DOCIMPORT PRIMARY KEY (EXT_REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_NOTIFFLAG_CC ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT ADD CONSTRAINT CC_DOCIMPORT_NOTIFFLAG_CC CHECK (notification_flag=''Y'') ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_EXTREF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (EXT_REF CONSTRAINT CC_DOCIMPORT_EXTREF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (TT CONSTRAINT CC_DOCIMPORT_TT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_DK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (DK CONSTRAINT CC_DOCIMPORT_DK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (KV CONSTRAINT CC_DOCIMPORT_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_S_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (S CONSTRAINT CC_DOCIMPORT_S_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_MFOA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (MFO_A CONSTRAINT CC_DOCIMPORT_MFOA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_NAMA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (NAM_A CONSTRAINT CC_DOCIMPORT_NAMA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_NLSA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (NLS_A CONSTRAINT CC_DOCIMPORT_NLSA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_IDA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (ID_A CONSTRAINT CC_DOCIMPORT_IDA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_MFOB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (MFO_B CONSTRAINT CC_DOCIMPORT_MFOB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_NAMB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (NAM_B CONSTRAINT CC_DOCIMPORT_NAMB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_NLSB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (NLS_B CONSTRAINT CC_DOCIMPORT_NLSB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_IDB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (ID_B CONSTRAINT CC_DOCIMPORT_IDB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_NAZN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (NAZN CONSTRAINT CC_DOCIMPORT_NAZN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (USERID CONSTRAINT CC_DOCIMPORT_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORT_INSDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT MODIFY (INSERTION_DATE CONSTRAINT CC_DOCIMPORT_INSDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_DOCIMPORT_PAY ***
begin   
 execute immediate '
  CREATE INDEX BARSAQ.I_DOCIMPORT_PAY ON BARSAQ.DOC_IMPORT (CASE  WHEN (CONFIRMATION_FLAG=''Y'' AND BOOKING_FLAG IS NULL AND REMOVAL_FLAG IS NULL) THEN ''Y'' ELSE NULL END ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_DOCIMPORT_NOTIFREQ ***
begin   
 execute immediate '
  CREATE INDEX BARSAQ.I_DOCIMPORT_NOTIFREQ ON BARSAQ.DOC_IMPORT (CASE  WHEN (BOOKING_FLAG IS NOT NULL AND NOTIFICATION_FLAG IS NULL) THEN ''Y'' ELSE NULL END ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DOCIMPORT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_DOCIMPORT ON BARSAQ.DOC_IMPORT (EXT_REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_DOCIMPORT_RM ***
begin   
 execute immediate '
  CREATE INDEX BARSAQ.I_DOCIMPORT_RM ON BARSAQ.DOC_IMPORT (REMOVAL_FLAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_DOCIMPORT_INSDATE ***
begin   
 execute immediate '
  CREATE INDEX BARSAQ.I_DOCIMPORT_INSDATE ON BARSAQ.DOC_IMPORT (INSERTION_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_DOCIMPORT_REF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.I_DOCIMPORT_REF ON BARSAQ.DOC_IMPORT (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



COMMENT ON COLUMN BARSAQ.DOC_IMPORT.FLG_AUTO_PAY IS '=1 - оплачивать автоматом вертушкой без проходжения ручных виз, =0 - ручная оплата';


PROMPT *** Create  grants  DOC_IMPORT ***
grant SELECT                                                                 on DOC_IMPORT      to BARS with grant option;
grant SELECT                                                                 on DOC_IMPORT      to BARSREADER_ROLE;
grant SELECT                                                                 on DOC_IMPORT      to BARS_ACCESS_DEFROLE;
grant INSERT,SELECT                                                          on DOC_IMPORT      to REFSYNC_USR;
grant SELECT                                                                 on DOC_IMPORT      to START1;
grant SELECT                                                                 on DOC_IMPORT      to WR_REFREAD;



PROMPT *** Create SYNONYM  to DOC_IMPORT ***

  CREATE OR REPLACE SYNONYM BARS.DOC_IMPORT FOR BARSAQ.DOC_IMPORT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/DOC_IMPORT.sql =========*** End *** 
PROMPT ===================================================================================== 
