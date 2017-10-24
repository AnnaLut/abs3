

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_OPERW.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_OPERW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_OPERW'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SW_OPERW'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_OPERW ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_OPERW 
   (	SWREF NUMBER(38,0), 
	TAG CHAR(2), 
	SEQ CHAR(1) DEFAULT ''A'', 
	N NUMBER(38,0) DEFAULT 0, 
	OPT CHAR(1), 
	VALUE VARCHAR2(1024), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_OPERW ***
 exec bpa.alter_policies('SW_OPERW');


COMMENT ON TABLE BARS.SW_OPERW IS 'SWT. ���� ���������';
COMMENT ON COLUMN BARS.SW_OPERW.SWREF IS '�������� ���������';
COMMENT ON COLUMN BARS.SW_OPERW.TAG IS '��� ���� ���������';
COMMENT ON COLUMN BARS.SW_OPERW.SEQ IS '��� ��������� ���������';
COMMENT ON COLUMN BARS.SW_OPERW.N IS '���������� ����� ���� � ���������';
COMMENT ON COLUMN BARS.SW_OPERW.OPT IS '��� ����� ����';
COMMENT ON COLUMN BARS.SW_OPERW.VALUE IS '�������� ����';
COMMENT ON COLUMN BARS.SW_OPERW.KF IS '';




PROMPT *** Create  constraint FK_SWOPERW_SWJOURNAL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPERW ADD CONSTRAINT FK_SWOPERW_SWJOURNAL2 FOREIGN KEY (KF, SWREF)
	  REFERENCES BARS.SW_JOURNAL (KF, SWREF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWOPERW_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPERW ADD CONSTRAINT FK_SWOPERW_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWOPERW_SWOPT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPERW ADD CONSTRAINT FK_SWOPERW_SWOPT FOREIGN KEY (OPT)
	  REFERENCES BARS.SW_OPT (OPT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWOPERW_SWSEQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPERW ADD CONSTRAINT FK_SWOPERW_SWSEQ FOREIGN KEY (SEQ)
	  REFERENCES BARS.SW_SEQ (SEQ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWOPERW_SWTAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPERW ADD CONSTRAINT FK_SWOPERW_SWTAG FOREIGN KEY (TAG)
	  REFERENCES BARS.SW_TAG (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWOPERW_N ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPERW ADD CONSTRAINT CC_SWOPERW_N CHECK (n>=0) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SWOPERW ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPERW ADD CONSTRAINT PK_SWOPERW PRIMARY KEY (SWREF, N)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWOPERW_N_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPERW MODIFY (N CONSTRAINT CC_SWOPERW_N_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWOPERW_SEQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPERW MODIFY (SEQ CONSTRAINT CC_SWOPERW_SEQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWOPERW_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPERW MODIFY (TAG CONSTRAINT CC_SWOPERW_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWOPERW_SWREF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPERW MODIFY (SWREF CONSTRAINT CC_SWOPERW_SWREF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWOPERW_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPERW MODIFY (KF CONSTRAINT CC_SWOPERW_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWOPERW ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWOPERW ON BARS.SW_OPERW (SWREF, N) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_OPERW ***
grant SELECT                                                                 on SW_OPERW        to BARS013;
grant SELECT                                                                 on SW_OPERW        to SWTOSS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_OPERW        to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SW_OPERW ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_OPERW FOR BARS.SW_OPERW;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_OPERW.sql =========*** End *** ====
PROMPT ===================================================================================== 
