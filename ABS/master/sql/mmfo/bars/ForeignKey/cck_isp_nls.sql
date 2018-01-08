

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CCK_ISP_NLS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint CCK_ISP_NLS_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_ISP_NLS ADD CONSTRAINT CCK_ISP_NLS_STAFF FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CCK_ISP_NLS_ISP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_ISP_NLS ADD CONSTRAINT CCK_ISP_NLS_ISP FOREIGN KEY (ISP)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CCK_ISP_NLS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_ISP_NLS ADD CONSTRAINT CCK_ISP_NLS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CCK_ISP_NLS.sql =========*** End 
PROMPT ===================================================================================== 
