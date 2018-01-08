

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BMS_MESSAGE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BMS_MESSAGE_REF_MESSG_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.BMS_MESSAGE ADD CONSTRAINT FK_BMS_MESSAGE_REF_MESSG_TYPE FOREIGN KEY (MESSAGE_TYPE_ID)
	  REFERENCES BARS.BMS_MESSAGE_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BMS_MESSAGE.sql =========*** End 
PROMPT ===================================================================================== 
