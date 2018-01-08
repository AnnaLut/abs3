

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WEB_PROFILE_TAGS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WEB_PROFILE_TAGS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WEB_PROFILE_TAGS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WEB_PROFILE_TAGS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''WEB_PROFILE_TAGS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WEB_PROFILE_TAGS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WEB_PROFILE_TAGS 
   (	TAG VARCHAR2(30), 
	NAME VARCHAR2(255), 
	DEFAULT_VALUE VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WEB_PROFILE_TAGS ***
 exec bpa.alter_policies('WEB_PROFILE_TAGS');


COMMENT ON TABLE BARS.WEB_PROFILE_TAGS IS 'Тэги параметров профиля';
COMMENT ON COLUMN BARS.WEB_PROFILE_TAGS.TAG IS 'Тэг параметра';
COMMENT ON COLUMN BARS.WEB_PROFILE_TAGS.NAME IS 'Наименование параметра';
COMMENT ON COLUMN BARS.WEB_PROFILE_TAGS.DEFAULT_VALUE IS 'Значение по умолчанию для базового профиля';




PROMPT *** Create  constraint XPK_WEB_PROFILE_TAGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_PROFILE_TAGS ADD CONSTRAINT XPK_WEB_PROFILE_TAGS PRIMARY KEY (TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_WEB_PROFILE_TAGS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_WEB_PROFILE_TAGS ON BARS.WEB_PROFILE_TAGS (TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WEB_PROFILE_TAGS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on WEB_PROFILE_TAGS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WEB_PROFILE_TAGS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WEB_PROFILE_TAGS to WEB_PROFILE_TAGS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on WEB_PROFILE_TAGS to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on WEB_PROFILE_TAGS to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WEB_PROFILE_TAGS.sql =========*** End 
PROMPT ===================================================================================== 
