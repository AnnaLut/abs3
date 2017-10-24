

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACR_DOCS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACR_DOCS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACR_DOCS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ACR_DOCS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ACR_DOCS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACR_DOCS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACR_DOCS 
   (	ACC NUMBER(38,0), 
	ID NUMBER(1,0), 
	INT_DATE DATE, 
	INT_REF NUMBER(38,0), 
	INT_REST NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACR_DOCS ***
 exec bpa.alter_policies('ACR_DOCS');


COMMENT ON TABLE BARS.ACR_DOCS IS 'Документы по начислению процентов';
COMMENT ON COLUMN BARS.ACR_DOCS.ACC IS 'Ид. счета';
COMMENT ON COLUMN BARS.ACR_DOCS.ID IS 'Ид. карточки';
COMMENT ON COLUMN BARS.ACR_DOCS.INT_DATE IS 'Дата начисления';
COMMENT ON COLUMN BARS.ACR_DOCS.INT_REF IS 'Реф. документа';
COMMENT ON COLUMN BARS.ACR_DOCS.INT_REST IS 'Остаток';
COMMENT ON COLUMN BARS.ACR_DOCS.KF IS '';




PROMPT *** Create  constraint FK_ACRDOCS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACR_DOCS ADD CONSTRAINT FK_ACRDOCS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACRDOCS_INTACCN2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACR_DOCS ADD CONSTRAINT FK_ACRDOCS_INTACCN2 FOREIGN KEY (KF, ACC, ID)
	  REFERENCES BARS.INT_ACCN (KF, ACC, ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACRDOCS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACR_DOCS ADD CONSTRAINT PK_ACRDOCS PRIMARY KEY (INT_REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACRDOCS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACR_DOCS MODIFY (KF CONSTRAINT CC_ACRDOCS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACRDOCS_INTREF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACR_DOCS MODIFY (INT_REF CONSTRAINT CC_ACRDOCS_INTREF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACRDOCS_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACR_DOCS MODIFY (ID CONSTRAINT CC_ACRDOCS_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACRDOCS_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACR_DOCS MODIFY (ACC CONSTRAINT CC_ACRDOCS_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACRDOCS_INTACCN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACR_DOCS ADD CONSTRAINT FK_ACRDOCS_INTACCN FOREIGN KEY (ACC, ID)
	  REFERENCES BARS.INT_ACCN (ACC, ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_ACRDOCS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.I1_ACRDOCS ON BARS.ACR_DOCS (ACC, ID, INT_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACRDOCS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACRDOCS ON BARS.ACR_DOCS (INT_REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACR_DOCS ***
grant SELECT                                                                 on ACR_DOCS        to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACR_DOCS        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACR_DOCS.sql =========*** End *** ====
PROMPT ===================================================================================== 
