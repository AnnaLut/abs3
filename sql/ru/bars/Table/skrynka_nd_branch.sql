

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ND_BRANCH.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_ND_BRANCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_ND_BRANCH'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_ND_BRANCH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_ND_BRANCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_ND_BRANCH 
   (	O_SK NUMBER, 
	BRANCH VARCHAR2(30 CHAR), 
	ND VARCHAR2(25 CHAR), 
	OPEN_DATE DATE, 
	CLOSE_DATE DATE DEFAULT NULL, 
	SOS NUMBER, 
	RENTER_NAME VARCHAR2(300 CHAR)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SKRYNKA_ND_BRANCH ***
 exec bpa.alter_policies('SKRYNKA_ND_BRANCH');


COMMENT ON TABLE BARS.SKRYNKA_ND_BRANCH IS '������� �������� ���������� ������, ����������� � ������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_BRANCH.O_SK IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ND_BRANCH.BRANCH IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ND_BRANCH.ND IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ND_BRANCH.OPEN_DATE IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ND_BRANCH.CLOSE_DATE IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ND_BRANCH.SOS IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ND_BRANCH.RENTER_NAME IS '';




PROMPT *** Create  constraint FK_SKR_ND_BRN_REF_TIP_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_BRANCH ADD CONSTRAINT FK_SKR_ND_BRN_REF_TIP_BRANCH FOREIGN KEY (O_SK, BRANCH)
	  REFERENCES BARS.SKRYNKA_TIP_BRANCH (O_SK, BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002834889 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_BRANCH MODIFY (OPEN_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002834888 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_BRANCH MODIFY (ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002834887 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_BRANCH MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002834886 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_BRANCH MODIFY (O_SK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_ND_BRANCH ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SKRYNKA_ND_BRANCH to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ND_BRANCH.sql =========*** End
PROMPT ===================================================================================== 
