

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_F71_HISTORY.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_F71_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_F71_HISTORY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_F71_HISTORY'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OTCN_F71_HISTORY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_F71_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_F71_HISTORY 
   (	DATF DATE, 
	ACC NUMBER, 
	OSTF NUMBER, 
	ND NUMBER, 
	P080 VARCHAR2(20), 
	P081 NUMBER, 
	P090 VARCHAR2(40), 
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




PROMPT *** ALTER_POLICIES to OTCN_F71_HISTORY ***
 exec bpa.alter_policies('OTCN_F71_HISTORY');


COMMENT ON TABLE BARS.OTCN_F71_HISTORY IS 'История формирования файла #D8';
COMMENT ON COLUMN BARS.OTCN_F71_HISTORY.DATF IS '';
COMMENT ON COLUMN BARS.OTCN_F71_HISTORY.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_F71_HISTORY.OSTF IS '';
COMMENT ON COLUMN BARS.OTCN_F71_HISTORY.ND IS '';
COMMENT ON COLUMN BARS.OTCN_F71_HISTORY.P080 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_HISTORY.P081 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_HISTORY.P090 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_HISTORY.P110 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_HISTORY.P111 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_HISTORY.P112 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_HISTORY.P130 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_HISTORY.P040 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_HISTORY.RNK IS '';
COMMENT ON COLUMN BARS.OTCN_F71_HISTORY.KF IS '';




PROMPT *** Create  constraint SYS_C009344 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F71_HISTORY MODIFY (DATF NOT NULL DISABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009345 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F71_HISTORY MODIFY (ACC NOT NULL DISABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OTCNF71HISTORY_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F71_HISTORY MODIFY (KF CONSTRAINT CC_OTCNF71HISTORY_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_OTCN_F71_HISTORY ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_OTCN_F71_HISTORY ON BARS.OTCN_F71_HISTORY (KF, DATF, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_F71_HISTORY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F71_HISTORY to ABS_ADMIN;
grant SELECT                                                                 on OTCN_F71_HISTORY to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTCN_F71_HISTORY to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F71_HISTORY to RPBN002;
grant SELECT                                                                 on OTCN_F71_HISTORY to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTCN_F71_HISTORY to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on OTCN_F71_HISTORY to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_F71_HISTORY.sql =========*** End 
PROMPT ===================================================================================== 
