

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BE_LIBS_ARC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BE_LIBS_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BE_LIBS_ARC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BE_LIBS_ARC'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BE_LIBS_ARC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BE_LIBS_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.BE_LIBS_ARC 
   (	PATH_NAME VARCHAR2(254), 
	DESCR VARCHAR2(200), 
	FILE_DATE DATE, 
	FILE_SIZE NUMBER(10,0), 
	VERSION VARCHAR2(20), 
	LINKS VARCHAR2(2000), 
	CRITICAL NUMBER(1,0) DEFAULT 0, 
	STATUS NUMBER(3,0) DEFAULT 1, 
	INS_DATE DATE DEFAULT SYSDATE, 
	INS_USER VARCHAR2(30) DEFAULT USER, 
	CHECK_SUM VARCHAR2(256), 
	INS_DATE_ORI DATE DEFAULT SYSDATE, 
	INS_USER_ORI VARCHAR2(30) DEFAULT USER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BE_LIBS_ARC ***
 exec bpa.alter_policies('BE_LIBS_ARC');


COMMENT ON TABLE BARS.BE_LIBS_ARC IS 'юПУХБ АХАКХНРЕЙ (ЛЕРЮХМТНПЛЮЖХЪ)';
COMMENT ON COLUMN BARS.BE_LIBS_ARC.PATH_NAME IS 'нрмняхрекэмши осрэ х хлъ тюикю ахакхнрейх';
COMMENT ON COLUMN BARS.BE_LIBS_ARC.DESCR IS 'нохяюмхе ахакхнрейх';
COMMENT ON COLUMN BARS.BE_LIBS_ARC.FILE_DATE IS 'дюрю тюикю';
COMMENT ON COLUMN BARS.BE_LIBS_ARC.FILE_SIZE IS 'пюглеп тюикю';
COMMENT ON COLUMN BARS.BE_LIBS_ARC.VERSION IS 'бепяхъ тюикю';
COMMENT ON COLUMN BARS.BE_LIBS_ARC.LINKS IS 'ябъгх ахакхнрейх (гюбхяхлнярх нр дпсцху)';
COMMENT ON COLUMN BARS.BE_LIBS_ARC.CRITICAL IS 'йпхрхвмнярэ бепяхх ахакхнрейх дкъ пюанрш он';
COMMENT ON COLUMN BARS.BE_LIBS_ARC.STATUS IS 'ярюрся (бяецдю 2-юпухб)';
COMMENT ON COLUMN BARS.BE_LIBS_ARC.INS_DATE IS 'дюрю бмеяемхъ рейсыеи бепяхх ахакхнрейх б щрюкнм';
COMMENT ON COLUMN BARS.BE_LIBS_ARC.INS_USER IS 'юбрнп бмеяемхъ рейсыеи бепяхх ахакхнрейх';
COMMENT ON COLUMN BARS.BE_LIBS_ARC.CHECK_SUM IS 'йнмрпнкэмюъ ясллю ахакхнрейх';
COMMENT ON COLUMN BARS.BE_LIBS_ARC.INS_DATE_ORI IS 'дюрю бярюбйх/хглемемхъ ахакхнрейх б BE_LIBS (дкъ нрйюрю он бпелемх)';
COMMENT ON COLUMN BARS.BE_LIBS_ARC.INS_USER_ORI IS 'онкэгнбюрекэ янбепьхбьхи бярюбйс/хглемемхе ахакхнрейх б BE_LIBS (дкъ нрйюрю он бпелемх)';




PROMPT *** Create  constraint PK_BELIBSARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_LIBS_ARC ADD CONSTRAINT PK_BELIBSARC PRIMARY KEY (PATH_NAME, INS_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BELIBSARC_PATHNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_LIBS_ARC MODIFY (PATH_NAME CONSTRAINT CC_BELIBSARC_PATHNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BELIBSARC_CRITICAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_LIBS_ARC MODIFY (CRITICAL CONSTRAINT CC_BELIBSARC_CRITICAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BELIBSARC_STATUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_LIBS_ARC MODIFY (STATUS CONSTRAINT CC_BELIBSARC_STATUS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BELIBSARC_INSDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_LIBS_ARC MODIFY (INS_DATE CONSTRAINT CC_BELIBSARC_INSDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BELIBSARC_INSUSER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_LIBS_ARC MODIFY (INS_USER CONSTRAINT CC_BELIBSARC_INSUSER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BELIBSARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BELIBSARC ON BARS.BE_LIBS_ARC (PATH_NAME, INS_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BE_LIBS_ARC ***
grant SELECT                                                                 on BE_LIBS_ARC     to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BE_LIBS_ARC     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BE_LIBS_ARC.sql =========*** End *** =
PROMPT ===================================================================================== 
