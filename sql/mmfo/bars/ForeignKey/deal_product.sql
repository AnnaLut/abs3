

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DEAL_PRODUCT.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DEAL_PRODUCT_REF_PARENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT ADD CONSTRAINT FK_DEAL_PRODUCT_REF_PARENT FOREIGN KEY (PARENT_PRODUCT_ID)
	  REFERENCES BARS.DEAL_PRODUCT (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DEAL_PROD_REF_OBJ_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT ADD CONSTRAINT FK_DEAL_PROD_REF_OBJ_TYPE FOREIGN KEY (DEAL_TYPE_ID)
	  REFERENCES BARS.OBJECT_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DEAL_PROD_REF_BUSN_SEG ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_PRODUCT ADD CONSTRAINT FK_DEAL_PROD_REF_BUSN_SEG FOREIGN KEY (SEGMENT_OF_BUSINESS_ID)
	  REFERENCES BARS.SEGMENT_OF_BUSINESS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DEAL_PRODUCT.sql =========*** End
PROMPT ===================================================================================== 
