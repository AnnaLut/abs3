

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_LICENSE_LINK.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_LICENSE_LINK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_LICENSE_LINK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_LICENSE_LINK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_LICENSE_LINK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_LICENSE_LINK ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_LICENSE_LINK 
   (	PAYMENT_ID NUMBER, 
	FANTOM_ID NUMBER, 
	LICENSE_ID NUMBER, 
	OKPO VARCHAR2(14), 
	S NUMBER, 
	CREATE_DATE DATE, 
	CREATE_UID VARCHAR2(30), 
	DELETE_DATE DATE, 
	DELETE_UID VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_LICENSE_LINK ***
 exec bpa.alter_policies('CIM_LICENSE_LINK');


COMMENT ON TABLE BARS.CIM_LICENSE_LINK IS 'Прив`язки ліцензій до Платежів/Фантомів';
COMMENT ON COLUMN BARS.CIM_LICENSE_LINK.PAYMENT_ID IS 'Ідентифікатор платежа';
COMMENT ON COLUMN BARS.CIM_LICENSE_LINK.FANTOM_ID IS 'Ідентифікатор фантома';
COMMENT ON COLUMN BARS.CIM_LICENSE_LINK.LICENSE_ID IS 'id ліцензії';
COMMENT ON COLUMN BARS.CIM_LICENSE_LINK.OKPO IS '';
COMMENT ON COLUMN BARS.CIM_LICENSE_LINK.S IS 'Cума зв`язку';
COMMENT ON COLUMN BARS.CIM_LICENSE_LINK.CREATE_DATE IS 'Дата створення';
COMMENT ON COLUMN BARS.CIM_LICENSE_LINK.CREATE_UID IS 'id користувача, який створив прив`язку';
COMMENT ON COLUMN BARS.CIM_LICENSE_LINK.DELETE_DATE IS 'Дата видалення';
COMMENT ON COLUMN BARS.CIM_LICENSE_LINK.DELETE_UID IS 'id користувача, який видалив прив`язку';




PROMPT *** Create  constraint CC_CIMLCLINK_PAYMENT_CHECK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_LICENSE_LINK ADD CONSTRAINT CC_CIMLCLINK_PAYMENT_CHECK CHECK (FANTOM_ID IS NULL OR PAYMENT_ID IS NULL) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMLCLINK_LICENSEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_LICENSE_LINK MODIFY (LICENSE_ID CONSTRAINT CC_CIMLCLINK_LICENSEID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMLCLINK_OKPO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_LICENSE_LINK MODIFY (OKPO CONSTRAINT CC_CIMLCLINK_OKPO_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMLCLINK_S_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_LICENSE_LINK MODIFY (S CONSTRAINT CC_CIMLCLINK_S_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMLCLINK_CREATEDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_LICENSE_LINK MODIFY (CREATE_DATE CONSTRAINT CC_CIMLCLINK_CREATEDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMLCLINK_CREATEUID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_LICENSE_LINK MODIFY (CREATE_UID CONSTRAINT CC_CIMLCLINK_CREATEUID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_LICENSE_LINK ***
grant SELECT                                                                 on CIM_LICENSE_LINK to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_LICENSE_LINK to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_LICENSE_LINK to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_LICENSE_LINK to CIM_ROLE;
grant SELECT                                                                 on CIM_LICENSE_LINK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_LICENSE_LINK.sql =========*** End 
PROMPT ===================================================================================== 
