

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/POLICY_RESPONSIBLE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_POLICYRESP_DEVELOPERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_RESPONSIBLE ADD CONSTRAINT FK_POLICYRESP_DEVELOPERS FOREIGN KEY (RESPONSIBLE_DEVELOPER)
	  REFERENCES BARS.DEVELOPERS (DEVELOPER_NICK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/POLICY_RESPONSIBLE.sql =========*
PROMPT ===================================================================================== 
