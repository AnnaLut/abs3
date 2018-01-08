

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PKK_INF_ARC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PKK_INF_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PKK_INF_ARC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PKK_INF_ARC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''PKK_INF_ARC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PKK_INF_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.PKK_INF_ARC 
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




PROMPT *** ALTER_POLICIES to PKK_INF_ARC ***
 exec bpa.alter_policies('PKK_INF_ARC');


COMMENT ON TABLE BARS.PKK_INF_ARC IS '';
COMMENT ON COLUMN BARS.PKK_INF_ARC.REC IS '';
COMMENT ON COLUMN BARS.PKK_INF_ARC.NLS IS '';
COMMENT ON COLUMN BARS.PKK_INF_ARC.F_N IS '';
COMMENT ON COLUMN BARS.PKK_INF_ARC.F_D IS '';
COMMENT ON COLUMN BARS.PKK_INF_ARC.CARD_ACCT IS '';
COMMENT ON COLUMN BARS.PKK_INF_ARC.TRAN_TYPE IS '';
COMMENT ON COLUMN BARS.PKK_INF_ARC.S IS '';
COMMENT ON COLUMN BARS.PKK_INF_ARC.KF IS '';




PROMPT *** Create  constraint PK_PKKINFARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_INF_ARC ADD CONSTRAINT PK_PKKINFARC PRIMARY KEY (REC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PKKINFARC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_INF_ARC ADD CONSTRAINT FK_PKKINFARC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PKKINFARC_REC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_INF_ARC MODIFY (REC CONSTRAINT CC_PKKINFARC_REC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PKKINFARC_NLS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_INF_ARC MODIFY (NLS CONSTRAINT CC_PKKINFARC_NLS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PKKINFARC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_INF_ARC MODIFY (KF CONSTRAINT CC_PKKINFARC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PKKINFARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PKKINFARC ON BARS.PKK_INF_ARC (REC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_PKKINFARC_NLS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_PKKINFARC_NLS ON BARS.PKK_INF_ARC (NLS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PKK_INF_ARC ***
grant INSERT,SELECT                                                          on PKK_INF_ARC     to BARS_ACCESS_DEFROLE;
grant INSERT,SELECT                                                          on PKK_INF_ARC     to OBPC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PKK_INF_ARC.sql =========*** End *** =
PROMPT ===================================================================================== 
