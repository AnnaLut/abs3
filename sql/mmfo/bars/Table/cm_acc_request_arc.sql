

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CM_ACC_REQUEST_ARC.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CM_ACC_REQUEST_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CM_ACC_REQUEST_ARC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CM_ACC_REQUEST_ARC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CM_ACC_REQUEST_ARC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CM_ACC_REQUEST_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.CM_ACC_REQUEST_ARC 
   (	OPER_TYPE NUMBER(1,0), 
	DATE_IN DATE, 
	CONTRACT_NUMBER VARCHAR2(14), 
	PRODUCT_CODE VARCHAR2(32), 
	CARD_TYPE VARCHAR2(32), 
	OPER_DATE DATE, 
	ABS_STATUS NUMBER, 
	ABS_MSG VARCHAR2(254), 
	DONEBY VARCHAR2(64), 
	CNGDATE DATE DEFAULT sysdate, 
	OKPO VARCHAR2(14), 
	OKPO_N NUMBER(22,0), 
	CARD_EXPIRE VARCHAR2(4), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CM_ACC_REQUEST_ARC ***
 exec bpa.alter_policies('CM_ACC_REQUEST_ARC');


COMMENT ON TABLE BARS.CM_ACC_REQUEST_ARC IS 'CM. Запросы в АБС. Архив';
COMMENT ON COLUMN BARS.CM_ACC_REQUEST_ARC.KF IS '';
COMMENT ON COLUMN BARS.CM_ACC_REQUEST_ARC.OPER_TYPE IS 'Тип операции: 1-закрытие счета, 2-изменение субпродукта';
COMMENT ON COLUMN BARS.CM_ACC_REQUEST_ARC.DATE_IN IS 'Дата создания заявки';
COMMENT ON COLUMN BARS.CM_ACC_REQUEST_ARC.CONTRACT_NUMBER IS 'Номер счета';
COMMENT ON COLUMN BARS.CM_ACC_REQUEST_ARC.PRODUCT_CODE IS 'Код продукта';
COMMENT ON COLUMN BARS.CM_ACC_REQUEST_ARC.CARD_TYPE IS 'Код субпродукта';
COMMENT ON COLUMN BARS.CM_ACC_REQUEST_ARC.OPER_DATE IS 'Плановая дата закрытия/модификации';
COMMENT ON COLUMN BARS.CM_ACC_REQUEST_ARC.ABS_STATUS IS 'Статус обработки: 0-ожидает обработки, 1-ошибкаб 2-обработан, 3-удален';
COMMENT ON COLUMN BARS.CM_ACC_REQUEST_ARC.ABS_MSG IS 'Сообщение после обработки запроса';
COMMENT ON COLUMN BARS.CM_ACC_REQUEST_ARC.DONEBY IS '';
COMMENT ON COLUMN BARS.CM_ACC_REQUEST_ARC.CNGDATE IS '';
COMMENT ON COLUMN BARS.CM_ACC_REQUEST_ARC.OKPO IS '';
COMMENT ON COLUMN BARS.CM_ACC_REQUEST_ARC.OKPO_N IS '';
COMMENT ON COLUMN BARS.CM_ACC_REQUEST_ARC.CARD_EXPIRE IS 'Термін дії основної картки після операції пролонгації';




PROMPT *** Create  constraint FK_CMACCREQUESTARC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_ACC_REQUEST_ARC ADD CONSTRAINT FK_CMACCREQUESTARC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CMACCREQUESTARC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_ACC_REQUEST_ARC MODIFY (KF CONSTRAINT CC_CMACCREQUESTARC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CM_ACC_REQUEST_ARC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CM_ACC_REQUEST_ARC to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CM_ACC_REQUEST_ARC to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CM_ACC_REQUEST_ARC to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CM_ACC_REQUEST_ARC.sql =========*** En
PROMPT ===================================================================================== 
