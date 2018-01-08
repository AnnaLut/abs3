

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_RECORD_STATE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_RECORD_STATE ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_RECORD_STATE 
   (	STATE NUMBER(2,0), 
	STATE_NAME VARCHAR2(300 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_RECORD_STATE IS '';
COMMENT ON COLUMN PFU.PFU_RECORD_STATE.STATE IS '';
COMMENT ON COLUMN PFU.PFU_RECORD_STATE.STATE_NAME IS '';




PROMPT *** Create  constraint PK_PFURERORDSTATE ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_RECORD_STATE ADD CONSTRAINT PK_PFURERORDSTATE PRIMARY KEY (STATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PFU_RECORD_STATE_NN ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_RECORD_STATE ADD CONSTRAINT CC_PFU_RECORD_STATE_NN CHECK (STATE IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PFU_RECORD_STATENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_RECORD_STATE ADD CONSTRAINT CC_PFU_RECORD_STATENAME_NN CHECK (STATE_NAME IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFURERORDSTATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFURERORDSTATE ON PFU.PFU_RECORD_STATE (STATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PFU_RECORD_STATE ***
grant SELECT                                                                 on PFU_RECORD_STATE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_RECORD_STATE.sql =========*** End *
PROMPT ===================================================================================== 
