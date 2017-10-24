

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_STRING_HISTORY.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ATTRIBUTE_STRING_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ATTRIBUTE_STRING_HISTORY'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ATTRIBUTE_STRING_HISTORY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ATTRIBUTE_STRING_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.ATTRIBUTE_STRING_HISTORY 
   (	ID NUMBER(10,0), 
	VALUE VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ATTRIBUTE_STRING_HISTORY ***
 exec bpa.alter_policies('ATTRIBUTE_STRING_HISTORY');


COMMENT ON TABLE BARS.ATTRIBUTE_STRING_HISTORY IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_STRING_HISTORY.ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_STRING_HISTORY.VALUE IS '';




PROMPT *** Create  constraint FK_STR_ATTR_HIST_REF_ATTR_HIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_STRING_HISTORY ADD CONSTRAINT FK_STR_ATTR_HIST_REF_ATTR_HIST FOREIGN KEY (ID)
	  REFERENCES BARS.ATTRIBUTE_HISTORY (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002861380 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_STRING_HISTORY MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index ATTRIBUTE_HISTORY_STRING_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.ATTRIBUTE_HISTORY_STRING_IDX ON BARS.ATTRIBUTE_STRING_HISTORY (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_STRING_HISTORY.sql =========
PROMPT ===================================================================================== 
