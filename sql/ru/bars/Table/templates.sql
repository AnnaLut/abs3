

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TEMPLATES.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TEMPLATES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TEMPLATES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TEMPLATES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TEMPLATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.TEMPLATES 
   (	KV NUMBER(*,0), 
	TT CHAR(3), 
	PM NUMBER(*,0), 
	KODN_I NUMBER(*,0), 
	KODN_O NUMBER(*,0), 
	TIP_D CHAR(3), 
	WD CHAR(1), 
	TIP_K CHAR(3), 
	WK CHAR(1), 
	COMM VARCHAR2(70), 
	TTL CHAR(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TEMPLATES ***
 exec bpa.alter_policies('TEMPLATES');


COMMENT ON TABLE BARS.TEMPLATES IS 'Шаблоны автоматических проводок (РРП)';
COMMENT ON COLUMN BARS.TEMPLATES.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.TEMPLATES.TT IS 'Тип транзакции';
COMMENT ON COLUMN BARS.TEMPLATES.PM IS 'Метод оплаты (0 - подокументно, 1 - пакетно по заголовкам)';
COMMENT ON COLUMN BARS.TEMPLATES.KODN_I IS 'Код направления';
COMMENT ON COLUMN BARS.TEMPLATES.KODN_O IS 'Код направления';
COMMENT ON COLUMN BARS.TEMPLATES.TIP_D IS 'Тип счета';
COMMENT ON COLUMN BARS.TEMPLATES.WD IS 'Чей счет ДЕБЕТ (A|B)';
COMMENT ON COLUMN BARS.TEMPLATES.TIP_K IS 'Тип счета';
COMMENT ON COLUMN BARS.TEMPLATES.WK IS 'Чей счет КРЕДИТ (A|B)';
COMMENT ON COLUMN BARS.TEMPLATES.COMM IS '';
COMMENT ON COLUMN BARS.TEMPLATES.TTL IS '';




PROMPT *** Create  constraint R_TTS_TEMPL_TTL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TEMPLATES ADD CONSTRAINT R_TTS_TEMPL_TTL FOREIGN KEY (TTL)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_TTS_TEMPL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TEMPLATES ADD CONSTRAINT R_TTS_TEMPL FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_TABVAL_TEMPLATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.TEMPLATES ADD CONSTRAINT R_TABVAL_TEMPLATES FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_PM_TEMPL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TEMPLATES ADD CONSTRAINT R_PM_TEMPL FOREIGN KEY (PM)
	  REFERENCES BARS.PM_RRP (PM) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_DIR_TEMPL_OUT ***
begin   
 execute immediate '
  ALTER TABLE BARS.TEMPLATES ADD CONSTRAINT R_DIR_TEMPL_OUT FOREIGN KEY (KODN_O)
	  REFERENCES BARS.DIR_RRP (KODN) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_DIR_TEMPL_IN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TEMPLATES ADD CONSTRAINT R_DIR_TEMPL_IN FOREIGN KEY (KODN_I)
	  REFERENCES BARS.DIR_RRP (KODN) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0011742 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TEMPLATES MODIFY (KODN_O NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0011741 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TEMPLATES MODIFY (KODN_I NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XFK_KV_TEMPLATES ***
begin   
 execute immediate '
  CREATE INDEX BARS.XFK_KV_TEMPLATES ON BARS.TEMPLATES (KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TEMPLATES ***
grant SELECT                                                                 on TEMPLATES       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TEMPLATES       to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TEMPLATES       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TEMPLATES.sql =========*** End *** ===
PROMPT ===================================================================================== 
