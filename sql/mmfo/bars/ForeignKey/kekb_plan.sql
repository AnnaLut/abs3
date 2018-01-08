

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/KEKB_PLAN.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint R_KEKB_PLAN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KEKB_PLAN ADD CONSTRAINT R_KEKB_PLAN FOREIGN KEY (KEKB)
	  REFERENCES BARS.KEKB (KEKB) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/KEKB_PLAN.sql =========*** End **
PROMPT ===================================================================================== 
