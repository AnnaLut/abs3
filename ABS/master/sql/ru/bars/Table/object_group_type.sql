

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBJECT_GROUP_TYPE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBJECT_GROUP_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBJECT_GROUP_TYPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OBJECT_GROUP_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBJECT_GROUP_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBJECT_GROUP_TYPE 
   (	ID NUMBER(5,0), 
	GROUP_TYPE_CODE VARCHAR2(30 CHAR), 
	GROUP_TYPE_NAME VARCHAR2(300 CHAR)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBJECT_GROUP_TYPE ***
 exec bpa.alter_policies('OBJECT_GROUP_TYPE');


COMMENT ON TABLE BARS.OBJECT_GROUP_TYPE IS '';
COMMENT ON COLUMN BARS.OBJECT_GROUP_TYPE.ID IS '';
COMMENT ON COLUMN BARS.OBJECT_GROUP_TYPE.GROUP_TYPE_CODE IS '';
COMMENT ON COLUMN BARS.OBJECT_GROUP_TYPE.GROUP_TYPE_NAME IS '';




PROMPT *** Create  constraint UK_OBJECT_GROUP_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_GROUP_TYPE ADD CONSTRAINT UK_OBJECT_GROUP_TYPE UNIQUE (GROUP_TYPE_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OBJECT_GROUP_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_GROUP_TYPE ADD CONSTRAINT PK_OBJECT_GROUP_TYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003187825 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_GROUP_TYPE MODIFY (GROUP_TYPE_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003187824 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_GROUP_TYPE MODIFY (GROUP_TYPE_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003187823 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_GROUP_TYPE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBJECT_GROUP_TYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBJECT_GROUP_TYPE ON BARS.OBJECT_GROUP_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_OBJECT_GROUP_TYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_OBJECT_GROUP_TYPE ON BARS.OBJECT_GROUP_TYPE (GROUP_TYPE_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBJECT_GROUP_TYPE.sql =========*** End
PROMPT ===================================================================================== 
