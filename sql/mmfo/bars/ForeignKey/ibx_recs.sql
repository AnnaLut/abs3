

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/IBX_RECS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_IBXRS_FNAME_IBXFS ***
begin   
 execute immediate '
  ALTER TABLE BARS.IBX_RECS ADD CONSTRAINT FK_IBXRS_FNAME_IBXFS FOREIGN KEY (TYPE_ID, FILE_NAME)
	  REFERENCES BARS.IBX_FILES (TYPE_ID, FILE_NAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_IBXRS_ABSREF_OPER ***
begin   
 execute immediate '
  ALTER TABLE BARS.IBX_RECS ADD CONSTRAINT FK_IBXRS_ABSREF_OPER FOREIGN KEY (ABS_REF)
	  REFERENCES BARS.OPER (REF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/IBX_RECS.sql =========*** End ***
PROMPT ===================================================================================== 
