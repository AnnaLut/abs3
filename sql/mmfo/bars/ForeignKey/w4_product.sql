

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/W4_PRODUCT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_W4PRODUCT_W4NBSOB22 ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT ADD CONSTRAINT FK_W4PRODUCT_W4NBSOB22 FOREIGN KEY (NBS, OB22, TIP)
	  REFERENCES BARS.W4_NBS_OB22 (NBS, OB22, TIP) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_W4PRODUCT_W4PRODUCTGROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT ADD CONSTRAINT FK_W4PRODUCT_W4PRODUCTGROUPS FOREIGN KEY (GRP_CODE)
	  REFERENCES BARS.W4_PRODUCT_GROUPS (CODE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_W4PRODUCT_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT ADD CONSTRAINT FK_W4PRODUCT_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/W4_PRODUCT.sql =========*** End *
PROMPT ===================================================================================== 
