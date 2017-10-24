

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BE_LIBS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BE_LIBS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BE_LIBS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BE_LIBS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BE_LIBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BE_LIBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.BE_LIBS 
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
	CHECK_SUM VARCHAR2(256)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BE_LIBS ***
 exec bpa.alter_policies('BE_LIBS');


COMMENT ON TABLE BARS.BE_LIBS IS 'щРЮКНМ АХАКХНРЕЙ (ЛЕРЮХМТНПЛЮЖХЪ)';
COMMENT ON COLUMN BARS.BE_LIBS.PATH_NAME IS 'нрмняхрекэмши осрэ х хлъ тюикю ахакхнрейх';
COMMENT ON COLUMN BARS.BE_LIBS.DESCR IS 'нохяюмхе ахакхнрейх';
COMMENT ON COLUMN BARS.BE_LIBS.FILE_DATE IS 'дюрю тюикю';
COMMENT ON COLUMN BARS.BE_LIBS.FILE_SIZE IS 'пюглеп тюикю';
COMMENT ON COLUMN BARS.BE_LIBS.VERSION IS 'бепяхъ тюикю';
COMMENT ON COLUMN BARS.BE_LIBS.LINKS IS 'ябъгх ахакхнрейх (гюбхяхлнярх нр дпсцху)';
COMMENT ON COLUMN BARS.BE_LIBS.CRITICAL IS 'йпхрхвмнярэ рейсыеи бепяхх ахакхнрейх дкъ пюанрш он';
COMMENT ON COLUMN BARS.BE_LIBS.STATUS IS 'ярюрся (бяецдю 1-юйрхбмю)';
COMMENT ON COLUMN BARS.BE_LIBS.INS_DATE IS 'дюрю бмеяемхъ рейсыеи бепяхх ахакхнрейх б щрюкнм';
COMMENT ON COLUMN BARS.BE_LIBS.INS_USER IS 'юбрнп бмеяемхъ рейсыеи бепяхх ахакхнрейх';
COMMENT ON COLUMN BARS.BE_LIBS.CHECK_SUM IS 'йнмрпнкэмюъ ясллю ахакхнрейх';




PROMPT *** Create  constraint PK_BELIBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_LIBS ADD CONSTRAINT PK_BELIBS PRIMARY KEY (PATH_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BELIBS_PATHNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_LIBS MODIFY (PATH_NAME CONSTRAINT CC_BELIBS_PATHNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BELIBS_CRITICAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_LIBS MODIFY (CRITICAL CONSTRAINT CC_BELIBS_CRITICAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BELIBS_STATUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_LIBS MODIFY (STATUS CONSTRAINT CC_BELIBS_STATUS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BELIBS_INSDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_LIBS MODIFY (INS_DATE CONSTRAINT CC_BELIBS_INSDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BELIBS_INSUSER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_LIBS MODIFY (INS_USER CONSTRAINT CC_BELIBS_INSUSER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BELIBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BELIBS ON BARS.BE_LIBS (PATH_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BE_LIBS ***
grant SELECT                                                                 on BE_LIBS         to BARSUPL;
grant SELECT                                                                 on BE_LIBS         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BE_LIBS         to BARS_DM;
grant SELECT                                                                 on BE_LIBS         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BE_LIBS         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BE_LIBS.sql =========*** End *** =====
PROMPT ===================================================================================== 
