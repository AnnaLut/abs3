

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/TRANSPORT_STATE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  table TRANSPORT_STATE ***
begin 
  execute immediate '
  CREATE TABLE PFU.TRANSPORT_STATE 
   (	ID NUMBER(1,0), 
	NAME VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.TRANSPORT_STATE IS 'Статуси по заявкам';
COMMENT ON COLUMN PFU.TRANSPORT_STATE.ID IS '';
COMMENT ON COLUMN PFU.TRANSPORT_STATE.NAME IS '';




PROMPT *** Create  constraint SYS_C00111481 ***
begin   
 execute immediate '
  ALTER TABLE PFU.TRANSPORT_STATE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111482 ***
begin   
 execute immediate '
  ALTER TABLE PFU.TRANSPORT_STATE MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TRANSPORT_STATE ***
grant SELECT                                                                 on TRANSPORT_STATE to BARSREADER_ROLE;
grant SELECT                                                                 on TRANSPORT_STATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TRANSPORT_STATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/TRANSPORT_STATE.sql =========*** End **
PROMPT ===================================================================================== 
