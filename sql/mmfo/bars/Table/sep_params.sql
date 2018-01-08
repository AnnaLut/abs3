

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SEP_PARAMS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SEP_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SEP_PARAMS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SEP_PARAMS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SEP_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.SEP_PARAMS 
   (	PAR_NAME VARCHAR2(128), 
	PAR_VALUE VARCHAR2(4000), 
	PAR_COMMENT VARCHAR2(4000), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SEP_PARAMS ***
 exec bpa.alter_policies('SEP_PARAMS');


COMMENT ON TABLE BARS.SEP_PARAMS IS 'Параметри модуля SEP';
COMMENT ON COLUMN BARS.SEP_PARAMS.PAR_NAME IS 'Ім'я параметра';
COMMENT ON COLUMN BARS.SEP_PARAMS.PAR_VALUE IS 'Значення параметру';
COMMENT ON COLUMN BARS.SEP_PARAMS.PAR_COMMENT IS 'Коментар';
COMMENT ON COLUMN BARS.SEP_PARAMS.KF IS '';




PROMPT *** Create  constraint PK_SEPCONFIG ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_PARAMS ADD CONSTRAINT PK_SEPCONFIG PRIMARY KEY (PAR_NAME, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPCONFIG_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_PARAMS MODIFY (KF CONSTRAINT CC_SEPCONFIG_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPCONFIG_PARNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_PARAMS MODIFY (PAR_NAME CONSTRAINT CC_SEPCONFIG_PARNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SEPCONFIG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SEPCONFIG ON BARS.SEP_PARAMS (PAR_NAME, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SEP_PARAMS ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SEP_PARAMS      to BARS_ACCESS_DEFROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SEP_PARAMS      to TOSS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SEP_PARAMS.sql =========*** End *** ==
PROMPT ===================================================================================== 
