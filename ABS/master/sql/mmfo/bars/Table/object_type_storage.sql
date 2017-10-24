

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBJECT_TYPE_STORAGE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBJECT_TYPE_STORAGE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBJECT_TYPE_STORAGE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OBJECT_TYPE_STORAGE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OBJECT_TYPE_STORAGE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBJECT_TYPE_STORAGE ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBJECT_TYPE_STORAGE 
   (	OBJECT_TYPE_ID NUMBER(5,0), 
	TABLE_OWNER VARCHAR2(30 CHAR), 
	TABLE_NAME VARCHAR2(30 CHAR), 
	KEY_COLUMN_NAME VARCHAR2(30 CHAR), 
	OBJECT_TYPE_COLUMN_NAME VARCHAR2(30 CHAR), 
	WHERE_CLAUSE VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBJECT_TYPE_STORAGE ***
 exec bpa.alter_policies('OBJECT_TYPE_STORAGE');


COMMENT ON TABLE BARS.OBJECT_TYPE_STORAGE IS '';
COMMENT ON COLUMN BARS.OBJECT_TYPE_STORAGE.OBJECT_TYPE_ID IS '';
COMMENT ON COLUMN BARS.OBJECT_TYPE_STORAGE.TABLE_OWNER IS '';
COMMENT ON COLUMN BARS.OBJECT_TYPE_STORAGE.TABLE_NAME IS '';
COMMENT ON COLUMN BARS.OBJECT_TYPE_STORAGE.KEY_COLUMN_NAME IS '';
COMMENT ON COLUMN BARS.OBJECT_TYPE_STORAGE.OBJECT_TYPE_COLUMN_NAME IS '';
COMMENT ON COLUMN BARS.OBJECT_TYPE_STORAGE.WHERE_CLAUSE IS '';




PROMPT *** Create  constraint FK_STORAGE_REF_OBJ_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_TYPE_STORAGE ADD CONSTRAINT FK_STORAGE_REF_OBJ_TYPE FOREIGN KEY (OBJECT_TYPE_ID)
	  REFERENCES BARS.OBJECT_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006187 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_TYPE_STORAGE MODIFY (OBJECT_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006188 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_TYPE_STORAGE MODIFY (TABLE_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006189 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_TYPE_STORAGE MODIFY (KEY_COLUMN_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OBJECT_TYPE_STORAGE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_TYPE_STORAGE ADD CONSTRAINT PK_OBJECT_TYPE_STORAGE PRIMARY KEY (OBJECT_TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBJECT_TYPE_STORAGE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBJECT_TYPE_STORAGE ON BARS.OBJECT_TYPE_STORAGE (OBJECT_TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBJECT_TYPE_STORAGE.sql =========*** E
PROMPT ===================================================================================== 
