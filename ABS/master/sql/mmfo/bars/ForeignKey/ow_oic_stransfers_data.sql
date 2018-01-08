

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OW_OIC_STRANSFERS_DATA.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OWOICSTRNDATA_OWFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_STRANSFERS_DATA ADD CONSTRAINT FK_OWOICSTRNDATA_OWFILES FOREIGN KEY (ID)
	  REFERENCES BARS.OW_FILES (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OWOICSTRANSFERSDATA_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_STRANSFERS_DATA ADD CONSTRAINT FK_OWOICSTRANSFERSDATA_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OW_OIC_STRANSFERS_DATA.sql ======
PROMPT ===================================================================================== 
