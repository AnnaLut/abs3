

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/W4_PRODUCT_GROUPS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_W4PRODUCTGROUPS_BPKSCHEME ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT_GROUPS ADD CONSTRAINT FK_W4PRODUCTGROUPS_BPKSCHEME FOREIGN KEY (SCHEME_ID)
	  REFERENCES BARS.BPK_SCHEME (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/W4_PRODUCT_GROUPS.sql =========**
PROMPT ===================================================================================== 
