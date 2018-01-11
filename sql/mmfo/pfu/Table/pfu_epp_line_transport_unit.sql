

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_EPP_LINE_TRANSPORT_UNIT.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_EPP_LINE_TRANSPORT_UNIT ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_EPP_LINE_TRANSPORT_UNIT 
   (	TRANSPORT_UNIT_ID NUMBER(10,0), 
	LINE_ID NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_EPP_LINE_TRANSPORT_UNIT IS '';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_TRANSPORT_UNIT.TRANSPORT_UNIT_ID IS '';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_TRANSPORT_UNIT.LINE_ID IS '';




PROMPT *** Create  constraint SYS_C00111454 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_EPP_LINE_TRANSPORT_UNIT MODIFY (LINE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PFU_EPP_LINE_TRANSPORT_UNIT ***
grant SELECT                                                                 on PFU_EPP_LINE_TRANSPORT_UNIT to BARSREADER_ROLE;
grant SELECT                                                                 on PFU_EPP_LINE_TRANSPORT_UNIT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_EPP_LINE_TRANSPORT_UNIT.sql =======
PROMPT ===================================================================================== 
