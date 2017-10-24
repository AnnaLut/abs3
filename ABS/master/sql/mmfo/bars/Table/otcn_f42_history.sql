

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_F42_HISTORY.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_F42_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_F42_HISTORY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_F42_HISTORY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_F42_HISTORY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_F42_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_F42_HISTORY 
   (	FDAT DATE, 
	RNK NUMBER, 
	SUM NUMBER, 
	USERID NUMBER, 
	ODAT DATE DEFAULT SYSDATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_F42_HISTORY ***
 exec bpa.alter_policies('OTCN_F42_HISTORY');


COMMENT ON TABLE BARS.OTCN_F42_HISTORY IS '';
COMMENT ON COLUMN BARS.OTCN_F42_HISTORY.KF IS '';
COMMENT ON COLUMN BARS.OTCN_F42_HISTORY.FDAT IS '';
COMMENT ON COLUMN BARS.OTCN_F42_HISTORY.RNK IS '';
COMMENT ON COLUMN BARS.OTCN_F42_HISTORY.SUM IS '';
COMMENT ON COLUMN BARS.OTCN_F42_HISTORY.USERID IS '';
COMMENT ON COLUMN BARS.OTCN_F42_HISTORY.ODAT IS '';




PROMPT *** Create  constraint CC_OTCNF42HISTORY_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F42_HISTORY MODIFY (KF CONSTRAINT CC_OTCNF42HISTORY_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OTCNF42HISTORY_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F42_HISTORY ADD CONSTRAINT FK_OTCNF42HISTORY_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007308 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F42_HISTORY MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007309 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F42_HISTORY MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint OTCN_F42_HISTORY_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F42_HISTORY ADD CONSTRAINT OTCN_F42_HISTORY_PK PRIMARY KEY (FDAT, RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index OTCN_F42_HISTORY_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.OTCN_F42_HISTORY_PK ON BARS.OTCN_F42_HISTORY (FDAT, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_F42_HISTORY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F42_HISTORY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OTCN_F42_HISTORY to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F42_HISTORY to RPBN002;



PROMPT *** Create SYNONYM  to OTCN_F42_HISTORY ***

  CREATE OR REPLACE PUBLIC SYNONYM OTCN_F42_HISTORY FOR BARS.OTCN_F42_HISTORY;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_F42_HISTORY.sql =========*** End 
PROMPT ===================================================================================== 
