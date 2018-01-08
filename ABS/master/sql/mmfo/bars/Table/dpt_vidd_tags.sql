

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_TAGS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_VIDD_TAGS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_VIDD_TAGS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_VIDD_TAGS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_VIDD_TAGS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_VIDD_TAGS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_VIDD_TAGS 
   (	TAG VARCHAR2(16), 
	NAME VARCHAR2(100), 
	STATUS CHAR(1), 
	EDITABLE CHAR(1), 
	CHECK_QUERY VARCHAR2(3000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_VIDD_TAGS ***
 exec bpa.alter_policies('DPT_VIDD_TAGS');


COMMENT ON TABLE BARS.DPT_VIDD_TAGS IS '—писок доп.параметров видов вкладов';
COMMENT ON COLUMN BARS.DPT_VIDD_TAGS.TAG IS ' од доп.параметра';
COMMENT ON COLUMN BARS.DPT_VIDD_TAGS.NAME IS 'ќписание доп.параметра';
COMMENT ON COLUMN BARS.DPT_VIDD_TAGS.STATUS IS '—татус доп.параметра';
COMMENT ON COLUMN BARS.DPT_VIDD_TAGS.EDITABLE IS 'ƒопустимость изменени€ дл€ акт.видов вкладов';
COMMENT ON COLUMN BARS.DPT_VIDD_TAGS.CHECK_QUERY IS 'SQL-выражение дл€ проверки допуст.значений';




PROMPT *** Create  constraint PK_DPTVIDDTAGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_TAGS ADD CONSTRAINT PK_DPTVIDDTAGS PRIMARY KEY (TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDTAGS_STATUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_TAGS ADD CONSTRAINT CC_DPTVIDDTAGS_STATUS CHECK (status in (''Y'', ''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDTAGS_EDITABLE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_TAGS ADD CONSTRAINT CC_DPTVIDDTAGS_EDITABLE CHECK (editable in (''Y'', ''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDTAGS_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_TAGS MODIFY (TAG CONSTRAINT CC_DPTVIDDTAGS_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDTAGS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_TAGS MODIFY (NAME CONSTRAINT CC_DPTVIDDTAGS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDTAGS_STATUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_TAGS MODIFY (STATUS CONSTRAINT CC_DPTVIDDTAGS_STATUS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDTAGS_EDITABLE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_TAGS MODIFY (EDITABLE CONSTRAINT CC_DPTVIDDTAGS_EDITABLE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTVIDDTAGS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTVIDDTAGS ON BARS.DPT_VIDD_TAGS (TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_VIDD_TAGS ***
grant SELECT                                                                 on DPT_VIDD_TAGS   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_VIDD_TAGS   to BARS_DM;
grant SELECT                                                                 on DPT_VIDD_TAGS   to DPT_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_VIDD_TAGS   to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to DPT_VIDD_TAGS ***

  CREATE OR REPLACE PUBLIC SYNONYM DPT_VIDD_TAGS FOR BARS.DPT_VIDD_TAGS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_TAGS.sql =========*** End ***
PROMPT ===================================================================================== 
