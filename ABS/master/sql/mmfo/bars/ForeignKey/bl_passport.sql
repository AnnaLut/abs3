

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BL_PASSPORT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint BL_PASSPORT_BASE ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_PASSPORT ADD CONSTRAINT BL_PASSPORT_BASE FOREIGN KEY (BASE_ID)
	  REFERENCES BARS.BL_BASE_DICT (BASE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint BL_PASSPORT_PERSON_FK ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_PASSPORT ADD CONSTRAINT BL_PASSPORT_PERSON_FK FOREIGN KEY (BASE_ID, PERSON_ID)
	  REFERENCES BARS.BL_PERSON (BASE_ID, PERSON_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint BL_PASSPORT_USER_FK ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_PASSPORT ADD CONSTRAINT BL_PASSPORT_USER_FK FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BL_PASSPORT.sql =========*** End 
PROMPT ===================================================================================== 
