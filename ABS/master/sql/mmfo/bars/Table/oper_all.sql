

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OPER_ALL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OPER_ALL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OPER_ALL'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OPER_ALL'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OPER_ALL'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OPER_ALL ***
begin 
  execute immediate '
  CREATE TABLE BARS.OPER_ALL 
   (	REF NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD  ENABLE ROW MOVEMENT ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OPER_ALL ***
 exec bpa.alter_policies('OPER_ALL');


COMMENT ON TABLE BARS.OPER_ALL IS 'Все документы системы (в т.ч. архив)';
COMMENT ON COLUMN BARS.OPER_ALL.REF IS 'Референс документа';
COMMENT ON COLUMN BARS.OPER_ALL.KF IS '';




PROMPT *** Create  constraint FK_OPERALL_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER_ALL ADD CONSTRAINT FK_OPERALL_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERALL_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER_ALL MODIFY (REF CONSTRAINT CC_OPERALL_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPERALL_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER_ALL MODIFY (KF CONSTRAINT CC_OPERALL_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OPERALL ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER_ALL ADD CONSTRAINT PK_OPERALL PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_OPERALL ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER_ALL ADD CONSTRAINT UK_OPERALL UNIQUE (KF, REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_OPERALL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_OPERALL ON BARS.OPER_ALL (KF, REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OPERALL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OPERALL ON BARS.OPER_ALL (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OPER_ALL ***
grant SELECT                                                                 on OPER_ALL        to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OPER_ALL        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OPER_ALL.sql =========*** End *** ====
PROMPT ===================================================================================== 
