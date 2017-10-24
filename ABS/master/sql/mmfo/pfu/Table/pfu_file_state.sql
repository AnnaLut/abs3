

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_FILE_STATE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_FILE_STATE ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_FILE_STATE 
   (	STATE VARCHAR2(30 CHAR), 
	STATE_NAME VARCHAR2(300 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_FILE_STATE IS '';
COMMENT ON COLUMN PFU.PFU_FILE_STATE.STATE IS '';
COMMENT ON COLUMN PFU.PFU_FILE_STATE.STATE_NAME IS '';




PROMPT *** Create  constraint PK_PFUFILESTATE ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_FILE_STATE ADD CONSTRAINT PK_PFUFILESTATE PRIMARY KEY (STATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PFUFILE_STATE_NN ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_FILE_STATE ADD CONSTRAINT CC_PFUFILE_STATE_NN CHECK (STATE IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PFUFILE_STATENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_FILE_STATE ADD CONSTRAINT CC_PFUFILE_STATENAME_NN CHECK (STATE_NAME IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFUFILESTATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFUFILESTATE ON PFU.PFU_FILE_STATE (STATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_FILE_STATE.sql =========*** End ***
PROMPT ===================================================================================== 
