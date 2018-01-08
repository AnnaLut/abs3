

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BL_LOST_PASS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint BL_LOST_BASE ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_LOST_PASS ADD CONSTRAINT BL_LOST_BASE FOREIGN KEY (BASE_ID)
	  REFERENCES BARS.BL_BASE_DICT (BASE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BL_LOST_PASS.sql =========*** End
PROMPT ===================================================================================== 
