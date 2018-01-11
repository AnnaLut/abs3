

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_FILE_ROW_ACCUM.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTFILEROWACCUM_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_ROW_ACCUM ADD CONSTRAINT FK_DPTFILEROWACCUM_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_FILE_ROW_ACCUM.sql =========*
PROMPT ===================================================================================== 
