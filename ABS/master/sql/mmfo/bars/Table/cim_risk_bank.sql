

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_RISK_BANK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_RISK_BANK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_RISK_BANK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_RISK_BANK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_RISK_BANK ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_RISK_BANK 
   (	B010 VARCHAR2(10)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_RISK_BANK ***
 exec bpa.alter_policies('CIM_RISK_BANK');


COMMENT ON TABLE BARS.CIM_RISK_BANK IS 'Список кодів ризикових банків v 1.00.00';
COMMENT ON COLUMN BARS.CIM_RISK_BANK.B010 IS 'Код B010 банку';




PROMPT *** Create  constraint SYS_C00111294 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_RISK_BANK MODIFY (B010 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CIMRISKBANK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_RISK_BANK ADD CONSTRAINT PK_CIMRISKBANK PRIMARY KEY (B010)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMRISKBANK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMRISKBANK ON BARS.CIM_RISK_BANK (B010) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_RISK_BANK ***
grant SELECT                                                                 on CIM_RISK_BANK   to BARSREADER_ROLE;
grant SELECT                                                                 on CIM_RISK_BANK   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_RISK_BANK.sql =========*** End ***
PROMPT ===================================================================================== 
