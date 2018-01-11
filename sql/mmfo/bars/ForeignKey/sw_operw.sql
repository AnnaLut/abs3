

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SW_OPERW.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SWOPERW_SWJOURNAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPERW ADD CONSTRAINT FK_SWOPERW_SWJOURNAL FOREIGN KEY (SWREF)
	  REFERENCES BARS.SW_JOURNAL (SWREF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWOPERW_SWTAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPERW ADD CONSTRAINT FK_SWOPERW_SWTAG FOREIGN KEY (TAG)
	  REFERENCES BARS.SW_TAG (TAG) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWOPERW_SWSEQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPERW ADD CONSTRAINT FK_SWOPERW_SWSEQ FOREIGN KEY (SEQ)
	  REFERENCES BARS.SW_SEQ (SEQ) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWOPERW_SWOPT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPERW ADD CONSTRAINT FK_SWOPERW_SWOPT FOREIGN KEY (OPT)
	  REFERENCES BARS.SW_OPT (OPT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWOPERW_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPERW ADD CONSTRAINT FK_SWOPERW_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SW_OPERW.sql =========*** End ***
PROMPT ===================================================================================== 
