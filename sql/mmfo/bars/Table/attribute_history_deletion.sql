

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_HISTORY_DELETION.sql =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ATTRIBUTE_HISTORY_DELETION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ATTRIBUTE_HISTORY_DELETION'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ATTRIBUTE_HISTORY_DELETION'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ATTRIBUTE_HISTORY_DELETION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ATTRIBUTE_HISTORY_DELETION ***
begin 
  execute immediate '
  CREATE TABLE BARS.ATTRIBUTE_HISTORY_DELETION 
   (	HISTORY_ID NUMBER(10,0), 
	USER_ID NUMBER(5,0), 
	SYS_DATE DATE, 
	COMMENT_TEXT VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ATTRIBUTE_HISTORY_DELETION ***
 exec bpa.alter_policies('ATTRIBUTE_HISTORY_DELETION');


COMMENT ON TABLE BARS.ATTRIBUTE_HISTORY_DELETION IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY_DELETION.HISTORY_ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY_DELETION.USER_ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY_DELETION.SYS_DATE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_HISTORY_DELETION.COMMENT_TEXT IS '';




PROMPT *** Create  constraint SYS_C006787 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_HISTORY_DELETION MODIFY (HISTORY_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006788 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_HISTORY_DELETION MODIFY (USER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006789 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_HISTORY_DELETION MODIFY (SYS_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006790 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_HISTORY_DELETION MODIFY (COMMENT_TEXT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ATTRIBUTE_HISTORY_DELETION ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_HISTORY_DELETION ADD CONSTRAINT PK_ATTRIBUTE_HISTORY_DELETION PRIMARY KEY (HISTORY_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ATTRIBUTE_HISTORY_DELETION ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ATTRIBUTE_HISTORY_DELETION ON BARS.ATTRIBUTE_HISTORY_DELETION (HISTORY_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ATTRIBUTE_HISTORY_DELETION ***
grant SELECT                                                                 on ATTRIBUTE_HISTORY_DELETION to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_HISTORY_DELETION.sql =======
PROMPT ===================================================================================== 
