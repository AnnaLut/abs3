

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/NBS_TIPS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_NBSTIPS_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_TIPS ADD CONSTRAINT FK_NBSTIPS_NBS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NBSTIPS_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_TIPS ADD CONSTRAINT FK_NBSTIPS_TIP FOREIGN KEY (TIP)
	  REFERENCES BARS.TIPS (TIP) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NBSTIPS_SBOB22 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_TIPS ADD CONSTRAINT FK_NBSTIPS_SBOB22 FOREIGN KEY (NBS, OB22)
	  REFERENCES BARS.SB_OB22 (R020, OB22) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/NBS_TIPS.sql =========*** End ***
PROMPT ===================================================================================== 
