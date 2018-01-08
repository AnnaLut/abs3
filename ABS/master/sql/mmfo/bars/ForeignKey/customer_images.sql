

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMER_IMAGES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CUSTOMERIMGS_TYPEIMG ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_IMAGES ADD CONSTRAINT FK_CUSTOMERIMGS_TYPEIMG FOREIGN KEY (TYPE_IMG)
	  REFERENCES BARS.CUSTOMER_IMAGE_TYPES (TYPE_IMG) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMER_IMAGES.sql =========*** 
PROMPT ===================================================================================== 
