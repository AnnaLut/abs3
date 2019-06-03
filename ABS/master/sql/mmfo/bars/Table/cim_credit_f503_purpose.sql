

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CREDIT_F503_PURPOSE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CREDIT_F503_PURPOSE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CREDIT_F503_PURPOSE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CREDIT_F503_PURPOSE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CREDIT_F503_PURPOSE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CREDIT_F503_PURPOSE 
   (	ID VARCHAR2(2), 
	NAME VARCHAR2(100), 
	D_OPEN DATE,
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CREDIT_F503_PURPOSE ***
 exec bpa.alter_policies('CIM_CREDIT_F503_PURPOSE');


COMMENT ON TABLE BARS.CIM_CREDIT_F503_PURPOSE IS 'Ціль використання кредиту F050';
COMMENT ON COLUMN BARS.CIM_CREDIT_F503_PURPOSE.ID IS 'ID цілі використання кредиту';
COMMENT ON COLUMN BARS.CIM_CREDIT_F503_PURPOSE.NAME IS 'Ціль використання кредиту';


PROMPT *** Create  constraint SYS_C00109173 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDIT_F503_PURPOSE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CIMCREDIT_F503PURPOSE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDIT_F503_PURPOSE ADD CONSTRAINT PK_CIMCREDIT_F503PURPOSE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMCREDIT_F503PURPOSE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMCREDIT_F503PURPOSE ON BARS.CIM_CREDIT_F503_PURPOSE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_CREDIT_F503_PURPOSE ***
grant SELECT                                                                 on CIM_CREDIT_F503_PURPOSE to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDIT_F503_PURPOSE to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDIT_F503_PURPOSE to CIM_ROLE;
grant SELECT                                                                 on CIM_CREDIT_F503_PURPOSE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CREDIT_F503_PURPOSE.sql =========*
PROMPT ===================================================================================== 
