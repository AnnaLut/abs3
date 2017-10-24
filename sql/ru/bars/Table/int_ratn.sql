

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INT_RATN.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INT_RATN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INT_RATN'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''INT_RATN'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INT_RATN ***
begin 
  execute immediate '
  CREATE TABLE BARS.INT_RATN 
   (	ACC NUMBER(38,0), 
	ID NUMBER, 
	BDAT DATE, 
	IR NUMBER, 
	BR NUMBER(38,0), 
	OP NUMBER(4,0), 
	IDU NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INT_RATN ***
 exec bpa.alter_policies('INT_RATN');


COMMENT ON TABLE BARS.INT_RATN IS '������� % ������';
COMMENT ON COLUMN BARS.INT_RATN.ACC IS 'acc �����';
COMMENT ON COLUMN BARS.INT_RATN.ID IS '������������� ���� ���������� %';
COMMENT ON COLUMN BARS.INT_RATN.BDAT IS '���� ���������';
COMMENT ON COLUMN BARS.INT_RATN.IR IS '�������������� % ������';
COMMENT ON COLUMN BARS.INT_RATN.BR IS '������� % ������';
COMMENT ON COLUMN BARS.INT_RATN.OP IS '��������, ����� IR � BR';
COMMENT ON COLUMN BARS.INT_RATN.IDU IS 'a���� % ������';
COMMENT ON COLUMN BARS.INT_RATN.KF IS '';




PROMPT *** Create  constraint FK_INTRATN_INTACCN2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN ADD CONSTRAINT FK_INTRATN_INTACCN2 FOREIGN KEY (KF, ACC, ID)
	  REFERENCES BARS.INT_ACCN (KF, ACC, ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INTRATN_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN ADD CONSTRAINT FK_INTRATN_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INTRATN_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN ADD CONSTRAINT FK_INTRATN_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INTRATN_BRATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN ADD CONSTRAINT FK_INTRATN_BRATES FOREIGN KEY (BR)
	  REFERENCES BARS.BRATES (BR_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INTRATN_INTIDN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN ADD CONSTRAINT FK_INTRATN_INTIDN FOREIGN KEY (ID)
	  REFERENCES BARS.INT_IDN (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INTRATN_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN ADD CONSTRAINT FK_INTRATN_STAFF FOREIGN KEY (IDU)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_INTRATN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN ADD CONSTRAINT UK_INTRATN UNIQUE (KF, ACC, ID, BDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_INTRATN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN ADD CONSTRAINT PK_INTRATN PRIMARY KEY (ACC, ID, BDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTRATN_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN MODIFY (KF CONSTRAINT CC_INTRATN_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTRATN_IDU_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN MODIFY (IDU CONSTRAINT CC_INTRATN_IDU_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTRATN_BDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN MODIFY (BDAT CONSTRAINT CC_INTRATN_BDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTRATN_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN MODIFY (ID CONSTRAINT CC_INTRATN_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTRATN_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN MODIFY (ACC CONSTRAINT CC_INTRATN_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_INTRATN ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_INTRATN ON BARS.INT_RATN (BDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INTRATN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INTRATN ON BARS.INT_RATN (ACC, ID, BDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_INTRATN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_INTRATN ON BARS.INT_RATN (KF, ACC, ID, BDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INT_RATN ***
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_RATN        to ABS_ADMIN;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on INT_RATN        to BARS009;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on INT_RATN        to BARS010;
grant SELECT                                                                 on INT_RATN        to BARSUPL;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on INT_RATN        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INT_RATN        to BARS_SUP;
grant SELECT                                                                 on INT_RATN        to CC_DOC;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on INT_RATN        to CUST001;
grant SELECT,UPDATE                                                          on INT_RATN        to DPT;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on INT_RATN        to FOREX;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on INT_RATN        to RCC_DEAL;
grant SELECT                                                                 on INT_RATN        to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_RATN        to TECH005;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_RATN        to TECH006;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_RATN        to WR_ACRINT;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on INT_RATN        to WR_ALL_RIGHTS;
grant UPDATE                                                                 on INT_RATN        to WR_CREDIT;
grant INSERT,UPDATE                                                          on INT_RATN        to WR_DEPOSIT_U;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_RATN        to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INT_RATN.sql =========*** End *** ====
PROMPT ===================================================================================== 
