

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/FIN_QUESTION_REPLY.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_FINQUESTIONREPLY_KOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_QUESTION_REPLY ADD CONSTRAINT FK_FINQUESTIONREPLY_KOD FOREIGN KEY (KOD, IDF)
	  REFERENCES BARS.FIN_QUESTION (KOD, IDF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/FIN_QUESTION_REPLY.sql =========*
PROMPT ===================================================================================== 
