

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CREDIT_TYPE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CREDIT_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CREDIT_TYPE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CIM_CREDIT_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CREDIT_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CREDIT_TYPE 
   (	ID NUMBER, 
	NAME VARCHAR2(128), 
	DELETE_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CREDIT_TYPE ***
 exec bpa.alter_policies('CIM_CREDIT_TYPE');


COMMENT ON TABLE BARS.CIM_CREDIT_TYPE IS 'Типи кредитів';
COMMENT ON COLUMN BARS.CIM_CREDIT_TYPE.ID IS 'ID типу кредиту';
COMMENT ON COLUMN BARS.CIM_CREDIT_TYPE.NAME IS 'Назва типу кредиту';
COMMENT ON COLUMN BARS.CIM_CREDIT_TYPE.DELETE_DATE IS 'Дата видалення';



/*
PROMPT *** Create  constraint PK_CIMCREDITTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDIT_TYPE ADD CONSTRAINT PK_CIMCREDITTYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMCREDITTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMCREDITTYPE ON BARS.CIM_CREDIT_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/
*/

begin   
 execute immediate '
    alter table cim_credit_type
      drop constraint PK_CIMCREDITTYPE cascade';
exception when others then
  if  sqlcode=-2443  then null; else raise; end if;
 end;
/
begin   
 execute immediate 'drop index PK_CIMCREDITTYPE';
exception when others then
  if  sqlcode=-1418  then null; else raise; end if;
 end;
/


begin
    execute immediate 'alter table cim_credit_type add open_date date';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin   
 execute immediate '
  ALTER TABLE BARS.cim_credit_type ADD CONSTRAINT PK_CIMCREDITTYPEIO PRIMARY KEY (ID, OPEN_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  CIM_CREDIT_TYPE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDIT_TYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CREDIT_TYPE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDIT_TYPE to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CREDIT_TYPE.sql =========*** End *
PROMPT ===================================================================================== 
