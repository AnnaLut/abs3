

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/USER_TYPE.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  table USER_TYPE ***
begin 
  execute immediate '
  CREATE TABLE FINMON.USER_TYPE 
   (	VDP_TYPE VARCHAR2(4), 
	NAME VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.USER_TYPE IS '';
COMMENT ON COLUMN FINMON.USER_TYPE.VDP_TYPE IS '';
COMMENT ON COLUMN FINMON.USER_TYPE.NAME IS '';




PROMPT *** Create  constraint SYS_C0032138 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.USER_TYPE MODIFY (VDP_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint USER_TYPE_PK ***
begin   
 execute immediate '
  ALTER TABLE FINMON.USER_TYPE ADD CONSTRAINT USER_TYPE_PK PRIMARY KEY (VDP_TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index USER_TYPE_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.USER_TYPE_PK ON FINMON.USER_TYPE (VDP_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/USER_TYPE.sql =========*** End *** =
PROMPT ===================================================================================== 
