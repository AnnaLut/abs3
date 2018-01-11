

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_SYNC_QUEUE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BR_SKRYN_SYNC_QUEUE_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_SYNC_QUEUE ADD CONSTRAINT FK_BR_SKRYN_SYNC_QUEUE_TYPE FOREIGN KEY (SYNC_TYPE)
	  REFERENCES BARS.SKRYNKA_SYNC_TYPE (TYPE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_SYNC_QUEUE.sql =========*
PROMPT ===================================================================================== 
