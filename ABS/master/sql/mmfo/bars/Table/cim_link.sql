

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_LINK.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_LINK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_LINK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_LINK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_LINK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_LINK ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_LINK 
   (	PAYMENT_ID NUMBER, 
	FANTOM_ID NUMBER, 
	VMD_ID NUMBER, 
	ACT_ID NUMBER, 
	S NUMBER, 
	DELETE_DATE DATE, 
	UID_DEL_JOURNAL NUMBER, 
	ID NUMBER, 
	COMMENTS VARCHAR2(128), 
	CREATE_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_LINK ***
 exec bpa.alter_policies('CIM_LINK');


COMMENT ON TABLE BARS.CIM_LINK IS 'Прив`язки ВМД/Актів до Платежів/Фантомів';
COMMENT ON COLUMN BARS.CIM_LINK.PAYMENT_ID IS 'Ідентифікатор платежа';
COMMENT ON COLUMN BARS.CIM_LINK.FANTOM_ID IS 'Ідентифікатор фантома';
COMMENT ON COLUMN BARS.CIM_LINK.VMD_ID IS 'Ідентифікатор ВМД';
COMMENT ON COLUMN BARS.CIM_LINK.ACT_ID IS 'Ідентифікатор Акта';
COMMENT ON COLUMN BARS.CIM_LINK.S IS 'Сума при`язки у валюті контракту';
COMMENT ON COLUMN BARS.CIM_LINK.DELETE_DATE IS 'Дата видалення';
COMMENT ON COLUMN BARS.CIM_LINK.UID_DEL_JOURNAL IS 'id користувача, який видалив запис з журналу';
COMMENT ON COLUMN BARS.CIM_LINK.ID IS '';
COMMENT ON COLUMN BARS.CIM_LINK.COMMENTS IS 'Коментар';
COMMENT ON COLUMN BARS.CIM_LINK.CREATE_DATE IS 'Дата прив`язки';




PROMPT *** Create  constraint CC_CIMLINK_PAYMENT_CHECK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_LINK ADD CONSTRAINT CC_CIMLINK_PAYMENT_CHECK CHECK (payment_id is null and fantom_id is not null or payment_id is not null and fantom_id is null) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMLINK_VMD_CHECK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_LINK ADD CONSTRAINT CC_CIMLINK_VMD_CHECK CHECK (vmd_id is null and act_id is not null or vmd_id is not null and act_id is null) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CIMLINK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_LINK ADD CONSTRAINT PK_CIMLINK PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMLINK_S_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_LINK MODIFY (S CONSTRAINT CC_CIMLINK_S_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMLINK_CDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_LINK MODIFY (CREATE_DATE CONSTRAINT CC_CIMLINK_CDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMLINK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMLINK ON BARS.CIM_LINK (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index CIMLINK_PAYMENT_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.CIMLINK_PAYMENT_IDX ON BARS.CIM_LINK (PAYMENT_ID, FANTOM_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index CIMLINK_VMD_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.CIMLINK_VMD_IDX ON BARS.CIM_LINK (VMD_ID, ACT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_LINK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_LINK        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_LINK        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_LINK        to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_LINK.sql =========*** End *** ====
PROMPT ===================================================================================== 
