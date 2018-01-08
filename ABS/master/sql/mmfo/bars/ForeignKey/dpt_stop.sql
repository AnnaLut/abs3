

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_STOP.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTSTOP_DPTSHTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STOP ADD CONSTRAINT FK_DPTSTOP_DPTSHTYPE FOREIGN KEY (SH_PROC)
	  REFERENCES BARS.DPT_SHTYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTSTOP_DPTSHOST ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STOP ADD CONSTRAINT FK_DPTSTOP_DPTSHOST FOREIGN KEY (SH_OST)
	  REFERENCES BARS.DPT_SHOST (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTSTOP_DPTSHSROK ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STOP ADD CONSTRAINT FK_DPTSTOP_DPTSHSROK FOREIGN KEY (FL)
	  REFERENCES BARS.DPT_SHSROK (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_STOP.sql =========*** End ***
PROMPT ===================================================================================== 
