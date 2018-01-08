

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OPER_VISA.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OPER_VISA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OPER_VISA'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OPER_VISA'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OPER_VISA'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OPER_VISA ***
begin 
  execute immediate '
  CREATE TABLE BARS.OPER_VISA 
   (	REF NUMBER(38,0), 
	DAT DATE, 
	USERID NUMBER(38,0), 
	GROUPID NUMBER(38,0), 
	STATUS NUMBER(1,0), 
	SQNC NUMBER(38,0), 
	PASSIVE NUMBER(1,0), 
	KEYID VARCHAR2(6), 
	SIGN RAW(512), 
	USERNAME VARCHAR2(60), 
	USERTABN VARCHAR2(10), 
	GROUPNAME VARCHAR2(50), 
	F_IN_CHARGE NUMBER(1,0) DEFAULT 0, 
	CHECK_TS DATE, 
	CHECK_CODE NUMBER(4,0), 
	CHECK_MSG VARCHAR2(256), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	PASSIVE_REASONID NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OPER_VISA ***
 exec bpa.alter_policies('OPER_VISA');


COMMENT ON TABLE BARS.OPER_VISA IS 'История виз';
COMMENT ON COLUMN BARS.OPER_VISA.REF IS 'Референс';
COMMENT ON COLUMN BARS.OPER_VISA.DAT IS 'Дата изменения состояния';
COMMENT ON COLUMN BARS.OPER_VISA.USERID IS 'ID пользователя';
COMMENT ON COLUMN BARS.OPER_VISA.GROUPID IS 'ID группы контроля';
COMMENT ON COLUMN BARS.OPER_VISA.STATUS IS 'Состояние
1 - визирование
2 - оплата
3 - возврат';
COMMENT ON COLUMN BARS.OPER_VISA.SQNC IS 'Идентификатор записи';
COMMENT ON COLUMN BARS.OPER_VISA.PASSIVE IS 'Признак исключения из активной обработки';
COMMENT ON COLUMN BARS.OPER_VISA.KEYID IS 'Идентификатор ключа ЭЦП';
COMMENT ON COLUMN BARS.OPER_VISA.SIGN IS 'ЭЦП Визирования';
COMMENT ON COLUMN BARS.OPER_VISA.USERNAME IS 'ФИО пользователя';
COMMENT ON COLUMN BARS.OPER_VISA.USERTABN IS 'Табельный № пользователя';
COMMENT ON COLUMN BARS.OPER_VISA.GROUPNAME IS 'Наименование группы контроля';
COMMENT ON COLUMN BARS.OPER_VISA.F_IN_CHARGE IS 'Вид ЭЦП на визе: 0-Отсут, 1-Внутр, 2-СЭП, 3-Внутр+СЭП';
COMMENT ON COLUMN BARS.OPER_VISA.CHECK_TS IS 'Дата/время проверки ЭЦП';
COMMENT ON COLUMN BARS.OPER_VISA.CHECK_CODE IS 'Код проверки ЭЦП: 0 - верна, иначе - предупреждение или ошибка';
COMMENT ON COLUMN BARS.OPER_VISA.CHECK_MSG IS 'Описание кода проверки ЭЦП';
COMMENT ON COLUMN BARS.OPER_VISA.KF IS '';
COMMENT ON COLUMN BARS.OPER_VISA.PASSIVE_REASONID IS 'Код причины отката визы';




PROMPT *** Create  constraint FK_OPERVISA_CHKLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER_VISA ADD CONSTRAINT FK_OPERVISA_CHKLIST FOREIGN KEY (GROUPID)
	  REFERENCES BARS.CHKLIST (IDCHK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPERVISA_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER_VISA ADD CONSTRAINT FK_OPERVISA_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERVISA_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER_VISA MODIFY (KF CONSTRAINT CC_OPERVISA_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERVISA_FINCHARGE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER_VISA MODIFY (F_IN_CHARGE CONSTRAINT CC_OPERVISA_FINCHARGE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERVISA_SQNC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER_VISA MODIFY (SQNC CONSTRAINT CC_OPERVISA_SQNC_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERVISA_STATUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER_VISA MODIFY (STATUS CONSTRAINT CC_OPERVISA_STATUS_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERVISA_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER_VISA MODIFY (USERID CONSTRAINT CC_OPERVISA_USERID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERVISA_DAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER_VISA MODIFY (DAT CONSTRAINT CC_OPERVISA_DAT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERVISA_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER_VISA MODIFY (REF CONSTRAINT CC_OPERVISA_REF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERVISA_PASSIVE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER_VISA ADD CONSTRAINT CC_OPERVISA_PASSIVE CHECK (passive = 1) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OPERVISA ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER_VISA ADD CONSTRAINT PK_OPERVISA PRIMARY KEY (SQNC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPERVISA_STAFF$BASE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER_VISA ADD CONSTRAINT FK_OPERVISA_STAFF$BASE FOREIGN KEY (USERID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPERVISA_INCHARGELIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER_VISA ADD CONSTRAINT FK_OPERVISA_INCHARGELIST FOREIGN KEY (F_IN_CHARGE)
	  REFERENCES BARS.IN_CHARGE_LIST (IN_CHARGE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPERVISA_BPREASON ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER_VISA ADD CONSTRAINT FK_OPERVISA_BPREASON FOREIGN KEY (PASSIVE_REASONID)
	  REFERENCES BARS.BP_REASON (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OPERVISA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OPERVISA ON BARS.OPER_VISA (SQNC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAK_OPERVISA_REF ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAK_OPERVISA_REF ON BARS.OPER_VISA (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OPER_VISA ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OPER_VISA       to ABS_ADMIN;
grant FLASHBACK,REFERENCES,SELECT                                            on OPER_VISA       to BARSAQ with grant option;
grant SELECT                                                                 on OPER_VISA       to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on OPER_VISA       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OPER_VISA       to BARS_DM;
grant DELETE,INSERT,SELECT                                                   on OPER_VISA       to CHCK;
grant SELECT                                                                 on OPER_VISA       to FINMON01;
grant INSERT                                                                 on OPER_VISA       to NALOG;
grant SELECT                                                                 on OPER_VISA       to PFU with grant option;
grant INSERT                                                                 on OPER_VISA       to PYOD001;
grant DELETE,INSERT,SELECT,UPDATE                                            on OPER_VISA       to START1;
grant SELECT                                                                 on OPER_VISA       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OPER_VISA       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OPER_VISA.sql =========*** End *** ===
PROMPT ===================================================================================== 
