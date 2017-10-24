

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BE_PATCHES_ARC.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BE_PATCHES_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BE_PATCHES_ARC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BE_PATCHES_ARC'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BE_PATCHES_ARC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BE_PATCHES_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.BE_PATCHES_ARC 
   (	PATH_NAME VARCHAR2(254), 
	DESCR VARCHAR2(200), 
	FILE_DATE DATE, 
	FILE_SIZE NUMBER(10,0), 
	VERSION VARCHAR2(20), 
	LINKS VARCHAR2(2000), 
	CRITICAL NUMBER(1,0) DEFAULT 0, 
	STATUS NUMBER(3,0) DEFAULT 1, 
	INS_DATE DATE DEFAULT SYSDATE, 
	INS_USER VARCHAR2(30) DEFAULT USER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BE_PATCHES_ARC ***
 exec bpa.alter_policies('BE_PATCHES_ARC');


COMMENT ON TABLE BARS.BE_PATCHES_ARC IS '¿ıË‚ Á‡ÔÎ‡ÚÓÍ (ÏÂÚ‡ËÌÙÓÏ‡ˆËˇ)';
COMMENT ON COLUMN BARS.BE_PATCHES_ARC.PATH_NAME IS 'Œ“ÕŒ—»“≈À‹Õ€… œ”“‹ » »Ãﬂ ‘¿…À¿ «¿œÀ¿“ »';
COMMENT ON COLUMN BARS.BE_PATCHES_ARC.DESCR IS 'Œœ»—¿Õ»≈ «¿œÀ¿“ »';
COMMENT ON COLUMN BARS.BE_PATCHES_ARC.FILE_DATE IS 'ƒ¿“¿ ‘¿…À¿';
COMMENT ON COLUMN BARS.BE_PATCHES_ARC.FILE_SIZE IS '–¿«Ã≈– ‘¿…À¿';
COMMENT ON COLUMN BARS.BE_PATCHES_ARC.VERSION IS '¬≈–—»ﬂ ‘¿…À¿';
COMMENT ON COLUMN BARS.BE_PATCHES_ARC.LINKS IS 'Õ≈ »—œŒÀ‹«”≈“—ﬂ';
COMMENT ON COLUMN BARS.BE_PATCHES_ARC.CRITICAL IS ' –»“»◊ÕŒ—“‹ ¬≈–—»» «¿œÀ¿“ » ƒÀﬂ –¿¡Œ“€ œŒ';
COMMENT ON COLUMN BARS.BE_PATCHES_ARC.STATUS IS '—“¿“”— (¬—≈√ƒ¿ 2-¿–’»¬)';
COMMENT ON COLUMN BARS.BE_PATCHES_ARC.INS_DATE IS 'ƒ¿“¿ ¬Õ≈—≈Õ»ﬂ “≈ ”Ÿ≈… ¬≈–—»» «¿œÀ¿“ » ¬ ›“¿ÀŒÕ';
COMMENT ON COLUMN BARS.BE_PATCHES_ARC.INS_USER IS '¿¬“Œ– ¬Õ≈—≈Õ»ﬂ “≈ ”Ÿ≈… ¬≈–—»» «¿œÀ¿“ »';




PROMPT *** Create  constraint PK_BEPATCHESARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_PATCHES_ARC ADD CONSTRAINT PK_BEPATCHESARC PRIMARY KEY (PATH_NAME, INS_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BEPATCHESARC_PATHNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_PATCHES_ARC MODIFY (PATH_NAME CONSTRAINT CC_BEPATCHESARC_PATHNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BEPATCHESARC_CRITICAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_PATCHES_ARC MODIFY (CRITICAL CONSTRAINT CC_BEPATCHESARC_CRITICAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BEPATCHESARC_STATUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_PATCHES_ARC MODIFY (STATUS CONSTRAINT CC_BEPATCHESARC_STATUS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BEPATCHESARC_INSDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_PATCHES_ARC MODIFY (INS_DATE CONSTRAINT CC_BEPATCHESARC_INSDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BEPATCHESARC_INSUSER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BE_PATCHES_ARC MODIFY (INS_USER CONSTRAINT CC_BEPATCHESARC_INSUSER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BEPATCHESARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BEPATCHESARC ON BARS.BE_PATCHES_ARC (PATH_NAME, INS_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BE_PATCHES_ARC ***
grant SELECT                                                                 on BE_PATCHES_ARC  to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BE_PATCHES_ARC  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BE_PATCHES_ARC.sql =========*** End **
PROMPT ===================================================================================== 
