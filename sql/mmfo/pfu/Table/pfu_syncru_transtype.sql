

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_SYNCRU_TRANSTYPE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_SYNCRU_TRANSTYPE ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_SYNCRU_TRANSTYPE 
   (	TRANSFER_TYPE VARCHAR2(20), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_SYNCRU_TRANSTYPE IS '';
COMMENT ON COLUMN PFU.PFU_SYNCRU_TRANSTYPE.TRANSFER_TYPE IS '';
COMMENT ON COLUMN PFU.PFU_SYNCRU_TRANSTYPE.NAME IS '';




PROMPT *** Create  constraint SYS_C00111491 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SYNCRU_TRANSTYPE MODIFY (TRANSFER_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PFUSYNCRUTRANSTYPE ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SYNCRU_TRANSTYPE ADD CONSTRAINT PK_PFUSYNCRUTRANSTYPE PRIMARY KEY (TRANSFER_TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFUSYNCRUTRANSTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFUSYNCRUTRANSTYPE ON PFU.PFU_SYNCRU_TRANSTYPE (TRANSFER_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_SYNCRU_TRANSTYPE.sql =========*** E
PROMPT ===================================================================================== 
