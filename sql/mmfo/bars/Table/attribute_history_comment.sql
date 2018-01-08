

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_HISTORY_COMMENT.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ATTRIBUTE_HISTORY_COMMENT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ATTRIBUTE_HISTORY_COMMENT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ATTRIBUTE_HISTORY_COMMENT'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ATTRIBUTE_HISTORY_COMMENT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ATTRIBUTE_HISTORY_COMMENT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ATTRIBUTE_HISTORY_COMMENT 
   (	HISTORY_ID NUMBER(10,0), 
	COMMENT_TEXT VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ATTRIBUTE_HISTORY_COMMENT ***
 exec bpa.alter_policies('ATTRIBUTE_HISTORY_COMMENT');


COMMENT ON TABLE BARS.ATTRIBUTE_HISTORY_COMMENT IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY_COMMENT.HISTORY_ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY_COMMENT.COMMENT_TEXT IS '';




PROMPT *** Create  constraint PK_ATTRIBUTE_HISTORY_COMMENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_HISTORY_COMMENT ADD CONSTRAINT PK_ATTRIBUTE_HISTORY_COMMENT PRIMARY KEY (HISTORY_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009379 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_HISTORY_COMMENT MODIFY (HISTORY_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009380 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_HISTORY_COMMENT MODIFY (COMMENT_TEXT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ATTRIBUTE_HISTORY_COMMENT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ATTRIBUTE_HISTORY_COMMENT ON BARS.ATTRIBUTE_HISTORY_COMMENT (HISTORY_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ATTRIBUTE_HISTORY_COMMENT ***
grant SELECT                                                                 on ATTRIBUTE_HISTORY_COMMENT to BARSREADER_ROLE;
grant SELECT                                                                 on ATTRIBUTE_HISTORY_COMMENT to BARS_DM;
grant SELECT                                                                 on ATTRIBUTE_HISTORY_COMMENT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_HISTORY_COMMENT.sql ========
PROMPT ===================================================================================== 
