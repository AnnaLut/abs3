

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CREDGRAPH_PAYMENT.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CREDGRAPH_PAYMENT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CREDGRAPH_PAYMENT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CREDGRAPH_PAYMENT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CREDGRAPH_PAYMENT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CREDGRAPH_PAYMENT ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CREDGRAPH_PAYMENT 
   (	CONTR_ID NUMBER, 
	DAT DATE, 
	S NUMBER, 
	PAY_FLAG NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CREDGRAPH_PAYMENT ***
 exec bpa.alter_policies('CIM_CREDGRAPH_PAYMENT');


COMMENT ON TABLE BARS.CIM_CREDGRAPH_PAYMENT IS 'Неперіодичні планові платежі графіка кредитного контракту';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_PAYMENT.CONTR_ID IS 'ID контракту';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_PAYMENT.DAT IS 'Дата платежа';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_PAYMENT.S IS 'Сума платежа';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_PAYMENT.PAY_FLAG IS 'Класифікатор платежа';




PROMPT *** Create  constraint CC_CIMCGPAYMENT_PAYFLAG_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDGRAPH_PAYMENT ADD CONSTRAINT CC_CIMCGPAYMENT_PAYFLAG_CC CHECK (pay_flag in (2,3,4,5)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCGPAYMENT_S_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDGRAPH_PAYMENT MODIFY (S CONSTRAINT CC_CIMCGPAYMENT_S_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCGPAYMENT_PAYFLAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDGRAPH_PAYMENT MODIFY (PAY_FLAG CONSTRAINT CC_CIMCGPAYMENT_PAYFLAG_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCGPAYMENT_CONTRID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDGRAPH_PAYMENT MODIFY (CONTR_ID CONSTRAINT CC_CIMCGPAYMENT_CONTRID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCGPAYMENT_DAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDGRAPH_PAYMENT MODIFY (DAT CONSTRAINT CC_CIMCGPAYMENT_DAT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_CREDGRAPH_PAYMENT ***
grant SELECT                                                                 on CIM_CREDGRAPH_PAYMENT to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDGRAPH_PAYMENT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CREDGRAPH_PAYMENT to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDGRAPH_PAYMENT to CIM_ROLE;
grant SELECT                                                                 on CIM_CREDGRAPH_PAYMENT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CREDGRAPH_PAYMENT.sql =========***
PROMPT ===================================================================================== 
