

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_BCK_RESULTS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_WCSBCKRESULTS_WCSBCKREPORTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_RESULTS ADD CONSTRAINT FK_WCSBCKRESULTS_WCSBCKREPORTS FOREIGN KEY (REP_ID)
	  REFERENCES BARS.WCS_BCK_REPORTS (REP_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WCSBCKRESULTS_WCSBCKXMLBLK ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_RESULTS ADD CONSTRAINT FK_WCSBCKRESULTS_WCSBCKXMLBLK FOREIGN KEY (TAG_BLOCK)
	  REFERENCES BARS.WCS_BCK_XMLBLOCKS (BLOCK_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WCSBCKRESULTS_WCSBCKRTAGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_RESULTS ADD CONSTRAINT FK_WCSBCKRESULTS_WCSBCKRTAGS FOREIGN KEY (TAG_NAME, TAG_BLOCK)
	  REFERENCES BARS.WCS_BCK_TAGS (TAG_NAME, TAG_BLOCK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_BCK_RESULTS.sql =========*** 
PROMPT ===================================================================================== 
