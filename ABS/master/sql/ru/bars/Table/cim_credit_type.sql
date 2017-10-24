

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CREDIT_TYPE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CREDIT_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CREDIT_TYPE'', ''FILIAL'' , null, null, null, null);
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


COMMENT ON TABLE BARS.CIM_CREDIT_TYPE IS '���� �������';
COMMENT ON COLUMN BARS.CIM_CREDIT_TYPE.ID IS 'ID ���� �������';
COMMENT ON COLUMN BARS.CIM_CREDIT_TYPE.NAME IS '����� ���� �������';
COMMENT ON COLUMN BARS.CIM_CREDIT_TYPE.DELETE_DATE IS '���� ���������';




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



PROMPT *** Create  grants  CIM_CREDIT_TYPE ***
grant SELECT                                                                 on CIM_CREDIT_TYPE to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDIT_TYPE to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CREDIT_TYPE.sql =========*** End *
PROMPT ===================================================================================== 
