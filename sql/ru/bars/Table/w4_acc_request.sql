

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/W4_ACC_REQUEST.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to W4_ACC_REQUEST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''W4_ACC_REQUEST'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''W4_ACC_REQUEST'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table W4_ACC_REQUEST ***
begin 
  execute immediate '
  CREATE TABLE BARS.W4_ACC_REQUEST 
   (	ID NUMBER, 
	EXT_FILE_ID NUMBER, 
	EXT_ID VARCHAR2(100), 
	OPER_TYPE NUMBER(1,0), 
	DATE_IN DATE DEFAULT sysdate, 
	LASTEDIT DATE DEFAULT sysdate, 
	CONTRACT_NUMBER VARCHAR2(14), 
	PRODUCT_CODE VARCHAR2(32), 
	CARD_TYPE VARCHAR2(32), 
	OPER_DATE DATE, 
	STATUS NUMBER, 
	MSG VARCHAR2(254), 
	OKPO VARCHAR2(14), 
	OKPO_N NUMBER(22,0), 
	CARD_EXPIRE VARCHAR2(4), 
	ENG_FIRSTNAME VARCHAR2(30), 
	ENG_LASTNAME VARCHAR2(30), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSDYND 
  PARTITION BY LIST (STATUS) 
 (PARTITION P_STATE_NEW  VALUES (0) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSSMLD , 
 PARTITION P_STATE_OK  VALUES (1) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSSMLD , 
 PARTITION PSTATE_NOT_OK  VALUES (2) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSSMLD )  ENABLE ROW MOVEMENT ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to W4_ACC_REQUEST ***
 exec bpa.alter_policies('W4_ACC_REQUEST');


COMMENT ON TABLE BARS.W4_ACC_REQUEST IS 'CM. Запросы в АБС';
COMMENT ON COLUMN BARS.W4_ACC_REQUEST.ID IS '';
COMMENT ON COLUMN BARS.W4_ACC_REQUEST.EXT_FILE_ID IS '';
COMMENT ON COLUMN BARS.W4_ACC_REQUEST.EXT_ID IS '';
COMMENT ON COLUMN BARS.W4_ACC_REQUEST.OPER_TYPE IS 'Тип операции: 1-закрытие счета, 2-изменение субпродукта';
COMMENT ON COLUMN BARS.W4_ACC_REQUEST.DATE_IN IS 'Дата создания заявки';
COMMENT ON COLUMN BARS.W4_ACC_REQUEST.LASTEDIT IS '';
COMMENT ON COLUMN BARS.W4_ACC_REQUEST.CONTRACT_NUMBER IS 'Номер счета';
COMMENT ON COLUMN BARS.W4_ACC_REQUEST.PRODUCT_CODE IS 'Код продукта';
COMMENT ON COLUMN BARS.W4_ACC_REQUEST.CARD_TYPE IS 'Код субпродукта';
COMMENT ON COLUMN BARS.W4_ACC_REQUEST.OPER_DATE IS 'Плановая дата закрытия/модификации';
COMMENT ON COLUMN BARS.W4_ACC_REQUEST.STATUS IS 'Статус обработки: 0-ожидает обработки, 1-ошибкаб 2-обработан';
COMMENT ON COLUMN BARS.W4_ACC_REQUEST.MSG IS 'Сообщение после обработки запроса';
COMMENT ON COLUMN BARS.W4_ACC_REQUEST.OKPO IS '';
COMMENT ON COLUMN BARS.W4_ACC_REQUEST.OKPO_N IS '';
COMMENT ON COLUMN BARS.W4_ACC_REQUEST.CARD_EXPIRE IS 'Термін дії основної картки після операції пролонгації';
COMMENT ON COLUMN BARS.W4_ACC_REQUEST.ENG_FIRSTNAME IS '';
COMMENT ON COLUMN BARS.W4_ACC_REQUEST.ENG_LASTNAME IS '';
COMMENT ON COLUMN BARS.W4_ACC_REQUEST.KF IS '';




PROMPT *** Create  constraint PK_W4_ACC_REQUEST ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC_REQUEST ADD CONSTRAINT PK_W4_ACC_REQUEST PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003289897 ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC_REQUEST MODIFY (OPER_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003289896 ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC_REQUEST MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_W4_ACCREQ_EXT_FILE_ID ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_W4_ACCREQ_EXT_FILE_ID ON BARS.W4_ACC_REQUEST (EXT_FILE_ID, EXT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_W4_ACC_REQUEST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_W4_ACC_REQUEST ON BARS.W4_ACC_REQUEST (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/W4_ACC_REQUEST.sql =========*** End **
PROMPT ===================================================================================== 
