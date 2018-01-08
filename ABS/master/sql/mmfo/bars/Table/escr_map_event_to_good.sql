

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ESCR_MAP_EVENT_TO_GOOD.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ESCR_MAP_EVENT_TO_GOOD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ESCR_MAP_EVENT_TO_GOOD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ESCR_MAP_EVENT_TO_GOOD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ESCR_MAP_EVENT_TO_GOOD ***
begin 
  execute immediate '
  CREATE TABLE BARS.ESCR_MAP_EVENT_TO_GOOD 
   (	ID NUMBER, 
	EVENT_ID NUMBER, 
	GOOD_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ESCR_MAP_EVENT_TO_GOOD ***
 exec bpa.alter_policies('ESCR_MAP_EVENT_TO_GOOD');


COMMENT ON TABLE BARS.ESCR_MAP_EVENT_TO_GOOD IS '';
COMMENT ON COLUMN BARS.ESCR_MAP_EVENT_TO_GOOD.ID IS '';
COMMENT ON COLUMN BARS.ESCR_MAP_EVENT_TO_GOOD.EVENT_ID IS '';
COMMENT ON COLUMN BARS.ESCR_MAP_EVENT_TO_GOOD.GOOD_ID IS '';




PROMPT *** Create  constraint SYS_C00118577 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_MAP_EVENT_TO_GOOD MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118578 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_MAP_EVENT_TO_GOOD MODIFY (EVENT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118579 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_MAP_EVENT_TO_GOOD MODIFY (GOOD_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_METG_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_MAP_EVENT_TO_GOOD ADD CONSTRAINT PK_METG_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_EVENT_GOOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_MAP_EVENT_TO_GOOD ADD CONSTRAINT UK_EVENT_GOOD UNIQUE (EVENT_ID, GOOD_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_METG_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_METG_ID ON BARS.ESCR_MAP_EVENT_TO_GOOD (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_EVENT_GOOD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_EVENT_GOOD ON BARS.ESCR_MAP_EVENT_TO_GOOD (EVENT_ID, GOOD_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ESCR_MAP_EVENT_TO_GOOD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ESCR_MAP_EVENT_TO_GOOD to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ESCR_MAP_EVENT_TO_GOOD.sql =========**
PROMPT ===================================================================================== 
