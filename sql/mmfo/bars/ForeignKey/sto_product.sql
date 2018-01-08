

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STO_PRODUCT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_STO_PROD_REFERENCE_STO_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT ADD CONSTRAINT FK_STO_PROD_REFERENCE_STO_TYPE FOREIGN KEY (ORDER_TYPE_ID)
	  REFERENCES BARS.STO_TYPE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STO_PROD_REF_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT ADD CONSTRAINT FK_STO_PROD_REF_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STOPRODUCT_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT ADD CONSTRAINT FK_STOPRODUCT_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STO_PRODUCT.sql =========*** End 
PROMPT ===================================================================================== 
