

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STO_PRODUCT_BRANCH.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PROD_BRANCH_REF_PROD ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT_BRANCH ADD CONSTRAINT FK_PROD_BRANCH_REF_PROD FOREIGN KEY (PRODUCT_ID)
	  REFERENCES BARS.STO_PRODUCT (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PROD_BRANCH_REF_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PRODUCT_BRANCH ADD CONSTRAINT FK_PROD_BRANCH_REF_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STO_PRODUCT_BRANCH.sql =========*
PROMPT ===================================================================================== 
