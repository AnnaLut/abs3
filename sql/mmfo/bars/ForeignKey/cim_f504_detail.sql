

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CIM_F504_DETAIL.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_F504_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F504_DETAIL ADD CONSTRAINT FK_F504_ID FOREIGN KEY (F504_ID)
	  REFERENCES BARS.CIM_F504 (F504_ID) ON DELETE CASCADE DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CIM_F504_DETAIL.sql =========*** 
PROMPT ===================================================================================== 
