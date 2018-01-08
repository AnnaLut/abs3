

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/ZAPROS_DEFAULT_VALUE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  table ZAPROS_DEFAULT_VALUE ***
begin 
  execute immediate '
  CREATE TABLE FINMON.ZAPROS_DEFAULT_VALUE 
   (	ZAPID NUMBER(18,0), 
	NAME VARCHAR2(50), 
	SEMANTIC VARCHAR2(60), 
	VAL VARCHAR2(512), 
	ISNULL NUMBER(18,0) DEFAULT 0, 
	FIELDTYPE NUMBER(18,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.ZAPROS_DEFAULT_VALUE IS '';
COMMENT ON COLUMN FINMON.ZAPROS_DEFAULT_VALUE.ZAPID IS '';
COMMENT ON COLUMN FINMON.ZAPROS_DEFAULT_VALUE.NAME IS '';
COMMENT ON COLUMN FINMON.ZAPROS_DEFAULT_VALUE.SEMANTIC IS '';
COMMENT ON COLUMN FINMON.ZAPROS_DEFAULT_VALUE.VAL IS '';
COMMENT ON COLUMN FINMON.ZAPROS_DEFAULT_VALUE.ISNULL IS '';
COMMENT ON COLUMN FINMON.ZAPROS_DEFAULT_VALUE.FIELDTYPE IS '';




PROMPT *** Create  constraint XPK_ZAPROS_DEFAULT_VALUE ***
begin   
 execute immediate '
  ALTER TABLE FINMON.ZAPROS_DEFAULT_VALUE ADD CONSTRAINT XPK_ZAPROS_DEFAULT_VALUE PRIMARY KEY (ZAPID, NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_ZAPR_DEFAULT_VAL_ZAPID ***
begin   
 execute immediate '
  ALTER TABLE FINMON.ZAPROS_DEFAULT_VALUE MODIFY (ZAPID CONSTRAINT NK_ZAPR_DEFAULT_VAL_ZAPID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_ZAPR_DEFAULT_VAL_NAME ***
begin   
 execute immediate '
  ALTER TABLE FINMON.ZAPROS_DEFAULT_VALUE MODIFY (NAME CONSTRAINT NK_ZAPR_DEFAULT_VAL_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_ZAPR_DEFAULT_VAL_SEMANTIC ***
begin   
 execute immediate '
  ALTER TABLE FINMON.ZAPROS_DEFAULT_VALUE MODIFY (SEMANTIC CONSTRAINT NK_ZAPR_DEFAULT_VAL_SEMANTIC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_ZAPR_DEFAULT_VAL_ISNULL ***
begin   
 execute immediate '
  ALTER TABLE FINMON.ZAPROS_DEFAULT_VALUE MODIFY (ISNULL CONSTRAINT NK_ZAPR_DEFAULT_VAL_ISNULL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_ZAPR_DEFAULT_VAL_FIELDTYPE ***
begin   
 execute immediate '
  ALTER TABLE FINMON.ZAPROS_DEFAULT_VALUE MODIFY (FIELDTYPE CONSTRAINT NK_ZAPR_DEFAULT_VAL_FIELDTYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZAPROS_DEFAULT_VALUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.PK_ZAPROS_DEFAULT_VALUE ON FINMON.ZAPROS_DEFAULT_VALUE (ZAPID, NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAPROS_DEFAULT_VALUE ***
grant SELECT                                                                 on ZAPROS_DEFAULT_VALUE to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/ZAPROS_DEFAULT_VALUE.sql =========**
PROMPT ===================================================================================== 
