

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/KLP_VERSION.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_KLPVERSION_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_VERSION ADD CONSTRAINT FK_KLPVERSION_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLPVERSION_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_VERSION ADD CONSTRAINT FK_KLPVERSION_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/KLP_VERSION.sql =========*** End 
PROMPT ===================================================================================== 
