

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ASYNC_RUN_OBJECT.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ASNROBJ_ROBJT ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_RUN_OBJECT ADD CONSTRAINT FK_ASNROBJ_ROBJT FOREIGN KEY (OBJ_TYPE_ID)
	  REFERENCES BARS.ASYNC_RUN_OBJ_TYPE (OBJ_TYPE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ASNROBJ_PREACT ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_RUN_OBJECT ADD CONSTRAINT FK_ASNROBJ_PREACT FOREIGN KEY (PRE_ACTION_ID)
	  REFERENCES BARS.ASYNC_ACTION (ACTION_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ASNROBJ_ACT ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_RUN_OBJECT ADD CONSTRAINT FK_ASNROBJ_ACT FOREIGN KEY (ACTION_ID)
	  REFERENCES BARS.ASYNC_ACTION (ACTION_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ASNROBJ_POSTACT ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_RUN_OBJECT ADD CONSTRAINT FK_ASNROBJ_POSTACT FOREIGN KEY (POST_ACTION_ID)
	  REFERENCES BARS.ASYNC_ACTION (ACTION_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ASYNC_RUN_OBJECT.sql =========***
PROMPT ===================================================================================== 
