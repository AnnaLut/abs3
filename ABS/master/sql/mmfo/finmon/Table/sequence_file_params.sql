

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/SEQUENCE_FILE_PARAMS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  table SEQUENCE_FILE_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE FINMON.SEQUENCE_FILE_PARAMS 
   (	BRANCH_ID VARCHAR2(15), 
	PAR VARCHAR2(15), 
	VAL VARCHAR2(255), 
	COMM VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.SEQUENCE_FILE_PARAMS IS '';
COMMENT ON COLUMN FINMON.SEQUENCE_FILE_PARAMS.BRANCH_ID IS '';
COMMENT ON COLUMN FINMON.SEQUENCE_FILE_PARAMS.PAR IS '';
COMMENT ON COLUMN FINMON.SEQUENCE_FILE_PARAMS.VAL IS '';
COMMENT ON COLUMN FINMON.SEQUENCE_FILE_PARAMS.COMM IS '';




PROMPT *** Create  constraint PK_SEQUENCE_FILE_PARAMS ***
begin   
 execute immediate '
  ALTER TABLE FINMON.SEQUENCE_FILE_PARAMS ADD CONSTRAINT PK_SEQUENCE_FILE_PARAMS PRIMARY KEY (BRANCH_ID, PAR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_SEQUENCE_FP_BRANCH_ID ***
begin   
 execute immediate '
  ALTER TABLE FINMON.SEQUENCE_FILE_PARAMS MODIFY (BRANCH_ID CONSTRAINT NK_SEQUENCE_FP_BRANCH_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_SEQUENCE_FP_PAR ***
begin   
 execute immediate '
  ALTER TABLE FINMON.SEQUENCE_FILE_PARAMS MODIFY (PAR CONSTRAINT NK_SEQUENCE_FP_PAR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SEQUENCE_FILE_PARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.PK_SEQUENCE_FILE_PARAMS ON FINMON.SEQUENCE_FILE_PARAMS (BRANCH_ID, PAR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SEQUENCE_FILE_PARAMS ***
grant SELECT                                                                 on SEQUENCE_FILE_PARAMS to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/SEQUENCE_FILE_PARAMS.sql =========**
PROMPT ===================================================================================== 
