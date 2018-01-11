

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ESCR_MAP_EVENT_TO_BUILD_TYPE.sql =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ESCR_MAP_EVENT_TO_BUILD_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ESCR_MAP_EVENT_TO_BUILD_TYPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ESCR_MAP_EVENT_TO_BUILD_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ESCR_MAP_EVENT_TO_BUILD_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ESCR_MAP_EVENT_TO_BUILD_TYPE 
   (	ID NUMBER, 
	EVENT_ID NUMBER, 
	BUILD_TYPE_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ESCR_MAP_EVENT_TO_BUILD_TYPE ***
 exec bpa.alter_policies('ESCR_MAP_EVENT_TO_BUILD_TYPE');


COMMENT ON TABLE BARS.ESCR_MAP_EVENT_TO_BUILD_TYPE IS '';
COMMENT ON COLUMN BARS.ESCR_MAP_EVENT_TO_BUILD_TYPE.ID IS '';
COMMENT ON COLUMN BARS.ESCR_MAP_EVENT_TO_BUILD_TYPE.EVENT_ID IS '';
COMMENT ON COLUMN BARS.ESCR_MAP_EVENT_TO_BUILD_TYPE.BUILD_TYPE_ID IS '';




PROMPT *** Create  constraint SYS_C00118582 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_MAP_EVENT_TO_BUILD_TYPE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118583 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_MAP_EVENT_TO_BUILD_TYPE MODIFY (EVENT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118584 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_MAP_EVENT_TO_BUILD_TYPE MODIFY (BUILD_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint METB_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_MAP_EVENT_TO_BUILD_TYPE ADD CONSTRAINT METB_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index METB_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.METB_ID ON BARS.ESCR_MAP_EVENT_TO_BUILD_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ESCR_MAP_EVENT_TO_BUILD_TYPE ***
grant SELECT                                                                 on ESCR_MAP_EVENT_TO_BUILD_TYPE to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ESCR_MAP_EVENT_TO_BUILD_TYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ESCR_MAP_EVENT_TO_BUILD_TYPE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ESCR_MAP_EVENT_TO_BUILD_TYPE.sql =====
PROMPT ===================================================================================== 
