

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BANKS$SETTINGS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BANKSSETTINGS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS$SETTINGS ADD CONSTRAINT FK_BANKSSETTINGS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANKSSETTINGS_MFO ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS$SETTINGS ADD CONSTRAINT FK_BANKSSETTINGS_MFO FOREIGN KEY (MFO)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANKSSETTINGS_MFOP ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS$SETTINGS ADD CONSTRAINT FK_BANKSSETTINGS_MFOP FOREIGN KEY (MFOP)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANKSSETTINGS_KODN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS$SETTINGS ADD CONSTRAINT FK_BANKSSETTINGS_KODN FOREIGN KEY (KODN)
	  REFERENCES BARS.DIR_RRP (KODN) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANKSSETTINGS_PM ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS$SETTINGS ADD CONSTRAINT FK_BANKSSETTINGS_PM FOREIGN KEY (PM)
	  REFERENCES BARS.PM_RRP (PM) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BANKS$SETTINGS.sql =========*** E
PROMPT ===================================================================================== 
