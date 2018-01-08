

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OBPC_OUT_FILES.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OBPCOUTFILES_TIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_OUT_FILES ADD CONSTRAINT FK_OBPCOUTFILES_TIPS FOREIGN KEY (ACC_TYPE)
	  REFERENCES BARS.TIPS (TIP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OBPC_OUT_FILES.sql =========*** E
PROMPT ===================================================================================== 
