

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CREDITOR_TYPE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CREDITOR_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CREDITOR_TYPE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CIM_CREDITOR_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CREDITOR_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CREDITOR_TYPE 
   (	ID NUMBER, 
	NAME VARCHAR2(64), 
	DELETE_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CREDITOR_TYPE ***
 exec bpa.alter_policies('CIM_CREDITOR_TYPE');


COMMENT ON TABLE BARS.CIM_CREDITOR_TYPE IS 'Типи кредиторів';
COMMENT ON COLUMN BARS.CIM_CREDITOR_TYPE.ID IS 'ID типу кредитора';
COMMENT ON COLUMN BARS.CIM_CREDITOR_TYPE.NAME IS 'Назва типу кредитора';
COMMENT ON COLUMN BARS.CIM_CREDITOR_TYPE.DELETE_DATE IS 'Дата видалення';



/*
PROMPT *** Create  constraint PK_CIMCREDITORTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDITOR_TYPE ADD CONSTRAINT PK_CIMCREDITORTYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMCREDITORTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMCREDITORTYPE ON BARS.CIM_CREDITOR_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/
*/
begin   
 execute immediate '
    alter table cim_creditor_type
      drop constraint PK_CIMCREDITORTYPE cascade';
exception when others then
  if  sqlcode=-2443  then null; else raise; end if;
 end;
/
begin   
 execute immediate 'drop index PK_CIMCREDITORTYPE';
exception when others then
  if  sqlcode=-1418  then null; else raise; end if;
 end;
/


begin
    execute immediate 'alter table cim_creditor_type add open_date date';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin   
 execute immediate '
  ALTER TABLE BARS.cim_creditor_type ADD CONSTRAINT PK_CIMCREDITORTYPEIO PRIMARY KEY (ID, OPEN_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  CIM_CREDITOR_TYPE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDITOR_TYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CREDITOR_TYPE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDITOR_TYPE to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CREDITOR_TYPE.sql =========*** End
PROMPT ===================================================================================== 
