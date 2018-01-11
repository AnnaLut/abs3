

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_MENU.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SKRYNKA_MENU_VOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_MENU ADD CONSTRAINT FK_SKRYNKA_MENU_VOB FOREIGN KEY (VOB)
	  REFERENCES BARS.VOB (VOB) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKAMENU_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_MENU ADD CONSTRAINT FK_SKRYNKAMENU_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKA_MENU_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_MENU ADD CONSTRAINT FK_SKRYNKA_MENU_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKA_MENU_TT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_MENU ADD CONSTRAINT FK_SKRYNKA_MENU_TT FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKA_MENU_TT2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_MENU ADD CONSTRAINT FK_SKRYNKA_MENU_TT2 FOREIGN KEY (TT2)
	  REFERENCES BARS.TTS (TT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKA_MENU_TT3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_MENU ADD CONSTRAINT FK_SKRYNKA_MENU_TT3 FOREIGN KEY (TT3)
	  REFERENCES BARS.TTS (TT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKA_MENU_VOB2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_MENU ADD CONSTRAINT FK_SKRYNKA_MENU_VOB2 FOREIGN KEY (VOB2)
	  REFERENCES BARS.VOB (VOB) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKA_MENU_VOB3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_MENU ADD CONSTRAINT FK_SKRYNKA_MENU_VOB3 FOREIGN KEY (VOB3)
	  REFERENCES BARS.VOB (VOB) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_MENU.sql =========*** End
PROMPT ===================================================================================== 
