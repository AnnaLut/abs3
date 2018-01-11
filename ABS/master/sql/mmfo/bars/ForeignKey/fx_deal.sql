

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/FX_DEAL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_FXDEAL_SWBANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL ADD CONSTRAINT FK_FXDEAL_SWBANKS FOREIGN KEY (SWI_BIC)
	  REFERENCES BARS.SW_BANKS (BIC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FXDEAL_SWJOURNAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL ADD CONSTRAINT FK_FXDEAL_SWJOURNAL FOREIGN KEY (SWI_REF)
	  REFERENCES BARS.SW_JOURNAL (SWREF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FXDEAL_SWBANKS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL ADD CONSTRAINT FK_FXDEAL_SWBANKS2 FOREIGN KEY (SWO_BIC)
	  REFERENCES BARS.SW_BANKS (BIC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FXDEAL_SWJOURNAL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL ADD CONSTRAINT FK_FXDEAL_SWJOURNAL2 FOREIGN KEY (SWO_REF)
	  REFERENCES BARS.SW_JOURNAL (SWREF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FXDEAL_SWBANKS3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL ADD CONSTRAINT FK_FXDEAL_SWBANKS3 FOREIGN KEY (BICB)
	  REFERENCES BARS.SW_BANKS (BIC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/FX_DEAL.sql =========*** End *** 
PROMPT ===================================================================================== 
