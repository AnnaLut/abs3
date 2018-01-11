

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BPK_CREDIT_DEAL_VAR.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BPKCRDTDEALVAR_BPKCRDTDEAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_CREDIT_DEAL_VAR ADD CONSTRAINT FK_BPKCRDTDEALVAR_BPKCRDTDEAL FOREIGN KEY (DEAL_ND)
	  REFERENCES BARS.BPK_CREDIT_DEAL (DEAL_ND) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BPK_CREDIT_DEAL_VAR.sql =========
PROMPT ===================================================================================== 
