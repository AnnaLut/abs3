

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEAL_PRODUCT_ACCOUNT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEAL_PRODUCT_ACCOUNT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEAL_PRODUCT_ACCOUNT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DEAL_PRODUCT_ACCOUNT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEAL_PRODUCT_ACCOUNT ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEAL_PRODUCT_ACCOUNT 
   (	PRODUCT_ID NUMBER(5,0), 
	DEAL_ACCOUNT_TYPE_ID NUMBER(5,0), 
	GL_ACCOUNT_TYPE_CODE CHAR(3 CHAR), 
	BALANCE_ACCOUNT VARCHAR2(6 CHAR), 
	OB22_CODE VARCHAR2(100 CHAR), 
	CURRENCY_ID NUMBER(3,0), 
	IS_PERMANENT CHAR(1), 
	IS_AUTO_OPEN CHAR(1), 
	ACCOUNT_NUMBER_FUNC VARCHAR2(100 CHAR)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEAL_PRODUCT_ACCOUNT ***
 exec bpa.alter_policies('DEAL_PRODUCT_ACCOUNT');


COMMENT ON TABLE BARS.DEAL_PRODUCT_ACCOUNT IS 'Налаштування правил роботи з рахунками по продуктам';
COMMENT ON COLUMN BARS.DEAL_PRODUCT_ACCOUNT.PRODUCT_ID IS 'Ідентифікатор продукту';
COMMENT ON COLUMN BARS.DEAL_PRODUCT_ACCOUNT.DEAL_ACCOUNT_TYPE_ID IS 'Тип рахунку обліку угод (роль, яку виконує даний тип рахунків в рамках угоди)';
COMMENT ON COLUMN BARS.DEAL_PRODUCT_ACCOUNT.GL_ACCOUNT_TYPE_CODE IS 'Тип рахунку Головної книги';
COMMENT ON COLUMN BARS.DEAL_PRODUCT_ACCOUNT.BALANCE_ACCOUNT IS 'Балансовий номер рахунку для даного типу рахунків в рамках даного продукту';
COMMENT ON COLUMN BARS.DEAL_PRODUCT_ACCOUNT.OB22_CODE IS '';
COMMENT ON COLUMN BARS.DEAL_PRODUCT_ACCOUNT.CURRENCY_ID IS 'Валюта рахунку за замовчанням (наприклад, всі рахунки доходів/витрат можуть вестся в національній валюті)';
COMMENT ON COLUMN BARS.DEAL_PRODUCT_ACCOUNT.IS_PERMANENT IS 'Ознака того, що рахунок повинен прив'язуватися до угоди за допомогою таблиці DEAL_ACCOUNT';
COMMENT ON COLUMN BARS.DEAL_PRODUCT_ACCOUNT.IS_AUTO_OPEN IS 'Ознака того, що рахунок може відкриватися системою автоматично при виникненні в ньому потреби';
COMMENT ON COLUMN BARS.DEAL_PRODUCT_ACCOUNT.ACCOUNT_NUMBER_FUNC IS 'Функція генерації номера рахунку';




PROMPT *** Create  constraint FK_DEAL_PRO_REFERENCE_DEAL_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT_ACCOUNT ADD CONSTRAINT FK_DEAL_PRO_REFERENCE_DEAL_ACC FOREIGN KEY (DEAL_ACCOUNT_TYPE_ID)
	  REFERENCES BARS.DEAL_ACCOUNT_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DEAL_PRO_REFERENCE_TIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT_ACCOUNT ADD CONSTRAINT FK_DEAL_PRO_REFERENCE_TIPS FOREIGN KEY (GL_ACCOUNT_TYPE_CODE)
	  REFERENCES BARS.TIPS (TIP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PROD_ACC_REF_PRODUCT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT_ACCOUNT ADD CONSTRAINT FK_PROD_ACC_REF_PRODUCT FOREIGN KEY (PRODUCT_ID)
	  REFERENCES BARS.DEAL_PRODUCT (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DEAL_PRO_REFERENCE_TABVAL$G ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT_ACCOUNT ADD CONSTRAINT FK_DEAL_PRO_REFERENCE_TABVAL$G FOREIGN KEY (CURRENCY_ID)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003187802 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT_ACCOUNT MODIFY (IS_AUTO_OPEN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003187801 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT_ACCOUNT MODIFY (IS_PERMANENT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003187800 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT_ACCOUNT MODIFY (GL_ACCOUNT_TYPE_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003187799 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT_ACCOUNT MODIFY (DEAL_ACCOUNT_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003187798 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT_ACCOUNT MODIFY (PRODUCT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index DEAL_PROD_ACCOUNT_IDX ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.DEAL_PROD_ACCOUNT_IDX ON BARS.DEAL_PRODUCT_ACCOUNT (PRODUCT_ID, DEAL_ACCOUNT_TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEAL_PRODUCT_ACCOUNT.sql =========*** 
PROMPT ===================================================================================== 
