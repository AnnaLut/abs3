

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_MENU.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_MENU ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_MENU'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_MENU'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SKRYNKA_MENU'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_MENU ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_MENU 
   (	ITEM NUMBER, 
	NAME VARCHAR2(100), 
	TYPE VARCHAR2(5), 
	DATENAME1 VARCHAR2(30), 
	DATENAME2 VARCHAR2(30), 
	TT CHAR(3), 
	SK NUMBER, 
	TT2 CHAR(3), 
	TT3 CHAR(3), 
	VOB NUMBER, 
	VOB2 NUMBER, 
	VOB3 NUMBER, 
	NUMPARNAME VARCHAR2(30), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/



begin 
  execute immediate 'ALTER TABLE BARS.SKRYNKA_MENU ADD (STRPARNAME VARCHAR2(30))';
exception when others then       
  if sqlcode=-1430  then null; else raise; end if; 
end;
/ 


PROMPT *** ALTER_POLICIES to SKRYNKA_MENU ***
 exec bpa.alter_policies('SKRYNKA_MENU');


COMMENT ON TABLE BARS.SKRYNKA_MENU IS '';
COMMENT ON COLUMN BARS.SKRYNKA_MENU.ITEM IS '';
COMMENT ON COLUMN BARS.SKRYNKA_MENU.NAME IS '';
COMMENT ON COLUMN BARS.SKRYNKA_MENU.TYPE IS '';
COMMENT ON COLUMN BARS.SKRYNKA_MENU.DATENAME1 IS '';
COMMENT ON COLUMN BARS.SKRYNKA_MENU.DATENAME2 IS '';
COMMENT ON COLUMN BARS.SKRYNKA_MENU.TT IS '';
COMMENT ON COLUMN BARS.SKRYNKA_MENU.SK IS '';
COMMENT ON COLUMN BARS.SKRYNKA_MENU.TT2 IS '';
COMMENT ON COLUMN BARS.SKRYNKA_MENU.TT3 IS '';
COMMENT ON COLUMN BARS.SKRYNKA_MENU.VOB IS '';
COMMENT ON COLUMN BARS.SKRYNKA_MENU.VOB2 IS '';
COMMENT ON COLUMN BARS.SKRYNKA_MENU.VOB3 IS '';
COMMENT ON COLUMN BARS.SKRYNKA_MENU.NUMPARNAME IS '';
COMMENT ON COLUMN BARS.SKRYNKA_MENU.BRANCH IS '';
COMMENT ON COLUMN BARS.SKRYNKA_MENU.KF IS '';




PROMPT *** Create  constraint FK_SKRYNKA_MENU_VOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_MENU ADD CONSTRAINT FK_SKRYNKA_MENU_VOB FOREIGN KEY (VOB)
	  REFERENCES BARS.VOB (VOB) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XUK_SKRYNKA_MENU_NAME ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_MENU ADD CONSTRAINT XUK_SKRYNKA_MENU_NAME UNIQUE (NAME, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKAMENU_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_MENU MODIFY (KF CONSTRAINT CC_SKRYNKAMENU_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKAMENU_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_MENU MODIFY (BRANCH CONSTRAINT CC_SKRYNKAMENU_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKAMENU_ITEM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_MENU MODIFY (ITEM CONSTRAINT CC_SKRYNKAMENU_ITEM_NN NOT NULL ENABLE)';
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




PROMPT *** Create  constraint FK_SKRYNKA_MENU_VOB2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_MENU ADD CONSTRAINT FK_SKRYNKA_MENU_VOB2 FOREIGN KEY (VOB2)
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




PROMPT *** Create  constraint PK_SKRYNKAMENU ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_MENU ADD CONSTRAINT PK_SKRYNKAMENU PRIMARY KEY (KF, ITEM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
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




PROMPT *** Create  index XUK_SKRYNKA_MENU_NAME ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XUK_SKRYNKA_MENU_NAME ON BARS.SKRYNKA_MENU (NAME, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SKRYNKAMENU ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SKRYNKAMENU ON BARS.SKRYNKA_MENU (KF, ITEM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_MENU ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SKRYNKA_MENU    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SKRYNKA_MENU    to BARS_DM;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SKRYNKA_MENU    to DEP_SKRN;
grant SELECT                                                                 on SKRYNKA_MENU    to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SKRYNKA_MENU    to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SKRYNKA_MENU    to WR_REFREAD;



PROMPT *** Create SYNONYM  to SKRYNKA_MENU ***

  CREATE OR REPLACE PUBLIC SYNONYM SKRYNKA_MENU FOR BARS.SKRYNKA_MENU;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_MENU.sql =========*** End *** 
PROMPT ===================================================================================== 
