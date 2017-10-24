

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_F71_HISTORY_SB.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_F71_HISTORY_SB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_F71_HISTORY_SB'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_F71_HISTORY_SB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_F71_HISTORY_SB ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_F71_HISTORY_SB 
   (	DATF DATE, 
	ACC NUMBER, 
	OSTF NUMBER, 
	ND NUMBER, 
	P080 VARCHAR2(20), 
	P081 NUMBER, 
	P090 VARCHAR2(20), 
	P110 NUMBER, 
	P111 DATE, 
	P112 DATE, 
	P130 NUMBER, 
	P040 NUMBER, 
	RNK NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_F71_HISTORY_SB ***
 exec bpa.alter_policies('OTCN_F71_HISTORY_SB');


COMMENT ON TABLE BARS.OTCN_F71_HISTORY_SB IS 'История формирования файла @71';
COMMENT ON COLUMN BARS.OTCN_F71_HISTORY_SB.DATF IS '';
COMMENT ON COLUMN BARS.OTCN_F71_HISTORY_SB.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_F71_HISTORY_SB.OSTF IS '';
COMMENT ON COLUMN BARS.OTCN_F71_HISTORY_SB.ND IS '';
COMMENT ON COLUMN BARS.OTCN_F71_HISTORY_SB.P080 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_HISTORY_SB.P081 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_HISTORY_SB.P090 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_HISTORY_SB.P110 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_HISTORY_SB.P111 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_HISTORY_SB.P112 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_HISTORY_SB.P130 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_HISTORY_SB.P040 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_HISTORY_SB.RNK IS '';
COMMENT ON COLUMN BARS.OTCN_F71_HISTORY_SB.KF IS '';




PROMPT *** Create  constraint FK_OTCNF71HISTORYSB_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F71_HISTORY_SB ADD CONSTRAINT FK_OTCNF71HISTORYSB_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008629 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F71_HISTORY_SB MODIFY (DATF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008630 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F71_HISTORY_SB MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OTCNF71HISTORYSB_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F71_HISTORY_SB MODIFY (KF CONSTRAINT CC_OTCNF71HISTORYSB_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_OTCN_F71_HISTORY_SB ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_OTCN_F71_HISTORY_SB ON BARS.OTCN_F71_HISTORY_SB (DATF, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_F71_HISTORY_SB ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F71_HISTORY_SB to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F71_HISTORY_SB to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OTCN_F71_HISTORY_SB to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F71_HISTORY_SB to RPBN002;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTCN_F71_HISTORY_SB to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_F71_HISTORY_SB.sql =========*** E
PROMPT ===================================================================================== 
