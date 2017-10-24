

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_MASTER.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_MASTER ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_MASTER 
   (	MASTER_ID NUMBER, 
	DESCRIPT VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_MASTER IS '';
COMMENT ON COLUMN BARSUPL.UPL_MASTER.MASTER_ID IS '';
COMMENT ON COLUMN BARSUPL.UPL_MASTER.DESCRIPT IS '';




PROMPT *** Create  constraint UPL_MASTER_MASTERID ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_MASTER ADD CONSTRAINT UPL_MASTER_MASTERID PRIMARY KEY (MASTER_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UPL_MASTER_MASTERID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.UPL_MASTER_MASTERID ON BARSUPL.UPL_MASTER (MASTER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_MASTER.sql =========*** End ***
PROMPT ===================================================================================== 
