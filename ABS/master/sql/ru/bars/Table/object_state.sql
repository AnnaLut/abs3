

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBJECT_STATE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBJECT_STATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBJECT_STATE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OBJECT_STATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBJECT_STATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBJECT_STATE 
   (	OBJECT_TYPE_ID NUMBER(5,0), 
	STATE_ID NUMBER(5,0), 
	STATE_CODE VARCHAR2(30 CHAR), 
	STATE_NAME VARCHAR2(300 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBJECT_STATE ***
 exec bpa.alter_policies('OBJECT_STATE');


COMMENT ON TABLE BARS.OBJECT_STATE IS '������� ����� ��'���� �������';
COMMENT ON COLUMN BARS.OBJECT_STATE.OBJECT_TYPE_ID IS '';
COMMENT ON COLUMN BARS.OBJECT_STATE.STATE_ID IS '';
COMMENT ON COLUMN BARS.OBJECT_STATE.STATE_CODE IS '';
COMMENT ON COLUMN BARS.OBJECT_STATE.STATE_NAME IS '';




PROMPT *** Create  constraint FK_OBJECT_STATE_REF_OBJ_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_STATE ADD CONSTRAINT FK_OBJECT_STATE_REF_OBJ_TYPE FOREIGN KEY (OBJECT_TYPE_ID)
	  REFERENCES BARS.OBJECT_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002861311 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_STATE MODIFY (STATE_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002861310 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_STATE MODIFY (STATE_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002861309 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_STATE MODIFY (STATE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002861308 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_STATE MODIFY (OBJECT_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_OBJECT_STATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_STATE ADD CONSTRAINT UK_OBJECT_STATE UNIQUE (OBJECT_TYPE_ID, STATE_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OBJECT_STATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_STATE ADD CONSTRAINT PK_OBJECT_STATE PRIMARY KEY (OBJECT_TYPE_ID, STATE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBJECT_STATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBJECT_STATE ON BARS.OBJECT_STATE (OBJECT_TYPE_ID, STATE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_OBJECT_STATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_OBJECT_STATE ON BARS.OBJECT_STATE (OBJECT_TYPE_ID, STATE_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBJECT_STATE.sql =========*** End *** 
PROMPT ===================================================================================== 
