

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ACCOUNTS_RSRV.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ACCRSRV_MVKF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_RSRV ADD CONSTRAINT FK_ACCRSRV_MVKF FOREIGN KEY (KF)
	  REFERENCES BARS.MV_KF (KF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ACCOUNTS_RSRV.sql =========*** En
PROMPT ===================================================================================== 
