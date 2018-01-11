

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_STOP_A.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTSTOPA_DPTSHTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STOP_A ADD CONSTRAINT FK_DPTSTOPA_DPTSHTYPE FOREIGN KEY (SH_PROC)
	  REFERENCES BARS.DPT_SHTYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint DPT_ST2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STOP_A ADD CONSTRAINT DPT_ST2 FOREIGN KEY (ID)
	  REFERENCES BARS.DPT_STOP (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTSTOPA_DPTSHTERM ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STOP_A ADD CONSTRAINT FK_DPTSTOPA_DPTSHTERM FOREIGN KEY (SH_TERM)
	  REFERENCES BARS.DPT_SHTERM (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_STOP_A.sql =========*** End *
PROMPT ===================================================================================== 
