

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_PARAMETER.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_PARAMETER ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_PARAMETER 
   (	KEY VARCHAR2(30 CHAR), 
	VALUE VARCHAR2(4000), 
	NAME VARCHAR2(300 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_PARAMETER IS '';
COMMENT ON COLUMN PFU.PFU_PARAMETER.KEY IS '';
COMMENT ON COLUMN PFU.PFU_PARAMETER.VALUE IS '';
COMMENT ON COLUMN PFU.PFU_PARAMETER.NAME IS '';




PROMPT *** Create  constraint PK_PFU_PARAMETER ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_PARAMETER ADD CONSTRAINT PK_PFU_PARAMETER PRIMARY KEY (KEY)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111453 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_PARAMETER MODIFY (KEY NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFU_PARAMETER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFU_PARAMETER ON PFU.PFU_PARAMETER (KEY) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_PARAMETER.sql =========*** End *** 
PROMPT ===================================================================================== 
