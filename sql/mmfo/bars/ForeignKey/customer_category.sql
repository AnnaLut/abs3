

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMER_CATEGORY.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CUSTOMERCTG_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_CATEGORY ADD CONSTRAINT FK_CUSTOMERCTG_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERCTG_FMCATEGORY ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_CATEGORY ADD CONSTRAINT FK_CUSTOMERCTG_FMCATEGORY FOREIGN KEY (CATEGORY_ID)
	  REFERENCES BARS.FM_CATEGORY (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERCTG_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_CATEGORY ADD CONSTRAINT FK_CUSTOMERCTG_STAFF FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMER_CATEGORY.sql =========**
PROMPT ===================================================================================== 
