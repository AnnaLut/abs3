

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/TMP_INTARC.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_TMPINTARC_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTARC ADD CONSTRAINT FK_TMPINTARC_TABVAL FOREIGN KEY (LCV)
	  REFERENCES BARS.TABVAL$GLOBAL (LCV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTARC_TABVAL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTARC ADD CONSTRAINT FK_TMPINTARC_TABVAL2 FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTARC_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTARC ADD CONSTRAINT FK_TMPINTARC_STAFF FOREIGN KEY (USERID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTARC_INTIDN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTARC ADD CONSTRAINT FK_TMPINTARC_INTIDN FOREIGN KEY (ID)
	  REFERENCES BARS.INT_IDN (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTARC_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTARC ADD CONSTRAINT FK_TMPINTARC_PS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTARC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTARC ADD CONSTRAINT FK_TMPINTARC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTARC_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTARC ADD CONSTRAINT FK_TMPINTARC_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/TMP_INTARC.sql =========*** End *
PROMPT ===================================================================================== 
