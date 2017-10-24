

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CONCLUSION_ORG.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CONCLUSION_ORG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CONCLUSION_ORG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CONCLUSION_ORG'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CIM_CONCLUSION_ORG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CONCLUSION_ORG ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CONCLUSION_ORG 
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




PROMPT *** ALTER_POLICIES to CIM_CONCLUSION_ORG ***
 exec bpa.alter_policies('CIM_CONCLUSION_ORG');


COMMENT ON TABLE BARS.CIM_CONCLUSION_ORG IS 'Органи, які видають висновки';
COMMENT ON COLUMN BARS.CIM_CONCLUSION_ORG.ID IS 'ID органу';
COMMENT ON COLUMN BARS.CIM_CONCLUSION_ORG.NAME IS 'Назва органу';
COMMENT ON COLUMN BARS.CIM_CONCLUSION_ORG.DELETE_DATE IS 'Дата видалення';




PROMPT *** Create  constraint PK_CIMCONCLUSIONORG ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONCLUSION_ORG ADD CONSTRAINT PK_CIMCONCLUSIONORG PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMCONCLUSIONORG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMCONCLUSIONORG ON BARS.CIM_CONCLUSION_ORG (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_CONCLUSION_ORG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONCLUSION_ORG to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CONCLUSION_ORG to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONCLUSION_ORG to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CONCLUSION_ORG.sql =========*** En
PROMPT ===================================================================================== 
