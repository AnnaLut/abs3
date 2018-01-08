

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STO_DET_UPDATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_STATUS_ID_UPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET_UPDATE ADD CONSTRAINT FK_STATUS_ID_UPD FOREIGN KEY (STATUS_ID)
	  REFERENCES BARS.STO_STATUS (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DISCLAIM_ID_UPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET_UPDATE ADD CONSTRAINT FK_DISCLAIM_ID_UPD FOREIGN KEY (DISCLAIM_ID)
	  REFERENCES BARS.STO_DISCLAIMER (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STO_DET_UPDATE.sql =========*** E
PROMPT ===================================================================================== 
