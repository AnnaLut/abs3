

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_APE_SERVICECODE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_APE_SERVICECODE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_APE_SERVICECODE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_APE_SERVICECODE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_APE_SERVICECODE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_APE_SERVICECODE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_APE_SERVICECODE 
   (	CODE_ID VARCHAR2(7), 
	CODE_NAME VARCHAR2(2300), 
	DELETE_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_APE_SERVICECODE ***
 exec bpa.alter_policies('CIM_APE_SERVICECODE');


COMMENT ON TABLE BARS.CIM_APE_SERVICECODE IS 'Коди класифікатора послуг';
COMMENT ON COLUMN BARS.CIM_APE_SERVICECODE.CODE_ID IS 'ID коду';
COMMENT ON COLUMN BARS.CIM_APE_SERVICECODE.CODE_NAME IS 'Назва коду';
COMMENT ON COLUMN BARS.CIM_APE_SERVICECODE.DELETE_DATE IS 'Дата видалення';




PROMPT *** Create  constraint PK_CIMAPESC_CODEID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_APE_SERVICECODE ADD CONSTRAINT PK_CIMAPESC_CODEID PRIMARY KEY (CODE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMAPESC_CODEID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMAPESC_CODEID ON BARS.CIM_APE_SERVICECODE (CODE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_APE_SERVICECODE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_APE_SERVICECODE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_APE_SERVICECODE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_APE_SERVICECODE to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_APE_SERVICECODE.sql =========*** E
PROMPT ===================================================================================== 
