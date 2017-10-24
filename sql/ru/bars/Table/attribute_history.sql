

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_HISTORY.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ATTRIBUTE_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ATTRIBUTE_HISTORY'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ATTRIBUTE_HISTORY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ATTRIBUTE_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.ATTRIBUTE_HISTORY 
   (	ID NUMBER(10,0), 
	OBJECT_ID NUMBER(12,0), 
	ATTRIBUTE_ID NUMBER(5,0), 
	VALUE_DATE DATE, 
	USER_ID NUMBER(5,0), 
	SYS_TIME DATE, 
	IS_DELETE CHAR(1)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSDYND 
  PARTITION BY RANGE (ATTRIBUTE_ID) INTERVAL (1) 
 (PARTITION INITIAL_PARTITION  VALUES LESS THAN (1) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSDYND ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ATTRIBUTE_HISTORY ***
 exec bpa.alter_policies('ATTRIBUTE_HISTORY');


COMMENT ON TABLE BARS.ATTRIBUTE_HISTORY IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY.USER_ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY.SYS_TIME IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY.IS_DELETE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY.ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY.OBJECT_ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY.ATTRIBUTE_ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY.VALUE_DATE IS '';




PROMPT *** Create  constraint FK_OBJ_ATTR_HIST_REF_ATTR_KIND ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_HISTORY ADD CONSTRAINT FK_OBJ_ATTR_HIST_REF_ATTR_KIND FOREIGN KEY (ATTRIBUTE_ID)
	  REFERENCES BARS.ATTRIBUTE_KIND (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ATTRIBUTE_HISTORY ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_HISTORY ADD CONSTRAINT PK_ATTRIBUTE_HISTORY PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002861337 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_HISTORY MODIFY (SYS_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002861336 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_HISTORY MODIFY (USER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002861335 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_HISTORY MODIFY (ATTRIBUTE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002861334 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_HISTORY MODIFY (OBJECT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002861333 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_HISTORY MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index ATTRIBUTE_HISTORY_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.ATTRIBUTE_HISTORY_IDX ON BARS.ATTRIBUTE_HISTORY (OBJECT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255  LOCAL
 (PARTITION INITIAL_PARTITION 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSDYND ) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ATTRIBUTE_HISTORY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ATTRIBUTE_HISTORY ON BARS.ATTRIBUTE_HISTORY (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ATTRIBUTE_HISTORY ***
grant SELECT                                                                 on ATTRIBUTE_HISTORY to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_HISTORY.sql =========*** End
PROMPT ===================================================================================== 
