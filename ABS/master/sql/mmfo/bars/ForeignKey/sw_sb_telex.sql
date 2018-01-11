

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SW_SB_TELEX.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SWSBTELEX_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_SB_TELEX ADD CONSTRAINT FK_SWSBTELEX_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWSBTELEX_SWJOURNAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_SB_TELEX ADD CONSTRAINT FK_SWSBTELEX_SWJOURNAL FOREIGN KEY (SWREF)
	  REFERENCES BARS.SW_JOURNAL (SWREF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWSBTELEX_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_SB_TELEX ADD CONSTRAINT FK_SWSBTELEX_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SW_SB_TELEX.sql =========*** End 
PROMPT ===================================================================================== 
