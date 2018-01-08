

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BE_PATCHES.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BE_PATCHES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BE_PATCHES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BE_PATCHES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BE_PATCHES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BE_PATCHES ***
begin 
  execute immediate '
  CREATE TABLE BARS.BE_PATCHES 
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




PROMPT *** ALTER_POLICIES to BE_PATCHES ***
 exec bpa.alter_policies('BE_PATCHES');


COMMENT ON TABLE BARS.BE_PATCHES IS '›Ú‡ÎÓÌ Á‡ÔÎ‡ÚÓÍ (ÏÂÚ‡ËÌÙÓÏ‡ˆËˇ)';
COMMENT ON COLUMN BARS.BE_PATCHES.PATH_NAME IS 'Œ“ÕŒ—»“≈À‹Õ€… œ”“‹ » »Ãﬂ ‘¿…À¿ «¿œÀ¿“ »';
COMMENT ON COLUMN BARS.BE_PATCHES.DESCR IS 'Œœ»—¿Õ»≈ «¿œÀ¿“ »';
COMMENT ON COLUMN BARS.BE_PATCHES.FILE_DATE IS 'ƒ¿“¿ ‘¿…À¿';
COMMENT ON COLUMN BARS.BE_PATCHES.FILE_SIZE IS '–¿«Ã≈– ‘¿…À¿';
COMMENT ON COLUMN BARS.BE_PATCHES.VERSION IS '¬≈–—»ﬂ ‘¿…À¿';
COMMENT ON COLUMN BARS.BE_PATCHES.LINKS IS 'Õ≈ »—œŒÀ‹«”≈“—ﬂ';
COMMENT ON COLUMN BARS.BE_PATCHES.CRITICAL IS ' –»“»◊ÕŒ—“‹ “≈ ”Ÿ≈… ¬≈–—»» «¿œÀ¿“ » ƒÀﬂ –¿¡Œ“€ œŒ';
COMMENT ON COLUMN BARS.BE_PATCHES.STATUS IS '—“¿“”— (¬—≈√ƒ¿ 1-¿ “»¬Õ¿)';
COMMENT ON COLUMN BARS.BE_PATCHES.INS_DATE IS 'ƒ¿“¿ ¬Õ≈—≈Õ»ﬂ “≈ ”Ÿ≈… ¬≈–—»» «¿œÀ¿“ » ¬ ›“¿ÀŒÕ';
COMMENT ON COLUMN BARS.BE_PATCHES.INS_USER IS '¿¬“Œ– ¬Õ≈—≈Õ»ﬂ “≈ ”Ÿ≈… ¬≈–—»» «¿œÀ¿“ »';
COMMENT ON COLUMN BARS.BE_PATCHES.CHECK_SUM IS ' ŒÕ“–ŒÀ‹Õ¿ﬂ —”ÃÃ¿ «¿œÀ¿“ »';




PROMPT *** Create  constraint PK_BEPATCHES ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_PATCHES ADD CONSTRAINT PK_BEPATCHES PRIMARY KEY (PATH_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BEPATCHES_PATHNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_PATCHES MODIFY (PATH_NAME CONSTRAINT CC_BEPATCHES_PATHNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BEPATCHES_CRITICAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_PATCHES MODIFY (CRITICAL CONSTRAINT CC_BEPATCHES_CRITICAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BEPATCHES_STATUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_PATCHES MODIFY (STATUS CONSTRAINT CC_BEPATCHES_STATUS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BEPATCHES_INSDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_PATCHES MODIFY (INS_DATE CONSTRAINT CC_BEPATCHES_INSDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BEPATCHES_INSUSER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_PATCHES MODIFY (INS_USER CONSTRAINT CC_BEPATCHES_INSUSER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BEPATCHES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BEPATCHES ON BARS.BE_PATCHES (PATH_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BE_PATCHES ***
grant SELECT                                                                 on BE_PATCHES      to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BE_PATCHES      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BE_PATCHES.sql =========*** End *** ==
PROMPT ===================================================================================== 
