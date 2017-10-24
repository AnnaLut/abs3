

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_PAYMENTS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SUBPRODUCT_PAYMENTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SUBPRODUCT_PAYMENTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_PAYMENTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_PAYMENTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SUBPRODUCT_PAYMENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SUBPRODUCT_PAYMENTS 
   (	SUBPRODUCT_ID VARCHAR2(100), 
	PAYMENT_ID VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SUBPRODUCT_PAYMENTS ***
 exec bpa.alter_policies('WCS_SUBPRODUCT_PAYMENTS');


COMMENT ON TABLE BARS.WCS_SUBPRODUCT_PAYMENTS IS 'Привязка типов выдачи к суб-продукту';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_PAYMENTS.SUBPRODUCT_ID IS 'Идентификатор субродукта';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_PAYMENTS.PAYMENT_ID IS 'Идентификатор типа выдачи';




PROMPT *** Create  constraint PK_SBPPAYMENTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_PAYMENTS ADD CONSTRAINT PK_SBPPAYMENTS PRIMARY KEY (SUBPRODUCT_ID, PAYMENT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPPAYMENTS_SBPID_SBPS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_PAYMENTS ADD CONSTRAINT FK_SBPPAYMENTS_SBPID_SBPS_ID FOREIGN KEY (SUBPRODUCT_ID)
	  REFERENCES BARS.WCS_SUBPRODUCTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPPAYMENTS_PID_PARTS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_PAYMENTS ADD CONSTRAINT FK_SBPPAYMENTS_PID_PARTS_ID FOREIGN KEY (PAYMENT_ID)
	  REFERENCES BARS.WCS_PAYMENT_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SBPPAYMENTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SBPPAYMENTS ON BARS.WCS_SUBPRODUCT_PAYMENTS (SUBPRODUCT_ID, PAYMENT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SUBPRODUCT_PAYMENTS ***
grant SELECT                                                                 on WCS_SUBPRODUCT_PAYMENTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SUBPRODUCT_PAYMENTS to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_PAYMENTS.sql =========*
PROMPT ===================================================================================== 
