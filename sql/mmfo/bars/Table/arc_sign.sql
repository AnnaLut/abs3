

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ARC_SIGN.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ARC_SIGN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ARC_SIGN'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ARC_SIGN'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ARC_SIGN'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ARC_SIGN ***
begin 
  execute immediate '
  CREATE TABLE BARS.ARC_SIGN 
   (	SEQ NUMBER(38,0), 
	SIGN_TIME DATE, 
	REC NUMBER(38,0), 
	REF NUMBER(38,0), 
	SIGN_KEY VARCHAR2(16), 
	SIGN RAW(128), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ARC_SIGN ***
 exec bpa.alter_policies('ARC_SIGN');


COMMENT ON TABLE BARS.ARC_SIGN IS 'История ЭЦП при переподписывании';
COMMENT ON COLUMN BARS.ARC_SIGN.SEQ IS 'порядковый номер ЭЦП';
COMMENT ON COLUMN BARS.ARC_SIGN.SIGN_TIME IS 'время переподписывания';
COMMENT ON COLUMN BARS.ARC_SIGN.REC IS 'Идентификатор строки в ARC_RRP';
COMMENT ON COLUMN BARS.ARC_SIGN.REF IS 'Идентификатор документа';
COMMENT ON COLUMN BARS.ARC_SIGN.SIGN_KEY IS 'Идентификатор ключа подписи';
COMMENT ON COLUMN BARS.ARC_SIGN.SIGN IS 'Подпись';
COMMENT ON COLUMN BARS.ARC_SIGN.KF IS '';




PROMPT *** Create  constraint PK_ARCSIGN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ARC_SIGN ADD CONSTRAINT PK_ARCSIGN PRIMARY KEY (SEQ)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ARCSIGN_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ARC_SIGN ADD CONSTRAINT FK_ARCSIGN_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005913 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ARC_SIGN MODIFY (SEQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005914 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ARC_SIGN MODIFY (REC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ARCSIGN_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ARC_SIGN MODIFY (KF CONSTRAINT CC_ARCSIGN_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_ARCSIGN_REC ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_ARCSIGN_REC ON BARS.ARC_SIGN (REC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ARCSIGN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ARCSIGN ON BARS.ARC_SIGN (SEQ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ARC_SIGN ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ARC_SIGN        to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on ARC_SIGN        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ARC_SIGN        to BARS_DM;
grant SELECT                                                                 on ARC_SIGN        to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ARC_SIGN        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ARC_SIGN.sql =========*** End *** ====
PROMPT ===================================================================================== 
