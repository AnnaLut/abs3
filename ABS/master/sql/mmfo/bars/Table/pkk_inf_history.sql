

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PKK_INF_HISTORY.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PKK_INF_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PKK_INF_HISTORY'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PKK_INF_HISTORY'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''PKK_INF_HISTORY'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PKK_INF_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.PKK_INF_HISTORY 
   (	REC NUMBER(38,0), 
	NLS VARCHAR2(14), 
	F_N VARCHAR2(12), 
	F_D DATE, 
	CARD_ACCT VARCHAR2(10), 
	TRAN_TYPE VARCHAR2(2), 
	S NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PKK_INF_HISTORY ***
 exec bpa.alter_policies('PKK_INF_HISTORY');


COMMENT ON TABLE BARS.PKK_INF_HISTORY IS '';
COMMENT ON COLUMN BARS.PKK_INF_HISTORY.REC IS '';
COMMENT ON COLUMN BARS.PKK_INF_HISTORY.NLS IS '';
COMMENT ON COLUMN BARS.PKK_INF_HISTORY.F_N IS '';
COMMENT ON COLUMN BARS.PKK_INF_HISTORY.F_D IS '';
COMMENT ON COLUMN BARS.PKK_INF_HISTORY.CARD_ACCT IS '';
COMMENT ON COLUMN BARS.PKK_INF_HISTORY.TRAN_TYPE IS '';
COMMENT ON COLUMN BARS.PKK_INF_HISTORY.S IS '';
COMMENT ON COLUMN BARS.PKK_INF_HISTORY.KF IS '';




PROMPT *** Create  constraint PK_PKKINFHISTORY ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_INF_HISTORY ADD CONSTRAINT PK_PKKINFHISTORY PRIMARY KEY (REC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PKKINFHISTORY_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_INF_HISTORY ADD CONSTRAINT FK_PKKINFHISTORY_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PKKINFHISTORY_REC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_INF_HISTORY MODIFY (REC CONSTRAINT CC_PKKINFHISTORY_REC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PKKINFHISTORY_NLS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_INF_HISTORY MODIFY (NLS CONSTRAINT CC_PKKINFHISTORY_NLS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PKKINFHISTORY_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_INF_HISTORY MODIFY (KF CONSTRAINT CC_PKKINFHISTORY_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PKKINFHISTORY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PKKINFHISTORY ON BARS.PKK_INF_HISTORY (REC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_PKKINFHISTORY_NLS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_PKKINFHISTORY_NLS ON BARS.PKK_INF_HISTORY (NLS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PKK_INF_HISTORY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PKK_INF_HISTORY to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PKK_INF_HISTORY to OBPC;
grant DELETE                                                                 on PKK_INF_HISTORY to PYOD001;
grant SELECT                                                                 on PKK_INF_HISTORY to TECH004;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PKK_INF_HISTORY.sql =========*** End *
PROMPT ===================================================================================== 
