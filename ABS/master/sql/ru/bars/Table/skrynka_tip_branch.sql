

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_TIP_BRANCH.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_TIP_BRANCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_TIP_BRANCH'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_TIP_BRANCH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_TIP_BRANCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_TIP_BRANCH 
   (	O_SK NUMBER, 
	BRANCH VARCHAR2(30), 
	NAME VARCHAR2(25), 
	ETALON_ID NUMBER(5,0), 
	CELL_COUNT NUMBER(5,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SKRYNKA_TIP_BRANCH ***
 exec bpa.alter_policies('SKRYNKA_TIP_BRANCH');


COMMENT ON TABLE BARS.SKRYNKA_TIP_BRANCH IS '������� ���� ���������� ������, ����������� � ������';
COMMENT ON COLUMN BARS.SKRYNKA_TIP_BRANCH.O_SK IS '';
COMMENT ON COLUMN BARS.SKRYNKA_TIP_BRANCH.BRANCH IS '';
COMMENT ON COLUMN BARS.SKRYNKA_TIP_BRANCH.NAME IS '';
COMMENT ON COLUMN BARS.SKRYNKA_TIP_BRANCH.ETALON_ID IS '';
COMMENT ON COLUMN BARS.SKRYNKA_TIP_BRANCH.CELL_COUNT IS '';




PROMPT *** Create  constraint FK_BR_SKRYN_TIP_REF_ETALON ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TIP_BRANCH ADD CONSTRAINT FK_BR_SKRYN_TIP_REF_ETALON FOREIGN KEY (ETALON_ID)
	  REFERENCES BARS.SKRYNKA_TIP_ETALON (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SKRYNKA_TIP_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TIP_BRANCH ADD CONSTRAINT PK_SKRYNKA_TIP_BRANCH PRIMARY KEY (O_SK, BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002834867 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TIP_BRANCH MODIFY (CELL_COUNT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002834866 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TIP_BRANCH MODIFY (ETALON_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002834865 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TIP_BRANCH MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002834864 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TIP_BRANCH MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002834863 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TIP_BRANCH MODIFY (O_SK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SKRYNKA_TIP_BRANCH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SKRYNKA_TIP_BRANCH ON BARS.SKRYNKA_TIP_BRANCH (O_SK, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_TIP_BRANCH ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SKRYNKA_TIP_BRANCH to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_TIP_BRANCH.sql =========*** En
PROMPT ===================================================================================== 
