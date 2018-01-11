

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BRANCH_UO.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BRANCHUO_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_UO ADD CONSTRAINT FK_BRANCHUO_ID FOREIGN KEY (IDPDR)
	  REFERENCES BARS.MONEX_UO (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BRANCH_UO.sql =========*** End **
PROMPT ===================================================================================== 
