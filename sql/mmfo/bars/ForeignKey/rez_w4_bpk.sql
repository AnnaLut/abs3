

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/REZ_W4_BPK.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_REZW4BPK_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_W4_BPK ADD CONSTRAINT FK_REZW4BPK_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/REZ_W4_BPK.sql =========*** End *
PROMPT ===================================================================================== 
