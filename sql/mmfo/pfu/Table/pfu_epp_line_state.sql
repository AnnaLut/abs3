

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_EPP_LINE_STATE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_EPP_LINE_STATE ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_EPP_LINE_STATE 
   (	ID NUMBER(5,0), 
	NAME VARCHAR2(500)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_EPP_LINE_STATE IS 'Статусы обработки записей ЕПП';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_STATE.ID IS '';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_STATE.NAME IS '';




PROMPT *** Create  constraint SYS_C00111487 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_EPP_LINE_STATE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111488 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_EPP_LINE_STATE MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint PK_PFU_EPP_LINE_STATE ***
begin
    execute immediate 'alter table PFU_EPP_LINE_STATE
  add constraint PK_PFU_EPP_LINE_STATE primary key (ID)';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/

PROMPT *** Create  grants  PFU_EPP_LINE_STATE ***
grant SELECT                                                                 on PFU_EPP_LINE_STATE to BARSREADER_ROLE;
grant SELECT                                                                 on PFU_EPP_LINE_STATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PFU_EPP_LINE_STATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_EPP_LINE_STATE.sql =========*** End
PROMPT ===================================================================================== 
