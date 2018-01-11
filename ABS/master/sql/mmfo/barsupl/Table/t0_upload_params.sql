

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/T0_UPLOAD_PARAMS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  table T0_UPLOAD_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.T0_UPLOAD_PARAMS 
   (	PARAM_ID NUMBER(2,0), 
	PARAM_NAME VARCHAR2(35), 
	PARAM_DESC VARCHAR2(500), 
	OBJECT_ID NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.T0_UPLOAD_PARAMS IS '';
COMMENT ON COLUMN BARSUPL.T0_UPLOAD_PARAMS.PARAM_ID IS '';
COMMENT ON COLUMN BARSUPL.T0_UPLOAD_PARAMS.PARAM_NAME IS '';
COMMENT ON COLUMN BARSUPL.T0_UPLOAD_PARAMS.PARAM_DESC IS '';
COMMENT ON COLUMN BARSUPL.T0_UPLOAD_PARAMS.OBJECT_ID IS '';




PROMPT *** Create  constraint PK_T0UPLOADPARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.T0_UPLOAD_PARAMS ADD CONSTRAINT PK_T0UPLOADPARAMS PRIMARY KEY (PARAM_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_T0UPLOADPARAMS_PARAMID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.T0_UPLOAD_PARAMS MODIFY (PARAM_ID CONSTRAINT CC_T0UPLOADPARAMS_PARAMID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_T0UPLOADPARAMS_PARAMNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.T0_UPLOAD_PARAMS MODIFY (PARAM_NAME CONSTRAINT CC_T0UPLOADPARAMS_PARAMNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_T0UPLOADPARAMS_PARAMDESC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.T0_UPLOAD_PARAMS MODIFY (PARAM_DESC CONSTRAINT CC_T0UPLOADPARAMS_PARAMDESC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_T0UPLOADPARAMS_OBJECTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.T0_UPLOAD_PARAMS MODIFY (OBJECT_ID CONSTRAINT CC_T0UPLOADPARAMS_OBJECTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_T0UPLOADPARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_T0UPLOADPARAMS ON BARSUPL.T0_UPLOAD_PARAMS (PARAM_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  T0_UPLOAD_PARAMS ***
grant SELECT                                                                 on T0_UPLOAD_PARAMS to BARSREADER_ROLE;
grant SELECT                                                                 on T0_UPLOAD_PARAMS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/T0_UPLOAD_PARAMS.sql =========*** E
PROMPT ===================================================================================== 
