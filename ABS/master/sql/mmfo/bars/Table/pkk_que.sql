

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PKK_QUE.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PKK_QUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PKK_QUE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PKK_QUE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PKK_QUE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PKK_QUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.PKK_QUE 
   (	REF NUMBER(38,0), 
	ACC NUMBER(38,0), 
	SOS NUMBER(1,0) DEFAULT 0, 
	F_N VARCHAR2(12), 
	F_D DATE, 
	CARD_ACCT VARCHAR2(10), 
	TRAN_TYPE VARCHAR2(2), 
	S NUMBER(38,0), 
	DK NUMBER(1,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PKK_QUE ***
 exec bpa.alter_policies('PKK_QUE');


COMMENT ON TABLE BARS.PKK_QUE IS '';
COMMENT ON COLUMN BARS.PKK_QUE.REF IS '';
COMMENT ON COLUMN BARS.PKK_QUE.ACC IS '';
COMMENT ON COLUMN BARS.PKK_QUE.SOS IS '';
COMMENT ON COLUMN BARS.PKK_QUE.F_N IS '';
COMMENT ON COLUMN BARS.PKK_QUE.F_D IS '';
COMMENT ON COLUMN BARS.PKK_QUE.CARD_ACCT IS '';
COMMENT ON COLUMN BARS.PKK_QUE.TRAN_TYPE IS '';
COMMENT ON COLUMN BARS.PKK_QUE.S IS '';
COMMENT ON COLUMN BARS.PKK_QUE.DK IS '';
COMMENT ON COLUMN BARS.PKK_QUE.KF IS '';




PROMPT *** Create  constraint PK_PKKQUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_QUE ADD CONSTRAINT PK_PKKQUE PRIMARY KEY (KF, REF, DK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PKKQUE_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_QUE MODIFY (REF CONSTRAINT CC_PKKQUE_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PKKQUE_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_QUE MODIFY (ACC CONSTRAINT CC_PKKQUE_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PKKQUE_SOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_QUE MODIFY (SOS CONSTRAINT CC_PKKQUE_SOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PKKQUE_DK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_QUE MODIFY (DK CONSTRAINT CC_PKKQUE_DK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PKKQUE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_QUE MODIFY (KF CONSTRAINT CC_PKKQUE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_PKKQUE_ACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_PKKQUE_ACC ON BARS.PKK_QUE (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PKKQUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PKKQUE ON BARS.PKK_QUE (KF, REF, DK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PKK_QUE ***
grant SELECT                                                                 on PKK_QUE         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PKK_QUE         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PKK_QUE         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on PKK_QUE         to OBPC;
grant DELETE                                                                 on PKK_QUE         to PYOD001;
grant SELECT                                                                 on PKK_QUE         to TECH004;
grant SELECT                                                                 on PKK_QUE         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PKK_QUE         to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to PKK_QUE ***

  CREATE OR REPLACE PUBLIC SYNONYM PKK_QUE FOR BARS.PKK_QUE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PKK_QUE.sql =========*** End *** =====
PROMPT ===================================================================================== 
