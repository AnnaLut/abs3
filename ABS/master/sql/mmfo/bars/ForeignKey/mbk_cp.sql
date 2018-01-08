

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/MBK_CP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_MBKCP_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBK_CP ADD CONSTRAINT FK_MBKCP_ND FOREIGN KEY (ND)
	  REFERENCES BARS.CC_DEAL (ND) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/MBK_CP.sql =========*** End *** =
PROMPT ===================================================================================== 
