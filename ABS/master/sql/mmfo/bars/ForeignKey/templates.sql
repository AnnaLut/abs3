

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/TEMPLATES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_TEMPLATES_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.TEMPLATES ADD CONSTRAINT FK_TEMPLATES_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_DIR_TEMPL_IN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TEMPLATES ADD CONSTRAINT R_DIR_TEMPL_IN FOREIGN KEY (KODN_I)
	  REFERENCES BARS.DIR_RRP (KODN) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_DIR_TEMPL_OUT ***
begin   
 execute immediate '
  ALTER TABLE BARS.TEMPLATES ADD CONSTRAINT R_DIR_TEMPL_OUT FOREIGN KEY (KODN_O)
	  REFERENCES BARS.DIR_RRP (KODN) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_PM_TEMPL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TEMPLATES ADD CONSTRAINT R_PM_TEMPL FOREIGN KEY (PM)
	  REFERENCES BARS.PM_RRP (PM) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_TABVAL_TEMPLATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.TEMPLATES ADD CONSTRAINT R_TABVAL_TEMPLATES FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_TTS_TEMPL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TEMPLATES ADD CONSTRAINT R_TTS_TEMPL FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_TTS_TEMPL_TTL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TEMPLATES ADD CONSTRAINT R_TTS_TEMPL_TTL FOREIGN KEY (TTL)
	  REFERENCES BARS.TTS (TT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/TEMPLATES.sql =========*** End **
PROMPT ===================================================================================== 
