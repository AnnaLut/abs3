

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/PRVN_FLOW_DEALS_VAR.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PRVNDEALSVAR_PRVNDEALSCONST ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_FLOW_DEALS_VAR ADD CONSTRAINT FK_PRVNDEALSVAR_PRVNDEALSCONST FOREIGN KEY (ID)
	  REFERENCES BARS.PRVN_FLOW_DEALS_CONST (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/PRVN_FLOW_DEALS_VAR.sql =========
PROMPT ===================================================================================== 
