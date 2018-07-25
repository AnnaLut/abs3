

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OB_CORP_DATA_ACC.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OB_CORP_DATA_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORP_DATA_ACC ADD CONSTRAINT FK_OB_CORP_DATA_ACC FOREIGN KEY (SESS_ID, KF)
	  REFERENCES BARS.OB_CORP_SESS (ID, KF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OB_CORP_DATA_ACC.sql =========***
PROMPT ===================================================================================== 

