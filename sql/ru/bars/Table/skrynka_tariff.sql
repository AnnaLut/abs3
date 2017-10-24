

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_TARIFF.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_TARIFF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_TARIFF'', ''FILIAL'' , ''Q'', ''Q'', ''Q'', ''Q'');
               bpa.alter_policy_info(''SKRYNKA_TARIFF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_TARIFF ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_TARIFF 
   (	TARIFF NUMBER, 
	NAME VARCHAR2(100), 
	TIP NUMBER, 
	O_SK NUMBER, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	BASEY NUMBER(*,0), 
	BASEM NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SKRYNKA_TARIFF ***
 exec bpa.alter_policies('SKRYNKA_TARIFF');


COMMENT ON TABLE BARS.SKRYNKA_TARIFF IS '���� �������';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF.KF IS '';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF.TARIFF IS '��� ������';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF.NAME IS '������������ ������';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF.TIP IS '��� ������';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF.O_SK IS '��� ����� (������)';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF.BRANCH IS '��� ���������';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF.BASEY IS '���� ���� 0 - ����������� 1 - 365 ���� 2 - 360';
COMMENT ON COLUMN BARS.SKRYNKA_TARIFF.BASEM IS '���� ������ 0 - ����������� (28-31 ����) 1 - 30 ����';




PROMPT *** Create  constraint FK_SKRYNKA_TARIFF_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF ADD CONSTRAINT FK_SKRYNKA_TARIFF_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKATARIFF_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF ADD CONSTRAINT FK_SKRYNKATARIFF_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKA_TARIFF_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF ADD CONSTRAINT FK_SKRYNKA_TARIFF_TIP FOREIGN KEY (TIP)
	  REFERENCES BARS.SKRYNKA_TARIFF_TIP (TIP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKATARIFF_SKRYNKATIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF ADD CONSTRAINT FK_SKRYNKATARIFF_SKRYNKATIP FOREIGN KEY (KF, O_SK)
	  REFERENCES BARS.SKRYNKA_TIP (KF, O_SK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_SKRYNKATARIFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF ADD CONSTRAINT UK_SKRYNKATARIFF UNIQUE (KF, TARIFF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKATARIFF_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF MODIFY (KF CONSTRAINT CC_SKRYNKATARIFF_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKATARIFF_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF MODIFY (BRANCH CONSTRAINT CC_SKRYNKATARIFF_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_SKRYNKA_TARIFF_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF MODIFY (TIP CONSTRAINT NN_SKRYNKA_TARIFF_TIP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKATARIFF_TARIFF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF MODIFY (TARIFF CONSTRAINT CC_SKRYNKATARIFF_TARIFF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SKRYNKATARIFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF ADD CONSTRAINT PK_SKRYNKATARIFF PRIMARY KEY (TARIFF, BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_SKRYNKATARIFF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_SKRYNKATARIFF ON BARS.SKRYNKA_TARIFF (KF, TARIFF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SKRYNKATARIFF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SKRYNKATARIFF ON BARS.SKRYNKA_TARIFF (TARIFF, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_TARIFF ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SKRYNKA_TARIFF  to BARS_ACCESS_DEFROLE;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SKRYNKA_TARIFF  to DEP_SKRN;
grant SELECT                                                                 on SKRYNKA_TARIFF  to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SKRYNKA_TARIFF  to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SKRYNKA_TARIFF  to WR_REFREAD;



PROMPT *** Create SYNONYM  to SKRYNKA_TARIFF ***

  CREATE OR REPLACE PUBLIC SYNONYM SKRYNKA_TARIFF FOR BARS.SKRYNKA_TARIFF;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_TARIFF.sql =========*** End **
PROMPT ===================================================================================== 
