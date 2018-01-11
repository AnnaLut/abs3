

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/RNBU_IN_INF_RECORDS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_RNBU_IN_RECORDS_FILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNBU_IN_INF_RECORDS ADD CONSTRAINT FK_RNBU_IN_RECORDS_FILES FOREIGN KEY (FILE_ID)
	  REFERENCES BARS.RNBU_IN_FILES (FILE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_RNBUININFRECORDS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNBU_IN_INF_RECORDS ADD CONSTRAINT FK_RNBUININFRECORDS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_RNBUININFRECORDS_RNBUINFILE ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNBU_IN_INF_RECORDS ADD CONSTRAINT FK_RNBUININFRECORDS_RNBUINFILE FOREIGN KEY (KF, FILE_ID)
	  REFERENCES BARS.RNBU_IN_FILES (KF, FILE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/RNBU_IN_INF_RECORDS.sql =========
PROMPT ===================================================================================== 
