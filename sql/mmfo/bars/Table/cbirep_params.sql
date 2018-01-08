

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CBIREP_PARAMS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CBIREP_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CBIREP_PARAMS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CBIREP_PARAMS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CBIREP_PARAMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CBIREP_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CBIREP_PARAMS 
   (	NAME VARCHAR2(128), 
	VALUE VARCHAR2(4000), 
	DESCRIPTION VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CBIREP_PARAMS ***
 exec bpa.alter_policies('CBIREP_PARAMS');


COMMENT ON TABLE BARS.CBIREP_PARAMS IS 'Параметри модуля CBIREP version 1.0';
COMMENT ON COLUMN BARS.CBIREP_PARAMS.NAME IS 'Ім'я параметра';
COMMENT ON COLUMN BARS.CBIREP_PARAMS.VALUE IS 'Значення параметру';
COMMENT ON COLUMN BARS.CBIREP_PARAMS.DESCRIPTION IS 'Коментар';




PROMPT *** Create  constraint PK_CBIREPPARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_PARAMS ADD CONSTRAINT PK_CBIREPPARAMS PRIMARY KEY (NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CBIREPPARAMS_PARNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_PARAMS MODIFY (NAME CONSTRAINT CC_CBIREPPARAMS_PARNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CBIREPPARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CBIREPPARAMS ON BARS.CBIREP_PARAMS (NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CBIREP_PARAMS ***
grant SELECT                                                                 on CBIREP_PARAMS   to BARSREADER_ROLE;
grant SELECT                                                                 on CBIREP_PARAMS   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CBIREP_PARAMS   to BARS_DM;
grant SELECT                                                                 on CBIREP_PARAMS   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CBIREP_PARAMS.sql =========*** End ***
PROMPT ===================================================================================== 
