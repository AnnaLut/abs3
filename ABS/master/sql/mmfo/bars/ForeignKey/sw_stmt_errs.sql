

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SW_STMT_ERRS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SWSTMTERRS_SWJOURNAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_STMT_ERRS ADD CONSTRAINT FK_SWSTMTERRS_SWJOURNAL FOREIGN KEY (STMT_SWREF)
	  REFERENCES BARS.SW_JOURNAL (SWREF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWSTMTERRS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_STMT_ERRS ADD CONSTRAINT FK_SWSTMTERRS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SW_STMT_ERRS.sql =========*** End
PROMPT ===================================================================================== 
