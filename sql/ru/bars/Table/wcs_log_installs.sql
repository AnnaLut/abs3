

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_LOG_INSTALLS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_LOG_INSTALLS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_LOG_INSTALLS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_LOG_INSTALLS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_LOG_INSTALLS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_LOG_INSTALLS 
   (	ID VARCHAR2(14) DEFAULT to_char(SYSDATE, ''yyyymmddhhmmss''), 
	INSTALL_PACK_ID VARCHAR2(400), 
	BVER_PACKAGE VARCHAR2(4000), 
	COUNT_OF_ERR NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_LOG_INSTALLS ***
 exec bpa.alter_policies('WCS_LOG_INSTALLS');


COMMENT ON TABLE BARS.WCS_LOG_INSTALLS IS '';
COMMENT ON COLUMN BARS.WCS_LOG_INSTALLS.ID IS '';
COMMENT ON COLUMN BARS.WCS_LOG_INSTALLS.INSTALL_PACK_ID IS '';
COMMENT ON COLUMN BARS.WCS_LOG_INSTALLS.BVER_PACKAGE IS '';
COMMENT ON COLUMN BARS.WCS_LOG_INSTALLS.COUNT_OF_ERR IS '';




PROMPT *** Create  constraint SYS_C003176018 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_LOG_INSTALLS ADD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003176017 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_LOG_INSTALLS MODIFY (BVER_PACKAGE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003176016 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_LOG_INSTALLS MODIFY (INSTALL_PACK_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003176015 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_LOG_INSTALLS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C003176018 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C003176018 ON BARS.WCS_LOG_INSTALLS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_LOG_INSTALLS.sql =========*** End 
PROMPT ===================================================================================== 
