

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/KL_CUSTOMERW.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_KLCUSTOMERW_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_CUSTOMERW ADD CONSTRAINT FK_KLCUSTOMERW_RNK FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLCUSTOMERW_TAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_CUSTOMERW ADD CONSTRAINT FK_KLCUSTOMERW_TAG FOREIGN KEY (TAG)
	  REFERENCES BARS.KL_OPFIELDS (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/KL_CUSTOMERW.sql =========*** End
PROMPT ===================================================================================== 
