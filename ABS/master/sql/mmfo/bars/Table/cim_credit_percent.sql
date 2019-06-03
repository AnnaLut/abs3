

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CREDIT_PERCENT.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CREDIT_PERCENT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CREDIT_PERCENT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CREDIT_PERCENT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CREDIT_PERCENT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CREDIT_PERCENT ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CREDIT_PERCENT 
   (	ID VARCHAR2(2), 
	NAME VARCHAR2(64),
        D_OPEN DATE,
        D_CLOSE DATE,
        D_MODI DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CREDIT_PERCENT ***
 exec bpa.alter_policies('CIM_CREDIT_PERCENT');


COMMENT ON TABLE BARS.CIM_CREDIT_PERCENT IS 'Назви процентних ставок НБУ';
COMMENT ON COLUMN BARS.CIM_CREDIT_PERCENT.ID IS 'ID назви процентної ставки НБУ';
COMMENT ON COLUMN BARS.CIM_CREDIT_PERCENT.NAME IS 'Назва процентної ставки НБУ';




PROMPT *** Create  constraint PK_CIMCREDITPERCENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDIT_PERCENT ADD CONSTRAINT PK_CIMCREDITPERCENT PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMCREDITPERCENT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMCREDITPERCENT ON BARS.CIM_CREDIT_PERCENT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_CREDIT_PERCENT ***
grant SELECT                                                                 on CIM_CREDIT_PERCENT to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDIT_PERCENT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CREDIT_PERCENT to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDIT_PERCENT to CIM_ROLE;
grant SELECT                                                                 on CIM_CREDIT_PERCENT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CREDIT_PERCENT.sql =========*** En
PROMPT ===================================================================================== 
