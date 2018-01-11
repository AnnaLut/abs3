

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CREDIT_BASE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CREDIT_BASE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CREDIT_BASE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CREDIT_BASE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CREDIT_BASE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CREDIT_BASE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CREDIT_BASE 
   (	ID NUMBER, 
	NAME VARCHAR2(16)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CREDIT_BASE ***
 exec bpa.alter_policies('CIM_CREDIT_BASE');


COMMENT ON TABLE BARS.CIM_CREDIT_BASE IS 'База нарахування відсотків';
COMMENT ON COLUMN BARS.CIM_CREDIT_BASE.ID IS 'ID';
COMMENT ON COLUMN BARS.CIM_CREDIT_BASE.NAME IS 'Назва';




PROMPT *** Create  constraint PK_CIMCREDITBASE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDIT_BASE ADD CONSTRAINT PK_CIMCREDITBASE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMCREDITBASE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMCREDITBASE ON BARS.CIM_CREDIT_BASE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_CREDIT_BASE ***
grant SELECT                                                                 on CIM_CREDIT_BASE to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDIT_BASE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CREDIT_BASE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDIT_BASE to CIM_ROLE;
grant SELECT                                                                 on CIM_CREDIT_BASE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CREDIT_BASE.sql =========*** End *
PROMPT ===================================================================================== 
