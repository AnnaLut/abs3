

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CREDIT_METHOD.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CREDIT_METHOD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CREDIT_METHOD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CREDIT_METHOD'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CIM_CREDIT_METHOD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CREDIT_METHOD ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CREDIT_METHOD 
   (	ID NUMBER, 
	NAME VARCHAR2(64)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CREDIT_METHOD ***
 exec bpa.alter_policies('CIM_CREDIT_METHOD');


COMMENT ON TABLE BARS.CIM_CREDIT_METHOD IS 'Метод погашення кредиту';
COMMENT ON COLUMN BARS.CIM_CREDIT_METHOD.ID IS 'ID методу';
COMMENT ON COLUMN BARS.CIM_CREDIT_METHOD.NAME IS 'Назва методу';




PROMPT *** Create  constraint PK_CIMCREDITMETHOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDIT_METHOD ADD CONSTRAINT PK_CIMCREDITMETHOD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMCREDITMETHOD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMCREDITMETHOD ON BARS.CIM_CREDIT_METHOD (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_CREDIT_METHOD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDIT_METHOD to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CREDIT_METHOD to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDIT_METHOD to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CREDIT_METHOD.sql =========*** End
PROMPT ===================================================================================== 
