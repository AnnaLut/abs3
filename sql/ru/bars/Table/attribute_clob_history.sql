

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_CLOB_HISTORY.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ATTRIBUTE_CLOB_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ATTRIBUTE_CLOB_HISTORY'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ATTRIBUTE_CLOB_HISTORY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ATTRIBUTE_CLOB_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.ATTRIBUTE_CLOB_HISTORY 
   (	ID NUMBER(10,0), 
	VALUE CLOB
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (VALUE) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ATTRIBUTE_CLOB_HISTORY ***
 exec bpa.alter_policies('ATTRIBUTE_CLOB_HISTORY');


COMMENT ON TABLE BARS.ATTRIBUTE_CLOB_HISTORY IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_CLOB_HISTORY.ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_CLOB_HISTORY.VALUE IS '';




PROMPT *** Create  constraint FK_CLOB_ATTR_HIST_REF_ATTR_HIS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_CLOB_HISTORY ADD CONSTRAINT FK_CLOB_ATTR_HIST_REF_ATTR_HIS FOREIGN KEY (ID)
	  REFERENCES BARS.ATTRIBUTE_HISTORY (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002861346 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_CLOB_HISTORY MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index ATTRIBUTE_HISTORY_CLOB_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.ATTRIBUTE_HISTORY_CLOB_IDX ON BARS.ATTRIBUTE_CLOB_HISTORY (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_CLOB_HISTORY.sql =========**
PROMPT ===================================================================================== 
