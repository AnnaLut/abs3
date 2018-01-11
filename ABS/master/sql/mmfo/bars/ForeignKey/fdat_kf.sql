

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/FDAT_KF.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_FDATKF_MVKF ***
begin   
 execute immediate '
  ALTER TABLE BARS.FDAT_KF ADD CONSTRAINT FK_FDATKF_MVKF FOREIGN KEY (KF)
	  REFERENCES BARS.MV_KF (KF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/FDAT_KF.sql =========*** End *** 
PROMPT ===================================================================================== 
