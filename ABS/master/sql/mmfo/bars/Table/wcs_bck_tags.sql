

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_BCK_TAGS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_BCK_TAGS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_BCK_TAGS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_BCK_TAGS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_BCK_TAGS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_BCK_TAGS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_BCK_TAGS 
   (	TAG_NAME VARCHAR2(38), 
	TAG_BLOCK NUMBER(2,0), 
	TAG_DESCR VARCHAR2(128), 
	TAG_XPATH VARCHAR2(256), 
	TAG_MANDATORY NUMBER(1,0) DEFAULT 1
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_BCK_TAGS ***
 exec bpa.alter_policies('WCS_BCK_TAGS');


COMMENT ON TABLE BARS.WCS_BCK_TAGS IS 'Список тэгов, получаемых из XML-отчетов кред.бюро';
COMMENT ON COLUMN BARS.WCS_BCK_TAGS.TAG_NAME IS 'Наименование тэга';
COMMENT ON COLUMN BARS.WCS_BCK_TAGS.TAG_BLOCK IS 'Номер блока в XML-отчете';
COMMENT ON COLUMN BARS.WCS_BCK_TAGS.TAG_DESCR IS 'Описание тэга';
COMMENT ON COLUMN BARS.WCS_BCK_TAGS.TAG_XPATH IS 'xpath выражение для поиска';
COMMENT ON COLUMN BARS.WCS_BCK_TAGS.TAG_MANDATORY IS 'обязательность поля';




PROMPT *** Create  constraint CC_WCSBCKTAGS_TAGDBLOCK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_TAGS MODIFY (TAG_BLOCK CONSTRAINT CC_WCSBCKTAGS_TAGDBLOCK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSBCKTAGS_TAGDESCR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_TAGS MODIFY (TAG_DESCR CONSTRAINT CC_WCSBCKTAGS_TAGDESCR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_WCSBCKTAGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_TAGS ADD CONSTRAINT PK_WCSBCKTAGS PRIMARY KEY (TAG_NAME, TAG_BLOCK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSBCKTAGS_TAGBLOCK ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_TAGS ADD CONSTRAINT CC_WCSBCKTAGS_TAGBLOCK CHECK (tag_block in (0,1,2,3,4,5,6,7)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSBCKTAGS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSBCKTAGS ON BARS.WCS_BCK_TAGS (TAG_NAME, TAG_BLOCK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_BCK_TAGS ***
grant SELECT                                                                 on WCS_BCK_TAGS    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_BCK_TAGS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_BCK_TAGS    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_BCK_TAGS    to START1;
grant SELECT                                                                 on WCS_BCK_TAGS    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_BCK_TAGS.sql =========*** End *** 
PROMPT ===================================================================================== 
