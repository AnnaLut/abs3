

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/MONEX_MV_UO.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_MONEXMVUO_MV ***
begin   
 execute immediate '
  ALTER TABLE BARS.MONEX_MV_UO ADD CONSTRAINT FK_MONEXMVUO_MV FOREIGN KEY (MV)
	  REFERENCES BARS.MONEX0 (KOD_NBU) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_MONEXMVUO_UO ***
begin   
 execute immediate '
  ALTER TABLE BARS.MONEX_MV_UO ADD CONSTRAINT FK_MONEXMVUO_UO FOREIGN KEY (UO)
	  REFERENCES BARS.MONEX_UO (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/MONEX_MV_UO.sql =========*** End 
PROMPT ===================================================================================== 
