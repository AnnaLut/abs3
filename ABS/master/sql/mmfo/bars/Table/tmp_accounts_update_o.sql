

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ACCOUNTS_UPDATE_O.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ACCOUNTS_UPDATE_O ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ACCOUNTS_UPDATE_O ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ACCOUNTS_UPDATE_O 
   (	ACC NUMBER(38,0), 
	NLS VARCHAR2(15), 
	NLSALT VARCHAR2(15), 
	KV NUMBER(3,0), 
	NBS CHAR(4), 
	NBS2 CHAR(4), 
	DAOS DATE, 
	ISP NUMBER(38,0), 
	NMS VARCHAR2(70), 
	PAP NUMBER(1,0), 
	VID NUMBER(2,0), 
	DAZS DATE, 
	BLKD NUMBER(2,0), 
	BLKK NUMBER(2,0), 
	CHGDATE DATE, 
	CHGACTION NUMBER(1,0), 
	POS NUMBER(38,0), 
	TIP CHAR(3), 
	GRP NUMBER(38,0), 
	SECI NUMBER(38,0), 
	SECO NUMBER(38,0), 
	DONEBY VARCHAR2(64), 
	IDUPD NUMBER(38,0), 
	LIM NUMBER(24,0), 
	ACCC NUMBER(38,0), 
	TOBO VARCHAR2(30), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	MDATE DATE, 
	OSTX NUMBER(24,0), 
	SEC RAW(64), 
	RNK NUMBER(22,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	EFFECTDATE DATE, 
	SEND_SMS VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ACCOUNTS_UPDATE_O ***
 exec bpa.alter_policies('TMP_ACCOUNTS_UPDATE_O');


COMMENT ON TABLE BARS.TMP_ACCOUNTS_UPDATE_O IS 'История изменений счетов банка';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.ACC IS 'Внутренний номер счета';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.NLS IS 'Номер лицевого счета (внешний)';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.NLSALT IS 'Альтернативный номер счета';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.NBS IS 'Номер балансового счета';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.NBS2 IS 'Номер альтернат. балансового счета';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.DAOS IS 'Дата открытия счета';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.ISP IS 'Код исполнителя';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.NMS IS 'Наименование счета';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.PAP IS 'Признак Атива-Пассива';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.VID IS 'Код вида счета';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.DAZS IS 'Дата закрытия счета';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.BLKD IS 'Код блокировки дебет';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.BLKK IS 'Код блокировки кредит';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.CHGDATE IS 'Дата/время изменения';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.CHGACTION IS 'Тип изменения';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.POS IS 'Признак главного счета';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.TIP IS 'Тип счета';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.GRP IS 'Код группы счета';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.SECI IS 'Код доступа исполнителя';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.SECO IS 'Код доступа остальных';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.DONEBY IS 'Имя пользователя, выполнившего изменения';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.IDUPD IS 'Идентификатор изменения';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.LIM IS 'Лимит';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.ACCC IS 'Внутренний номер счета';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.TOBO IS 'Код безбалансового отделения';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.BRANCH IS 'Код подразделения';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.MDATE IS '';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.OSTX IS 'Максимальный остаток на счете';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.SEC IS '';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.RNK IS 'РНК клиента-владельца счета';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.KF IS '';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.EFFECTDATE IS 'банковская дата изменения';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.SEND_SMS IS 'Признак відправки СМС по рахунку';



PROMPT *** Create  grants  TMP_ACCOUNTS_UPDATE_O ***
grant SELECT                                                                 on TMP_ACCOUNTS_UPDATE_O to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_ACCOUNTS_UPDATE_O to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_ACCOUNTS_UPDATE_O to BARS_DM;
grant DELETE,INSERT,UPDATE                                                   on TMP_ACCOUNTS_UPDATE_O to CUST001;
grant SELECT                                                                 on TMP_ACCOUNTS_UPDATE_O to KLBX;
grant SELECT                                                                 on TMP_ACCOUNTS_UPDATE_O to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_ACCOUNTS_UPDATE_O to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ACCOUNTS_UPDATE_O.sql =========***
PROMPT ===================================================================================== 
