

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_DICT_PENSION.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPT_DICT_PENSION ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DICT_PENSION ADD CONSTRAINT FK_DPT_DICT_PENSION FOREIGN KEY (SEX)
	  REFERENCES BARS.SEX (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_DICT_PENSION.sql =========***
PROMPT ===================================================================================== 
