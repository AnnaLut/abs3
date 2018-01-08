

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBJECT_TYPE.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBJECT_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBJECT_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OBJECT_TYPE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OBJECT_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBJECT_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBJECT_TYPE 
   (	ID NUMBER(5,0), 
	TYPE_CODE VARCHAR2(30 CHAR), 
	TYPE_NAME VARCHAR2(300 CHAR), 
	STATE_ID NUMBER(5,0), 
	PARENT_TYPE_ID NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBJECT_TYPE ***
 exec bpa.alter_policies('OBJECT_TYPE');


COMMENT ON TABLE BARS.OBJECT_TYPE IS '“ËÔË Ó·'∫ÍÚ≥‚ ¿¡—.';
COMMENT ON COLUMN BARS.OBJECT_TYPE.ID IS '';
COMMENT ON COLUMN BARS.OBJECT_TYPE.TYPE_CODE IS '';
COMMENT ON COLUMN BARS.OBJECT_TYPE.TYPE_NAME IS '';
COMMENT ON COLUMN BARS.OBJECT_TYPE.STATE_ID IS '';
COMMENT ON COLUMN BARS.OBJECT_TYPE.PARENT_TYPE_ID IS '';




PROMPT *** Create  constraint PK_OBJECT_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_TYPE ADD CONSTRAINT PK_OBJECT_TYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_OBJECT_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_TYPE ADD CONSTRAINT UK_OBJECT_TYPE UNIQUE (TYPE_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OBJECT_TYPE_REF_PARENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_TYPE ADD CONSTRAINT FK_OBJECT_TYPE_REF_PARENT FOREIGN KEY (PARENT_TYPE_ID)
	  REFERENCES BARS.OBJECT_TYPE (ID) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008809 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_TYPE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008810 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_TYPE MODIFY (TYPE_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008811 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_TYPE MODIFY (TYPE_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008812 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_TYPE MODIFY (STATE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBJECT_TYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBJECT_TYPE ON BARS.OBJECT_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_OBJECT_TYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_OBJECT_TYPE ON BARS.OBJECT_TYPE (TYPE_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OBJECT_TYPE ***
grant SELECT                                                                 on OBJECT_TYPE     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBJECT_TYPE     to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBJECT_TYPE.sql =========*** End *** =
PROMPT ===================================================================================== 
