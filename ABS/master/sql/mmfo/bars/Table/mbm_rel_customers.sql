

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MBM_REL_CUSTOMERS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MBM_REL_CUSTOMERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MBM_REL_CUSTOMERS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MBM_REL_CUSTOMERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MBM_REL_CUSTOMERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.MBM_REL_CUSTOMERS 
   (	ID NUMBER, 
	TAX_CODE VARCHAR2(15), 
	FIRST_NAME VARCHAR2(200), 
	LAST_NAME VARCHAR2(200), 
	SECOND_NAME VARCHAR2(200), 
	DOC_TYPE VARCHAR2(10), 
	DOC_SERIES VARCHAR2(10), 
	DOC_NUMBER VARCHAR2(10), 
	DOC_ORGANIZATION VARCHAR2(300), 
	DOC_DATE DATE, 
	BIRTH_DATE DATE, 
	CREATED_DATE DATE DEFAULT sysdate, 
	CELL_PHONE VARCHAR2(20), 
	ADDRESS VARCHAR2(4000), 
	EMAIL VARCHAR2(100), 
	NO_INN NUMBER(1,0) DEFAULT 0, 
	ACSK_ACTUAL NUMBER(1,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MBM_REL_CUSTOMERS ***
 exec bpa.alter_policies('MBM_REL_CUSTOMERS');


COMMENT ON TABLE BARS.MBM_REL_CUSTOMERS IS 'Повязані особи котрим надано доступ до CorpLight';
COMMENT ON COLUMN BARS.MBM_REL_CUSTOMERS.NO_INN IS '';
COMMENT ON COLUMN BARS.MBM_REL_CUSTOMERS.ACSK_ACTUAL IS '';
COMMENT ON COLUMN BARS.MBM_REL_CUSTOMERS.ID IS '';
COMMENT ON COLUMN BARS.MBM_REL_CUSTOMERS.TAX_CODE IS '';
COMMENT ON COLUMN BARS.MBM_REL_CUSTOMERS.FIRST_NAME IS '';
COMMENT ON COLUMN BARS.MBM_REL_CUSTOMERS.LAST_NAME IS '';
COMMENT ON COLUMN BARS.MBM_REL_CUSTOMERS.SECOND_NAME IS '';
COMMENT ON COLUMN BARS.MBM_REL_CUSTOMERS.DOC_TYPE IS '';
COMMENT ON COLUMN BARS.MBM_REL_CUSTOMERS.DOC_SERIES IS '';
COMMENT ON COLUMN BARS.MBM_REL_CUSTOMERS.DOC_NUMBER IS '';
COMMENT ON COLUMN BARS.MBM_REL_CUSTOMERS.DOC_ORGANIZATION IS '';
COMMENT ON COLUMN BARS.MBM_REL_CUSTOMERS.DOC_DATE IS '';
COMMENT ON COLUMN BARS.MBM_REL_CUSTOMERS.BIRTH_DATE IS '';
COMMENT ON COLUMN BARS.MBM_REL_CUSTOMERS.CREATED_DATE IS '';
COMMENT ON COLUMN BARS.MBM_REL_CUSTOMERS.CELL_PHONE IS '';
COMMENT ON COLUMN BARS.MBM_REL_CUSTOMERS.ADDRESS IS '';
COMMENT ON COLUMN BARS.MBM_REL_CUSTOMERS.EMAIL IS '';




PROMPT *** Create  constraint CC_MBM_REL_CUST_NOINN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_REL_CUSTOMERS ADD CONSTRAINT CC_MBM_REL_CUST_NOINN_NN CHECK (NO_INN IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MBM_REL_CUST_ACSK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_REL_CUSTOMERS ADD CONSTRAINT CC_MBM_REL_CUST_ACSK_NN CHECK (ACSK_ACTUAL IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111415 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_REL_CUSTOMERS ADD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C00111415 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C00111415 ON BARS.MBM_REL_CUSTOMERS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-01408  then null; else raise; end if;
 end;
/

begin   
 execute immediate 'alter table MBM_REL_CUSTOMERS modify doc_number VARCHAR2(14)';
end;
/

PROMPT *** Create  grants  MBM_REL_CUSTOMERS ***
grant SELECT                                                                 on MBM_REL_CUSTOMERS to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on MBM_REL_CUSTOMERS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MBM_REL_CUSTOMERS to UPLD;


-- Add/modify columns 
begin
    execute immediate 'alter table MBM_REL_CUSTOMERS add doc_date_to DATE';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the columns 
comment on column MBM_REL_CUSTOMERS.doc_date_to
  is 'дата до якої дійсносна ID-картка';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MBM_REL_CUSTOMERS.sql =========*** End
PROMPT ===================================================================================== 
