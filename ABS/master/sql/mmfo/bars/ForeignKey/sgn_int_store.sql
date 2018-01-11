

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SGN_INT_STORE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SGNINTSTORE_OPER_VISA_REF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_INT_STORE ADD CONSTRAINT FK_SGNINTSTORE_OPER_VISA_REF FOREIGN KEY (REC_ID)
	  REFERENCES BARS.OPER_VISA (SQNC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SGNINTSTORE_SGNDATA_REF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_INT_STORE ADD CONSTRAINT FK_SGNINTSTORE_SGNDATA_REF FOREIGN KEY (SIGN_ID)
	  REFERENCES BARS.SGN_DATA (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SGN_INT_STORE.sql =========*** En
PROMPT ===================================================================================== 
