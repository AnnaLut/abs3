

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ZAPROS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ZAPROS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAPROS ADD CONSTRAINT FK_ZAPROS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAPROS_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAPROS ADD CONSTRAINT FK_ZAPROS_STAFF FOREIGN KEY (CREATOR)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAPROS_STAFF2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAPROS ADD CONSTRAINT FK_ZAPROS_STAFF2 FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ZAPROS.sql =========*** End *** =
PROMPT ===================================================================================== 
