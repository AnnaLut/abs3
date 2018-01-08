

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_APE_LINK.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_APE_LINK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_APE_LINK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_APE_LINK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_APE_LINK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_APE_LINK ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_APE_LINK 
   (	PAYMENT_ID NUMBER, 
	FANTOM_ID NUMBER, 
	SERVICE_CODE VARCHAR2(7), 
	APE_ID NUMBER, 
	S NUMBER, 
	DELETE_DATE DATE, 
	DELETE_UID VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_APE_LINK ***
 exec bpa.alter_policies('CIM_APE_LINK');


COMMENT ON TABLE BARS.CIM_APE_LINK IS 'Прив`язки актів цінової експертизи до Платежів/Фантомів';
COMMENT ON COLUMN BARS.CIM_APE_LINK.PAYMENT_ID IS 'Ідентифікатор платежа';
COMMENT ON COLUMN BARS.CIM_APE_LINK.FANTOM_ID IS 'Ідентифікатор фантома';
COMMENT ON COLUMN BARS.CIM_APE_LINK.SERVICE_CODE IS 'Код класифікатора послуг';
COMMENT ON COLUMN BARS.CIM_APE_LINK.APE_ID IS 'id акта цінової експертизи';
COMMENT ON COLUMN BARS.CIM_APE_LINK.S IS 'Cума зв`язку';
COMMENT ON COLUMN BARS.CIM_APE_LINK.DELETE_DATE IS 'Дата видалення';
COMMENT ON COLUMN BARS.CIM_APE_LINK.DELETE_UID IS 'id користувача, який видалив прив`язку';




PROMPT *** Create  constraint CC_CIMAPELINK_PAYMENT_CHECK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_APE_LINK ADD CONSTRAINT CC_CIMAPELINK_PAYMENT_CHECK CHECK (PAYMENT_ID IS NULL OR FANTOM_ID IS NULL) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMAPELINK_SCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_APE_LINK MODIFY (SERVICE_CODE CONSTRAINT CC_CIMAPELINK_SCODE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index CIMAPELINK_PAYMENTID_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.CIMAPELINK_PAYMENTID_IDX ON BARS.CIM_APE_LINK (PAYMENT_ID, FANTOM_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_APE_LINK ***
grant SELECT                                                                 on CIM_APE_LINK    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_APE_LINK    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_APE_LINK    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_APE_LINK    to CIM_ROLE;
grant SELECT                                                                 on CIM_APE_LINK    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_APE_LINK.sql =========*** End *** 
PROMPT ===================================================================================== 
