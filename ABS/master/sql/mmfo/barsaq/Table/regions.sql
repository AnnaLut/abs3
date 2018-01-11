

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/REGIONS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  table REGIONS ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.REGIONS 
   (	ID NUMBER, 
	CODE CHAR(2), 
	NAME VARCHAR2(100), 
	KF VARCHAR2(6), 
	SORT_ID NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.REGIONS IS '';
COMMENT ON COLUMN BARSAQ.REGIONS.ID IS '';
COMMENT ON COLUMN BARSAQ.REGIONS.CODE IS '';
COMMENT ON COLUMN BARSAQ.REGIONS.NAME IS '';
COMMENT ON COLUMN BARSAQ.REGIONS.KF IS '';
COMMENT ON COLUMN BARSAQ.REGIONS.SORT_ID IS '';




PROMPT *** Create  constraint SYS_C00109673 ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.REGIONS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_REGIONS ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.REGIONS ADD CONSTRAINT XPK_REGIONS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_REGIONS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.XPK_REGIONS ON BARSAQ.REGIONS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REGIONS ***
grant SELECT                                                                 on REGIONS         to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/REGIONS.sql =========*** End *** ===
PROMPT ===================================================================================== 
