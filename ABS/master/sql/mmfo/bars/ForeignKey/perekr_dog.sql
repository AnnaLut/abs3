

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/PEREKR_DOG.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PEREKR_DOG_PEREKR_G ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_DOG ADD CONSTRAINT FK_PEREKR_DOG_PEREKR_G FOREIGN KEY (KF, IDG)
	  REFERENCES BARS.PEREKR_G (KF, IDG) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/PEREKR_DOG.sql =========*** End *
PROMPT ===================================================================================== 
