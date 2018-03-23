

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CREDIT_BORROWER.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CREDIT_BORROWER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CREDIT_BORROWER'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CREDIT_BORROWER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CREDIT_BORROWER ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CREDIT_BORROWER 
   (	ID NUMBER, 
	NAME VARCHAR2(256), 
	DELETE_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CREDIT_BORROWER ***
 exec bpa.alter_policies('CIM_CREDIT_BORROWER');


COMMENT ON TABLE BARS.CIM_CREDIT_BORROWER IS '��� ������������';
COMMENT ON COLUMN BARS.CIM_CREDIT_BORROWER.ID IS 'ID ���� ������������';
COMMENT ON COLUMN BARS.CIM_CREDIT_BORROWER.NAME IS '����� ���� ������������';
COMMENT ON COLUMN BARS.CIM_CREDIT_BORROWER.DELETE_DATE IS '���� ���������';




/*
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDIT_BORROWER ADD CONSTRAINT PK_CIMCREDITBORROWER PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMCREDITBORROWER ON BARS.CIM_CREDIT_BORROWER (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

*/

-- Drop primary, unique and foreign key constraints 
begin   
 execute immediate '
    alter table CIM_CREDIT_BORROWER
      drop constraint PK_CIMCREDITBORROWER cascade';
exception when others then
  if  sqlcode=-2443  then null; else raise; end if;
 end;
/


begin
    execute immediate 'alter table CIM_CREDIT_BORROWER add open_date date';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDIT_BORROWER ADD CONSTRAINT PK_CIMCREDITBORROWERIO PRIMARY KEY (ID, OPEN_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  CIM_CREDIT_BORROWER ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDIT_BORROWER to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CREDIT_BORROWER to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDIT_BORROWER to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CREDIT_BORROWER.sql =========*** E
PROMPT ===================================================================================== 
