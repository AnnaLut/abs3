

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR_MODULES.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR_MODULES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ERR_MODULES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ERR_MODULES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ERR_MODULES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR_MODULES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR_MODULES 
   (	ERRMOD_CODE VARCHAR2(3), 
	ERRMOD_NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 1 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR_MODULES ***
 exec bpa.alter_policies('ERR_MODULES');


COMMENT ON TABLE BARS.ERR_MODULES IS 'Модуль ошибки';
COMMENT ON COLUMN BARS.ERR_MODULES.ERRMOD_CODE IS 'Код модуля';
COMMENT ON COLUMN BARS.ERR_MODULES.ERRMOD_NAME IS 'Название модуля';




PROMPT *** Create  constraint PK_ERRMODULES ***
begin   
 execute immediate '
  ALTER TABLE BARS.ERR_MODULES ADD CONSTRAINT PK_ERRMODULES PRIMARY KEY (ERRMOD_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ERRMODULES_ERRMODCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ERR_MODULES MODIFY (ERRMOD_CODE CONSTRAINT CC_ERRMODULES_ERRMODCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ERRMODULES_ERRMODNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ERR_MODULES MODIFY (ERRMOD_NAME CONSTRAINT CC_ERRMODULES_ERRMODNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ERRMODULES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ERRMODULES ON BARS.ERR_MODULES (ERRMOD_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ERR_MODULES ***
grant SELECT                                                                 on ERR_MODULES     to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ERR_MODULES     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR_MODULES.sql =========*** End *** =
PROMPT ===================================================================================== 
