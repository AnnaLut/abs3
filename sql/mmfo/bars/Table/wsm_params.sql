

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WSM_PARAMS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WSM_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WSM_PARAMS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WSM_PARAMS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WSM_PARAMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WSM_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WSM_PARAMS 
   (	PAR_NAME VARCHAR2(128), 
	PAR_VALUE VARCHAR2(4000), 
	PAR_COMMENT VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WSM_PARAMS ***
 exec bpa.alter_policies('WSM_PARAMS');


COMMENT ON TABLE BARS.WSM_PARAMS IS 'Параметри модуля WSM';
COMMENT ON COLUMN BARS.WSM_PARAMS.PAR_NAME IS 'Ім'я параметра';
COMMENT ON COLUMN BARS.WSM_PARAMS.PAR_VALUE IS 'Значення параметру';
COMMENT ON COLUMN BARS.WSM_PARAMS.PAR_COMMENT IS 'Коментар';




PROMPT *** Create  constraint PK_WSMPARAM ***
begin   
 execute immediate '
  ALTER TABLE BARS.WSM_PARAMS ADD CONSTRAINT PK_WSMPARAM PRIMARY KEY (PAR_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WSMPARAM_PARNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WSM_PARAMS MODIFY (PAR_NAME CONSTRAINT CC_WSMPARAM_PARNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WSMPARAM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WSMPARAM ON BARS.WSM_PARAMS (PAR_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WSM_PARAMS ***
grant SELECT                                                                 on WSM_PARAMS      to BARSREADER_ROLE;
grant SELECT                                                                 on WSM_PARAMS      to BARS_DM;
grant SELECT                                                                 on WSM_PARAMS      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WSM_PARAMS.sql =========*** End *** ==
PROMPT ===================================================================================== 
