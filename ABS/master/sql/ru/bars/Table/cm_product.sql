

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CM_PRODUCT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CM_PRODUCT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CM_PRODUCT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CM_PRODUCT'', ''WHOLE'' , null, null, null, null);
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
	MM_MAX NUMBER(10,0)
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
COMMENT ON COLUMN BARS.CM_PRODUCT.PERCENT_NOTUSEDLIMIT IS 'Процентная ставка за неиспользованный лимит кредитной линии';
COMMENT ON COLUMN BARS.CM_PRODUCT.PERCENT_GRACE IS 'Процентная ставка за использование кредитной линии на протяжении Грейс-периода';
COMMENT ON COLUMN BARS.CM_PRODUCT.MM_MAX IS 'Максимальное количество месяцев действия карты';
COMMENT ON COLUMN BARS.CM_PRODUCT.PRODUCT_CODE IS 'Код продукта';
COMMENT ON COLUMN BARS.CM_PRODUCT.PERCENT_OSN IS 'Процентная ставка по текущему счету';
COMMENT ON COLUMN BARS.CM_PRODUCT.PERCENT_MOB IS 'Процентная ставка по счету мобильных сбережений (депозитный)';
COMMENT ON COLUMN BARS.CM_PRODUCT.PERCENT_CRED IS 'Процентная ставка по кредитному счету';
COMMENT ON COLUMN BARS.CM_PRODUCT.PERCENT_OVER IS 'Процентная ставка по счету несанкционированного овердрафта';
COMMENT ON COLUMN BARS.CM_PRODUCT.CHG_DATE IS 'Дата обновления процентных ставок';
COMMENT ON COLUMN BARS.CM_PRODUCT.CHG_USER IS 'Пользователь, кот. обновлял проц. ставки';



PROMPT *** Create  grants  CM_PRODUCT ***
grant SELECT                                                                 on CM_PRODUCT      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CM_PRODUCT      to CM_ACCESS_ROLE;
grant SELECT                                                                 on CM_PRODUCT      to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CM_PRODUCT.sql =========*** End *** ==
PROMPT ===================================================================================== 
