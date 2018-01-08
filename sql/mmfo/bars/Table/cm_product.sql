

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CM_PRODUCT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CM_PRODUCT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CM_PRODUCT'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CM_PRODUCT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CM_PRODUCT'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CM_PRODUCT ***
begin 
  execute immediate '
  CREATE TABLE BARS.CM_PRODUCT 
   (	PRODUCT_CODE VARCHAR2(32), 
	PERCENT_OSN NUMBER, 
	PERCENT_MOB NUMBER, 
	PERCENT_CRED NUMBER, 
	PERCENT_OVER NUMBER, 
	CHG_DATE DATE DEFAULT sysdate, 
	CHG_USER VARCHAR2(64) DEFAULT user, 
	PERCENT_NOTUSEDLIMIT NUMBER, 
	PERCENT_GRACE NUMBER, 
	MM_MAX NUMBER(10,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CM_PRODUCT ***
 exec bpa.alter_policies('CM_PRODUCT');


COMMENT ON TABLE BARS.CM_PRODUCT IS 'CM. Справочник продуктов карточных контрактов';
COMMENT ON COLUMN BARS.CM_PRODUCT.KF IS '';
COMMENT ON COLUMN BARS.CM_PRODUCT.PRODUCT_CODE IS 'Код продукта';
COMMENT ON COLUMN BARS.CM_PRODUCT.PERCENT_OSN IS 'Процентная ставка по текущему счету';
COMMENT ON COLUMN BARS.CM_PRODUCT.PERCENT_MOB IS 'Процентная ставка по счету мобильных сбережений (депозитный)';
COMMENT ON COLUMN BARS.CM_PRODUCT.PERCENT_CRED IS 'Процентная ставка по кредитному счету';
COMMENT ON COLUMN BARS.CM_PRODUCT.PERCENT_OVER IS 'Процентная ставка по счету несанкционированного овердрафта';
COMMENT ON COLUMN BARS.CM_PRODUCT.CHG_DATE IS 'Дата обновления процентных ставок';
COMMENT ON COLUMN BARS.CM_PRODUCT.CHG_USER IS 'Пользователь, кот. обновлял проц. ставки';
COMMENT ON COLUMN BARS.CM_PRODUCT.PERCENT_NOTUSEDLIMIT IS 'Процентная ставка за неиспользованный лимит кредитной линии';
COMMENT ON COLUMN BARS.CM_PRODUCT.PERCENT_GRACE IS 'Процентная ставка за использование кредитной линии на протяжении Грейс-периода';
COMMENT ON COLUMN BARS.CM_PRODUCT.MM_MAX IS 'Максимальное количество месяцев действия карты';




PROMPT *** Create  constraint CC_CMPRODUCT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_PRODUCT MODIFY (KF CONSTRAINT CC_CMPRODUCT_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CM_PRODUCT ***
grant SELECT                                                                 on CM_PRODUCT      to BARSREADER_ROLE;
grant SELECT                                                                 on CM_PRODUCT      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CM_PRODUCT      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CM_PRODUCT      to CM_ACCESS_ROLE;
grant SELECT                                                                 on CM_PRODUCT      to OW;
grant SELECT                                                                 on CM_PRODUCT      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CM_PRODUCT.sql =========*** End *** ==
PROMPT ===================================================================================== 
