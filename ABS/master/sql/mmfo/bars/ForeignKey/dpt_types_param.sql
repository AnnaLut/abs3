

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_TYPES_PARAM.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTTYPESPARAM_DPTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TYPES_PARAM ADD CONSTRAINT FK_DPTTYPESPARAM_DPTTYPE FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.DPT_TYPES (TYPE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_TYPES_PARAM.sql =========*** 
PROMPT ===================================================================================== 
