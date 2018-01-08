

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_FE8_HISTORY.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_FE8_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_FE8_HISTORY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_FE8_HISTORY'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OTCN_FE8_HISTORY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_FE8_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_FE8_HISTORY 
   (	DATF DATE, 
	ACC NUMBER, 
	OSTF NUMBER, 
	ND NUMBER, 
	P090 VARCHAR2(40), 
	P110 NUMBER, 
	P111 DATE, 
	P112 DATE, 
	P130 NUMBER, 
	RNK NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_FE8_HISTORY ***
 exec bpa.alter_policies('OTCN_FE8_HISTORY');


COMMENT ON TABLE BARS.OTCN_FE8_HISTORY IS 'История формирования файла #E8';
COMMENT ON COLUMN BARS.OTCN_FE8_HISTORY.DATF IS '';
COMMENT ON COLUMN BARS.OTCN_FE8_HISTORY.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_FE8_HISTORY.OSTF IS '';
COMMENT ON COLUMN BARS.OTCN_FE8_HISTORY.ND IS '';
COMMENT ON COLUMN BARS.OTCN_FE8_HISTORY.P090 IS '';
COMMENT ON COLUMN BARS.OTCN_FE8_HISTORY.P110 IS '';
COMMENT ON COLUMN BARS.OTCN_FE8_HISTORY.P111 IS '';
COMMENT ON COLUMN BARS.OTCN_FE8_HISTORY.P112 IS '';
COMMENT ON COLUMN BARS.OTCN_FE8_HISTORY.P130 IS '';
COMMENT ON COLUMN BARS.OTCN_FE8_HISTORY.RNK IS '';
COMMENT ON COLUMN BARS.OTCN_FE8_HISTORY.KF IS '';




PROMPT *** Create  constraint CC_OTCN_FE8_HISTORY ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_FE8_HISTORY ADD CONSTRAINT CC_OTCN_FE8_HISTORY PRIMARY KEY (DATF, ACC, ND, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006637 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_FE8_HISTORY MODIFY (DATF NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006638 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_FE8_HISTORY MODIFY (ACC NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OTCNFE8HISTORY_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_FE8_HISTORY MODIFY (KF CONSTRAINT CC_OTCNFE8HISTORY_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index CC_OTCN_FE8_HISTORY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.CC_OTCN_FE8_HISTORY ON BARS.OTCN_FE8_HISTORY (DATF, ACC, ND, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_OTCN_FE8_HISTORY ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_OTCN_FE8_HISTORY ON BARS.OTCN_FE8_HISTORY (DATF, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_FE8_HISTORY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_FE8_HISTORY to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_FE8_HISTORY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OTCN_FE8_HISTORY to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_FE8_HISTORY to RPBN002;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTCN_FE8_HISTORY to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to OTCN_FE8_HISTORY ***

  CREATE OR REPLACE PUBLIC SYNONYM OTCN_FE8_HISTORY FOR BARS.OTCN_FE8_HISTORY;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_FE8_HISTORY.sql =========*** End 
PROMPT ===================================================================================== 
