

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CM_ACC_REQUEST.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CM_ACC_REQUEST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CM_ACC_REQUEST'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CM_ACC_REQUEST'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CM_ACC_REQUEST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CM_ACC_REQUEST ***
begin 
  execute immediate '
  CREATE TABLE BARS.CM_ACC_REQUEST 
   (	OPER_TYPE NUMBER(1,0), 
	DATE_IN DATE DEFAULT sysdate, 
	CONTRACT_NUMBER VARCHAR2(14), 
	PRODUCT_CODE VARCHAR2(32), 
	CARD_TYPE VARCHAR2(32), 
	OPER_DATE DATE, 
	ABS_STATUS NUMBER, 
	ABS_MSG VARCHAR2(254), 
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




PROMPT *** ALTER_POLICIES to CM_ACC_REQUEST ***
 exec bpa.alter_policies('CM_ACC_REQUEST');


COMMENT ON TABLE BARS.CM_ACC_REQUEST IS 'CM. Запросы в АБС';
COMMENT ON COLUMN BARS.CM_ACC_REQUEST.OPER_TYPE IS 'Тип операции: 1-закрытие счета, 2-изменение субпродукта';
COMMENT ON COLUMN BARS.CM_ACC_REQUEST.DATE_IN IS 'Дата создания заявки';
COMMENT ON COLUMN BARS.CM_ACC_REQUEST.CONTRACT_NUMBER IS 'Номер счета';
COMMENT ON COLUMN BARS.CM_ACC_REQUEST.PRODUCT_CODE IS 'Код продукта';
COMMENT ON COLUMN BARS.CM_ACC_REQUEST.CARD_TYPE IS 'Код субпродукта';
COMMENT ON COLUMN BARS.CM_ACC_REQUEST.OPER_DATE IS 'Плановая дата закрытия/модификации';
COMMENT ON COLUMN BARS.CM_ACC_REQUEST.ABS_STATUS IS 'Статус обработки: 0-ожидает обработки, 1-ошибкаб 2-обработан';
COMMENT ON COLUMN BARS.CM_ACC_REQUEST.ABS_MSG IS 'Сообщение после обработки запроса';
COMMENT ON COLUMN BARS.CM_ACC_REQUEST.OKPO IS '';
COMMENT ON COLUMN BARS.CM_ACC_REQUEST.OKPO_N IS '';
COMMENT ON COLUMN BARS.CM_ACC_REQUEST.CARD_EXPIRE IS 'Термін дії основної картки після операції пролонгації';
COMMENT ON COLUMN BARS.CM_ACC_REQUEST.KF IS '';




PROMPT *** Create  constraint CC_CMACCREQUEST_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_ACC_REQUEST MODIFY (KF CONSTRAINT CC_CMACCREQUEST_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_CM_ACC_REQUEST_CNOTODID ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_CM_ACC_REQUEST_CNOTODID ON BARS.CM_ACC_REQUEST (CONTRACT_NUMBER, OPER_TYPE, OPER_DATE, DATE_IN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CM_ACC_REQUEST ***
grant SELECT                                                                 on CM_ACC_REQUEST  to BARSREADER_ROLE;
grant SELECT                                                                 on CM_ACC_REQUEST  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CM_ACC_REQUEST  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CM_ACC_REQUEST  to CM_ACCESS_ROLE;
grant SELECT                                                                 on CM_ACC_REQUEST  to OW;
grant SELECT                                                                 on CM_ACC_REQUEST  to START1;
grant SELECT                                                                 on CM_ACC_REQUEST  to UPLD;



PROMPT *** Create SYNONYM  to CM_ACC_REQUEST ***

  CREATE OR REPLACE PUBLIC SYNONYM CM_ACC_REQUEST FOR BARS.CM_ACC_REQUEST;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CM_ACC_REQUEST.sql =========*** End **
PROMPT ===================================================================================== 
