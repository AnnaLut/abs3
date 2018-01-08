

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CONTRACT_DEADLINES.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CONTRACT_DEADLINES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CONTRACT_DEADLINES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CONTRACT_DEADLINES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CONTRACT_DEADLINES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CONTRACT_DEADLINES ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CONTRACT_DEADLINES 
   (	DEADLINE NUMBER, 
	COMMENTS VARCHAR2(128), 
	DELETE_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CONTRACT_DEADLINES ***
 exec bpa.alter_policies('CIM_CONTRACT_DEADLINES');


COMMENT ON TABLE BARS.CIM_CONTRACT_DEADLINES IS 'Контрольні строки по торгових контрактах version 1.0';
COMMENT ON COLUMN BARS.CIM_CONTRACT_DEADLINES.DEADLINE IS 'Контрольний строк';
COMMENT ON COLUMN BARS.CIM_CONTRACT_DEADLINES.COMMENTS IS 'Коментар';
COMMENT ON COLUMN BARS.CIM_CONTRACT_DEADLINES.DELETE_DATE IS 'Дата видалення';




PROMPT *** Create  constraint PK_CIMCONTRDEADLINES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACT_DEADLINES ADD CONSTRAINT PK_CIMCONTRDEADLINES PRIMARY KEY (DEADLINE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMCONTRDEADLINES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMCONTRDEADLINES ON BARS.CIM_CONTRACT_DEADLINES (DEADLINE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_CONTRACT_DEADLINES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONTRACT_DEADLINES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CONTRACT_DEADLINES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONTRACT_DEADLINES to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CONTRACT_DEADLINES.sql =========**
PROMPT ===================================================================================== 
