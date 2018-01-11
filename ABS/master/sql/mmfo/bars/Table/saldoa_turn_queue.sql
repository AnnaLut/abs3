

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SALDOA_TURN_QUEUE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SALDOA_TURN_QUEUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SALDOA_TURN_QUEUE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SALDOA_TURN_QUEUE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SALDOA_TURN_QUEUE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SALDOA_TURN_QUEUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SALDOA_TURN_QUEUE 
   (	REC_ID NUMBER(38,0), 
	FDAT DATE, 
	ACC NUMBER(38,0), 
	AMOUNT NUMBER(20,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SALDOA_TURN_QUEUE ***
 exec bpa.alter_policies('SALDOA_TURN_QUEUE');


COMMENT ON TABLE BARS.SALDOA_TURN_QUEUE IS '';
COMMENT ON COLUMN BARS.SALDOA_TURN_QUEUE.REC_ID IS '';
COMMENT ON COLUMN BARS.SALDOA_TURN_QUEUE.FDAT IS '';
COMMENT ON COLUMN BARS.SALDOA_TURN_QUEUE.ACC IS '';
COMMENT ON COLUMN BARS.SALDOA_TURN_QUEUE.AMOUNT IS '';
COMMENT ON COLUMN BARS.SALDOA_TURN_QUEUE.KF IS '';




PROMPT *** Create  constraint CC_SALTURNQUE_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOA_TURN_QUEUE MODIFY (ACC CONSTRAINT CC_SALTURNQUE_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALTURNQUE_AMOUNT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOA_TURN_QUEUE MODIFY (AMOUNT CONSTRAINT CC_SALTURNQUE_AMOUNT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALTURNQUE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOA_TURN_QUEUE MODIFY (KF CONSTRAINT CC_SALTURNQUE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SALTURNQUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOA_TURN_QUEUE ADD CONSTRAINT PK_SALTURNQUE PRIMARY KEY (REC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALTURNQUE_RECID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOA_TURN_QUEUE MODIFY (REC_ID CONSTRAINT CC_SALTURNQUE_RECID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALTURNQUE_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOA_TURN_QUEUE MODIFY (FDAT CONSTRAINT CC_SALTURNQUE_FDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SALTURNQUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SALTURNQUE ON BARS.SALDOA_TURN_QUEUE (REC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SALDOA_TURN_QUEUE ***
grant SELECT                                                                 on SALDOA_TURN_QUEUE to BARSREADER_ROLE;
grant SELECT                                                                 on SALDOA_TURN_QUEUE to BARS_DM;
grant SELECT                                                                 on SALDOA_TURN_QUEUE to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SALDOA_TURN_QUEUE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SALDOA_TURN_QUEUE.sql =========*** End
PROMPT ===================================================================================== 
