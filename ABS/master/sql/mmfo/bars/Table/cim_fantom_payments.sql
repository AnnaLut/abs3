

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_FANTOM_PAYMENTS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_FANTOM_PAYMENTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_FANTOM_PAYMENTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_FANTOM_PAYMENTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_FANTOM_PAYMENTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_FANTOM_PAYMENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_FANTOM_PAYMENTS 
   (	FANTOM_ID NUMBER, 
	DIRECT NUMBER, 
	PAYMENT_TYPE NUMBER, 
	OPER_TYPE NUMBER, 
	RNK NUMBER, 
	BENEF_ID NUMBER, 
	BANK_DATE DATE, 
	VAL_DATE DATE, 
	KV NUMBER, 
	S NUMBER, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	DETAILS VARCHAR2(160)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_FANTOM_PAYMENTS ***
 exec bpa.alter_policies('CIM_FANTOM_PAYMENTS');


COMMENT ON TABLE BARS.CIM_FANTOM_PAYMENTS IS 'Фантомні платежі v1.0';
COMMENT ON COLUMN BARS.CIM_FANTOM_PAYMENTS.FANTOM_ID IS 'Ідентифікатор фантомного платежу';
COMMENT ON COLUMN BARS.CIM_FANTOM_PAYMENTS.DIRECT IS 'Тип платежу (вхідні\вихідні)';
COMMENT ON COLUMN BARS.CIM_FANTOM_PAYMENTS.PAYMENT_TYPE IS 'Вид платіжного документу';
COMMENT ON COLUMN BARS.CIM_FANTOM_PAYMENTS.OPER_TYPE IS 'Код типу операції';
COMMENT ON COLUMN BARS.CIM_FANTOM_PAYMENTS.RNK IS 'RNK клієнта';
COMMENT ON COLUMN BARS.CIM_FANTOM_PAYMENTS.BENEF_ID IS 'id бенефіціара';
COMMENT ON COLUMN BARS.CIM_FANTOM_PAYMENTS.BANK_DATE IS 'Банківська дата створення';
COMMENT ON COLUMN BARS.CIM_FANTOM_PAYMENTS.VAL_DATE IS 'Дата валютування';
COMMENT ON COLUMN BARS.CIM_FANTOM_PAYMENTS.KV IS 'Валюта платежу';
COMMENT ON COLUMN BARS.CIM_FANTOM_PAYMENTS.S IS 'Сума платежу';
COMMENT ON COLUMN BARS.CIM_FANTOM_PAYMENTS.BRANCH IS 'Номер відділеня';
COMMENT ON COLUMN BARS.CIM_FANTOM_PAYMENTS.DETAILS IS 'Призначення платежу';




PROMPT *** Create  constraint CC_FANTOMPAYMENTS_DIRECT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOM_PAYMENTS MODIFY (DIRECT CONSTRAINT CC_FANTOMPAYMENTS_DIRECT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FANTOMPAYMENTS_DIRECT_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOM_PAYMENTS ADD CONSTRAINT CC_FANTOMPAYMENTS_DIRECT_CC CHECK (direct in (0,1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FANTOMPAYMENTS_PAYTYPE_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOM_PAYMENTS ADD CONSTRAINT CC_FANTOMPAYMENTS_PAYTYPE_CC CHECK (payment_type>0) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_FANTOM_PAYMENTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOM_PAYMENTS ADD CONSTRAINT PK_FANTOM_PAYMENTS PRIMARY KEY (FANTOM_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FANTOMPAYMENTS_IDFP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOM_PAYMENTS MODIFY (FANTOM_ID CONSTRAINT CC_FANTOMPAYMENTS_IDFP_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FANTOMPAYMENTS_TYPEID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOM_PAYMENTS MODIFY (PAYMENT_TYPE CONSTRAINT CC_FANTOMPAYMENTS_TYPEID NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FANTOMPAYMENTS_OPERTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOM_PAYMENTS MODIFY (OPER_TYPE CONSTRAINT CC_FANTOMPAYMENTS_OPERTYPE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FANTOMPAYMENTS_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOM_PAYMENTS MODIFY (RNK CONSTRAINT CC_FANTOMPAYMENTS_RNK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FANTOMPAYMENTS_BDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOM_PAYMENTS MODIFY (BANK_DATE CONSTRAINT CC_FANTOMPAYMENTS_BDATE NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FANTOMPAYMENTS_VDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOM_PAYMENTS MODIFY (VAL_DATE CONSTRAINT CC_FANTOMPAYMENTS_VDATE NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FANTOMPAYMENTS_KV ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOM_PAYMENTS MODIFY (KV CONSTRAINT CC_FANTOMPAYMENTS_KV NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FANTOMPAYMENTS_S ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOM_PAYMENTS MODIFY (S CONSTRAINT CC_FANTOMPAYMENTS_S NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMFANTOMPAYMENTS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOM_PAYMENTS MODIFY (BRANCH CONSTRAINT CC_CIMFANTOMPAYMENTS_BRANCH_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FANTOMPAYMENTS_COMMENTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOM_PAYMENTS MODIFY (DETAILS CONSTRAINT CC_FANTOMPAYMENTS_COMMENTS NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FANTOM_PAYMENTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FANTOM_PAYMENTS ON BARS.CIM_FANTOM_PAYMENTS (FANTOM_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_FANTOM_PAYMENTS ***
grant SELECT                                                                 on CIM_FANTOM_PAYMENTS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_FANTOM_PAYMENTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_FANTOM_PAYMENTS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_FANTOM_PAYMENTS to CIM_ROLE;
grant SELECT                                                                 on CIM_FANTOM_PAYMENTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_FANTOM_PAYMENTS.sql =========*** E
PROMPT ===================================================================================== 
