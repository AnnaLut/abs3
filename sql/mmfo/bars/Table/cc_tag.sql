

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_TAG.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_TAG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_TAG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_TAG'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_TAG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_TAG ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_TAG 
   (	TAG VARCHAR2(8), 
	NAME VARCHAR2(50), 
	TAGTYPE VARCHAR2(5), 
	TABLE_NAME VARCHAR2(30), 
	TYPE VARCHAR2(1), 
	NSISQLWHERE VARCHAR2(254), 
	EDIT_IN_FORM NUMBER(1,0), 
	NOT_TO_EDIT NUMBER(1,0) DEFAULT 0, 
	CODE VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_TAG ***
 exec bpa.alter_policies('CC_TAG');


COMMENT ON TABLE BARS.CC_TAG IS '';
COMMENT ON COLUMN BARS.CC_TAG.TAG IS 'Найменування додаткового реквiзиту';
COMMENT ON COLUMN BARS.CC_TAG.NAME IS 'Коментар додаткового реквiзиту';
COMMENT ON COLUMN BARS.CC_TAG.TAGTYPE IS 'Приналежнiсть до модуля';
COMMENT ON COLUMN BARS.CC_TAG.TABLE_NAME IS 'Найменування довiдника';
COMMENT ON COLUMN BARS.CC_TAG.TYPE IS 'Тип тэга';
COMMENT ON COLUMN BARS.CC_TAG.NSISQLWHERE IS 'Условие фильтра для справочника';
COMMENT ON COLUMN BARS.CC_TAG.EDIT_IN_FORM IS 'Признак: разрешить редактировать';
COMMENT ON COLUMN BARS.CC_TAG.NOT_TO_EDIT IS 'Запрет на редактирование реквизита';
COMMENT ON COLUMN BARS.CC_TAG.CODE IS '';




PROMPT *** Create  constraint XPK_CC_TAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_TAG ADD CONSTRAINT XPK_CC_TAG PRIMARY KEY (TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CC_TAG_META_TABLE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_TAG ADD CONSTRAINT FK_CC_TAG_META_TABLE FOREIGN KEY (TABLE_NAME)
	  REFERENCES BARS.META_TABLES (TABNAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCTAG_CODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_TAG ADD CONSTRAINT FK_CCTAG_CODES FOREIGN KEY (CODE)
	  REFERENCES BARS.CC_TAG_CODES (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CC_TAG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CC_TAG ON BARS.CC_TAG (TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_TAG ***
grant SELECT                                                                 on CC_TAG          to BARSUPL;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CC_TAG          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_TAG          to BARS_DM;
grant SELECT                                                                 on CC_TAG          to DEP_SKRN;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CC_TAG          to RCC_DEAL;
grant SELECT                                                                 on CC_TAG          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_TAG          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CC_TAG          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_TAG.sql =========*** End *** ======
PROMPT ===================================================================================== 
