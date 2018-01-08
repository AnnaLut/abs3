

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CREDIT_ADAPTIVE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CREDIT_ADAPTIVE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CREDIT_ADAPTIVE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CREDIT_ADAPTIVE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CREDIT_ADAPTIVE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CREDIT_ADAPTIVE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CREDIT_ADAPTIVE 
   (	ID NUMBER, 
	NAME VARCHAR2(64)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CREDIT_ADAPTIVE ***
 exec bpa.alter_policies('CIM_CREDIT_ADAPTIVE');


COMMENT ON TABLE BARS.CIM_CREDIT_ADAPTIVE IS 'Метод ліквідації дострокового погашення тіла кредиту';
COMMENT ON COLUMN BARS.CIM_CREDIT_ADAPTIVE.ID IS 'ID';
COMMENT ON COLUMN BARS.CIM_CREDIT_ADAPTIVE.NAME IS 'Назва';




PROMPT *** Create  constraint PK_CIMCREDITADAPTIVE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CREDIT_ADAPTIVE ADD CONSTRAINT PK_CIMCREDITADAPTIVE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMCREDITADAPTIVE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMCREDITADAPTIVE ON BARS.CIM_CREDIT_ADAPTIVE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_CREDIT_ADAPTIVE ***
grant SELECT                                                                 on CIM_CREDIT_ADAPTIVE to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDIT_ADAPTIVE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CREDIT_ADAPTIVE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDIT_ADAPTIVE to CIM_ROLE;
grant SELECT                                                                 on CIM_CREDIT_ADAPTIVE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CREDIT_ADAPTIVE.sql =========*** E
PROMPT ===================================================================================== 
