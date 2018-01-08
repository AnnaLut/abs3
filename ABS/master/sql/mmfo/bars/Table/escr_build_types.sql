

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ESCR_BUILD_TYPES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ESCR_BUILD_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ESCR_BUILD_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ESCR_BUILD_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ESCR_BUILD_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ESCR_BUILD_TYPES 
   (	ID NUMBER, 
	TYPE VARCHAR2(16)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ESCR_BUILD_TYPES ***
 exec bpa.alter_policies('ESCR_BUILD_TYPES');


COMMENT ON TABLE BARS.ESCR_BUILD_TYPES IS '’ипи будинкґв';
COMMENT ON COLUMN BARS.ESCR_BUILD_TYPES.ID IS '';
COMMENT ON COLUMN BARS.ESCR_BUILD_TYPES.TYPE IS '';




PROMPT *** Create  constraint SYS_C00118567 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_BUILD_TYPES MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118568 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_BUILD_TYPES MODIFY (TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BUILD_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_BUILD_TYPES ADD CONSTRAINT PK_BUILD_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BUILD_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BUILD_ID ON BARS.ESCR_BUILD_TYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ESCR_BUILD_TYPES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ESCR_BUILD_TYPES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ESCR_BUILD_TYPES.sql =========*** End 
PROMPT ===================================================================================== 
