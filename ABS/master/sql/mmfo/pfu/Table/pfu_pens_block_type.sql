

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_PENS_BLOCK_TYPE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_PENS_BLOCK_TYPE ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_PENS_BLOCK_TYPE 
   (	ID NUMBER, 
	NAME VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_PENS_BLOCK_TYPE IS 'Типы блокировок пнесионеров';
COMMENT ON COLUMN PFU.PFU_PENS_BLOCK_TYPE.ID IS '';
COMMENT ON COLUMN PFU.PFU_PENS_BLOCK_TYPE.NAME IS '';




PROMPT *** Create  constraint SYS_C00111483 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_PENS_BLOCK_TYPE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PENSBLKTYPE ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_PENS_BLOCK_TYPE ADD CONSTRAINT PK_PENSBLKTYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PENSBLKTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PENSBLKTYPE ON PFU.PFU_PENS_BLOCK_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_PENS_BLOCK_TYPE.sql =========*** En
PROMPT ===================================================================================== 
