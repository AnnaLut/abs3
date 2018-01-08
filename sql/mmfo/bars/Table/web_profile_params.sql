

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WEB_PROFILE_PARAMS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WEB_PROFILE_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WEB_PROFILE_PARAMS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WEB_PROFILE_PARAMS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''WEB_PROFILE_PARAMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WEB_PROFILE_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WEB_PROFILE_PARAMS 
   (	PROFILE_ID VARCHAR2(30), 
	TAG VARCHAR2(30), 
	VALUE VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WEB_PROFILE_PARAMS ***
 exec bpa.alter_policies('WEB_PROFILE_PARAMS');


COMMENT ON TABLE BARS.WEB_PROFILE_PARAMS IS 'Параметры профилей';
COMMENT ON COLUMN BARS.WEB_PROFILE_PARAMS.PROFILE_ID IS 'идентификатор профиля';
COMMENT ON COLUMN BARS.WEB_PROFILE_PARAMS.TAG IS 'Тэг параметра';
COMMENT ON COLUMN BARS.WEB_PROFILE_PARAMS.VALUE IS 'Значение параметра';




PROMPT *** Create  constraint XPK_WEB_PROFILE_PARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_PROFILE_PARAMS ADD CONSTRAINT XPK_WEB_PROFILE_PARAMS PRIMARY KEY (PROFILE_ID, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WEB_PROFILE_PARAMS_PROFILE ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_PROFILE_PARAMS ADD CONSTRAINT FK_WEB_PROFILE_PARAMS_PROFILE FOREIGN KEY (PROFILE_ID)
	  REFERENCES BARS.WEB_PROFILES (PROFILE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WEB_PROFILE_PARAMS_TAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_PROFILE_PARAMS ADD CONSTRAINT FK_WEB_PROFILE_PARAMS_TAG FOREIGN KEY (TAG)
	  REFERENCES BARS.WEB_PROFILE_TAGS (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_WEB_PROFILE_PARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_WEB_PROFILE_PARAMS ON BARS.WEB_PROFILE_PARAMS (PROFILE_ID, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WEB_PROFILE_PARAMS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on WEB_PROFILE_PARAMS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WEB_PROFILE_PARAMS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WEB_PROFILE_PARAMS to WEB_PROFILE_PARAMS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on WEB_PROFILE_PARAMS to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on WEB_PROFILE_PARAMS to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WEB_PROFILE_PARAMS.sql =========*** En
PROMPT ===================================================================================== 
