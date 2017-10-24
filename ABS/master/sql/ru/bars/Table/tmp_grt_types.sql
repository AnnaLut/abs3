

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_GRT_TYPES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_GRT_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_GRT_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_GRT_TYPES 
   (	TYPE_ID NUMBER(10,0), 
	TYPE_NAME VARCHAR2(150), 
	GROUP_ID NUMBER(4,0), 
	KV NUMBER, 
	TP NUMBER, 
	KL NUMBER, 
	KZ NUMBER, 
	KN NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_GRT_TYPES ***
 exec bpa.alter_policies('TMP_GRT_TYPES');


COMMENT ON TABLE BARS.TMP_GRT_TYPES IS '';
COMMENT ON COLUMN BARS.TMP_GRT_TYPES.TYPE_ID IS '';
COMMENT ON COLUMN BARS.TMP_GRT_TYPES.TYPE_NAME IS '';
COMMENT ON COLUMN BARS.TMP_GRT_TYPES.GROUP_ID IS '';
COMMENT ON COLUMN BARS.TMP_GRT_TYPES.KV IS '';
COMMENT ON COLUMN BARS.TMP_GRT_TYPES.TP IS '';
COMMENT ON COLUMN BARS.TMP_GRT_TYPES.KL IS '';
COMMENT ON COLUMN BARS.TMP_GRT_TYPES.KZ IS '';
COMMENT ON COLUMN BARS.TMP_GRT_TYPES.KN IS '';




PROMPT *** Create  constraint SYS_C002443279 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_GRT_TYPES MODIFY (KN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002443278 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_GRT_TYPES MODIFY (KZ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002443277 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_GRT_TYPES MODIFY (KL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002443276 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_GRT_TYPES MODIFY (TP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002443275 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_GRT_TYPES MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002443274 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_GRT_TYPES MODIFY (GROUP_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002443273 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_GRT_TYPES MODIFY (TYPE_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_GRT_TYPES.sql =========*** End ***
PROMPT ===================================================================================== 
