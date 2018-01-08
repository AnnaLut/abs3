

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_TIP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_TIP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_TIP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_TIP'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''SKRYNKA_TIP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_TIP ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_TIP 
   (	O_SK NUMBER, 
	NAME VARCHAR2(25), 
	S NUMBER(15,2), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	ETALON_ID NUMBER(5,0) DEFAULT 0, 
	CELL_COUNT NUMBER(5,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SKRYNKA_TIP ***
 exec bpa.alter_policies('SKRYNKA_TIP');


COMMENT ON TABLE BARS.SKRYNKA_TIP IS 'виды депозитных сейфов';
COMMENT ON COLUMN BARS.SKRYNKA_TIP.O_SK IS 'код вида сейфа (размера)';
COMMENT ON COLUMN BARS.SKRYNKA_TIP.NAME IS 'наименование вида сейфа';
COMMENT ON COLUMN BARS.SKRYNKA_TIP.S IS 'залоговоя стоимость за ключ в формате (дробная часть - копейки)';
COMMENT ON COLUMN BARS.SKRYNKA_TIP.BRANCH IS 'код отделения';
COMMENT ON COLUMN BARS.SKRYNKA_TIP.KF IS '';
COMMENT ON COLUMN BARS.SKRYNKA_TIP.ETALON_ID IS '';
COMMENT ON COLUMN BARS.SKRYNKA_TIP.CELL_COUNT IS '';


begin 
  execute immediate 
    ' ALTER TABLE BARS.SKRYNKA_TIP DROP CONSTRAINT PK_SKRYNKATIP';
exception when others then 
  if sqlcode=-2443 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' DROP INDEX BARS.PK_SKRYNKATIP';
exception when others then 
  if sqlcode=-1418 then null; else raise; end if;
end;
/
 


PROMPT *** Create  constraint UK_SKRYNKATIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TIP ADD CONSTRAINT UK_SKRYNKATIP UNIQUE (KF, O_SK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SKRYNKATIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TIP ADD CONSTRAINT PK_SKRYNKATIP PRIMARY KEY (O_SK, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XUK_SKRYNKA_TIP_NAME ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TIP ADD CONSTRAINT XUK_SKRYNKA_TIP_NAME UNIQUE (NAME, BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYN_TIP_REF_ETALON ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TIP ADD CONSTRAINT FK_SKRYN_TIP_REF_ETALON FOREIGN KEY (ETALON_ID)
	  REFERENCES BARS.SKRYNKA_TIP_ETALON (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKA_TIP_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TIP ADD CONSTRAINT FK_SKRYNKA_TIP_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKATIP_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TIP ADD CONSTRAINT FK_SKRYNKATIP_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKATIP_CELLCOUNT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TIP MODIFY (CELL_COUNT CONSTRAINT CC_SKRYNKATIP_CELLCOUNT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKATIP_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TIP MODIFY (NAME CONSTRAINT CC_SKRYNKATIP_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKATIP_S_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TIP MODIFY (S CONSTRAINT CC_SKRYNKATIP_S_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKATIP_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TIP MODIFY (BRANCH CONSTRAINT CC_SKRYNKATIP_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKATIP_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TIP MODIFY (KF CONSTRAINT CC_SKRYNKATIP_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKATIP_ETALONID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TIP MODIFY (ETALON_ID CONSTRAINT CC_SKRYNKATIP_ETALONID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKATIP_OSK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TIP MODIFY (O_SK CONSTRAINT CC_SKRYNKATIP_OSK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XUK_SKRYNKA_TIP_NAME ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XUK_SKRYNKA_TIP_NAME ON BARS.SKRYNKA_TIP (NAME, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_SKRYNKATIP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_SKRYNKATIP ON BARS.SKRYNKA_TIP (KF, O_SK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SKRYNKATIP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SKRYNKATIP ON BARS.SKRYNKA_TIP (O_SK, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_TIP ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SKRYNKA_TIP     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SKRYNKA_TIP     to BARS_DM;
grant SELECT                                                                 on SKRYNKA_TIP     to CC_DOC;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SKRYNKA_TIP     to DEP_SKRN;
grant SELECT                                                                 on SKRYNKA_TIP     to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SKRYNKA_TIP     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SKRYNKA_TIP     to WR_REFREAD;



PROMPT *** Create SYNONYM  to SKRYNKA_TIP ***

  CREATE OR REPLACE PUBLIC SYNONYM SKRYNKA_TIP FOR BARS.SKRYNKA_TIP;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_TIP.sql =========*** End *** =
PROMPT ===================================================================================== 
