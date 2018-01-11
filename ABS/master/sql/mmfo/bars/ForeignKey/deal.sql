

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DEAL.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DEAL_REF_PRODUCT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL ADD CONSTRAINT FK_DEAL_REF_PRODUCT FOREIGN KEY (PRODUCT_ID)
	  REFERENCES BARS.DEAL_PRODUCT (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DEAL_REFERENCE_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL ADD CONSTRAINT FK_DEAL_REFERENCE_CUSTOMER FOREIGN KEY (CUSTOMER_ID)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DEAL_REFERENCE_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL ADD CONSTRAINT FK_DEAL_REFERENCE_BRANCH FOREIGN KEY (BRANCH_ID)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DEAL_REF_CURATOR ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL ADD CONSTRAINT FK_DEAL_REF_CURATOR FOREIGN KEY (CURATOR_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DEAL_REF_OBJ_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL ADD CONSTRAINT FK_DEAL_REF_OBJ_TYPE FOREIGN KEY (DEAL_TYPE_ID)
	  REFERENCES BARS.OBJECT_TYPE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DEAL.sql =========*** End *** ===
PROMPT ===================================================================================== 
