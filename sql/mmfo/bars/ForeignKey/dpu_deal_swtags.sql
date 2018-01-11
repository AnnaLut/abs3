

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPU_DEAL_SWTAGS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPUDEALSWTAGS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_SWTAGS ADD CONSTRAINT FK_DPUDEALSWTAGS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUDEALSWTAGS_DPUDEAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_SWTAGS ADD CONSTRAINT FK_DPUDEALSWTAGS_DPUDEAL FOREIGN KEY (DPU_ID)
	  REFERENCES BARS.DPU_DEAL (DPU_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPU_DEAL_SWTAGS.sql =========*** 
PROMPT ===================================================================================== 
