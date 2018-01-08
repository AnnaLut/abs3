

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''SKRYNKA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA 
   (	O_SK NUMBER, 
	N_SK NUMBER, 
	SNUM VARCHAR2(64 CHAR), 
	KEYUSED NUMBER, 
	ISP_MO NUMBER, 
	KEYNUMBER VARCHAR2(30), 
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




PROMPT *** ALTER_POLICIES to SKRYNKA ***
 exec bpa.alter_policies('SKRYNKA');


COMMENT ON TABLE BARS.SKRYNKA IS 'портфель депозитных сейфов';
COMMENT ON COLUMN BARS.SKRYNKA.O_SK IS 'вид сейфа';
COMMENT ON COLUMN BARS.SKRYNKA.N_SK IS 'номер сейфа (системный референс)';
COMMENT ON COLUMN BARS.SKRYNKA.SNUM IS 'номер сейфа (символьный для документов)';
COMMENT ON COLUMN BARS.SKRYNKA.KEYUSED IS 'флаг - признак ключ выдан = 1, не выдан = 0';
COMMENT ON COLUMN BARS.SKRYNKA.ISP_MO IS 'материально ответственное за сейф лицо';
COMMENT ON COLUMN BARS.SKRYNKA.KEYNUMBER IS 'номер ключа';
COMMENT ON COLUMN BARS.SKRYNKA.BRANCH IS 'код ТОБО';
COMMENT ON COLUMN BARS.SKRYNKA.KF IS '';




PROMPT *** Create  constraint PK_SKRYNKA ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA ADD CONSTRAINT PK_SKRYNKA PRIMARY KEY (N_SK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XUK_SKRYNKA_BRANCH_SNUM ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA ADD CONSTRAINT XUK_SKRYNKA_BRANCH_SNUM UNIQUE (BRANCH, SNUM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKA_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA MODIFY (KF CONSTRAINT CC_SKRYNKA_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKA_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA MODIFY (BRANCH CONSTRAINT CC_SKRYNKA_BRANCH_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKA_SNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA MODIFY (SNUM CONSTRAINT CC_SKRYNKA_SNUM_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKA_NSK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA MODIFY (N_SK CONSTRAINT CC_SKRYNKA_NSK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKA_OSK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA MODIFY (O_SK CONSTRAINT CC_SKRYNKA_OSK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKA_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA ADD CONSTRAINT FK_SKRYNKA_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKA_ISP_MO ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA ADD CONSTRAINT FK_SKRYNKA_ISP_MO FOREIGN KEY (ISP_MO)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKA_SKRYNKATIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA ADD CONSTRAINT FK_SKRYNKA_SKRYNKATIP FOREIGN KEY (KF, O_SK)
	  REFERENCES BARS.SKRYNKA_TIP (KF, O_SK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKA_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA ADD CONSTRAINT FK_SKRYNKA_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKA_BRANCH_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA ADD CONSTRAINT CC_SKRYNKA_BRANCH_CC CHECK (branch like ''/''||kf||''/%'') ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_SKRYNKA ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA ADD CONSTRAINT UK_SKRYNKA UNIQUE (KF, N_SK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKA_SKRYNKAALL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA ADD CONSTRAINT FK_SKRYNKA_SKRYNKAALL FOREIGN KEY (KF, N_SK)
	  REFERENCES BARS.SKRYNKA_ALL (KF, N_SK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XUK_SKRYNKA_BRANCH_SNUM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XUK_SKRYNKA_BRANCH_SNUM ON BARS.SKRYNKA (BRANCH, SNUM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_SKRYNKA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_SKRYNKA ON BARS.SKRYNKA (KF, N_SK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SKRYNKA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SKRYNKA ON BARS.SKRYNKA (N_SK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SKRYNKA         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SKRYNKA         to BARS_DM;
grant SELECT                                                                 on SKRYNKA         to CC_DOC;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SKRYNKA         to DEP_SKRN;
grant SELECT                                                                 on SKRYNKA         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SKRYNKA         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SKRYNKA         to WR_REFREAD;



PROMPT *** Create SYNONYM  to SKRYNKA ***

  CREATE OR REPLACE PUBLIC SYNONYM SKRYNKA FOR BARS.SKRYNKA;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA.sql =========*** End *** =====
PROMPT ===================================================================================== 
