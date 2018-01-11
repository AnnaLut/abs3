

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/KL_CUSTOMER_PARAMS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CUSTOMER_PARAMS_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_CUSTOMER_PARAMS ADD CONSTRAINT FK_CUSTOMER_PARAMS_RNK FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/KL_CUSTOMER_PARAMS.sql =========*
PROMPT ===================================================================================== 
