

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RNBU_HISTORY.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RNBU_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RNBU_HISTORY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''RNBU_HISTORY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''RNBU_HISTORY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RNBU_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.RNBU_HISTORY 
   (	RECID NUMBER, 
	ODATE DATE, 
	NLS VARCHAR2(15), 
	KV NUMBER, 
	CODCAGENT NUMBER, 
	INTS NUMBER(9,4), 
	S180 VARCHAR2(1), 
	K081 VARCHAR2(1), 
	K092 VARCHAR2(1), 
	DOS NUMBER(24,0), 
	KOS NUMBER(24,0), 
	MDATE DATE, 
	K112 VARCHAR2(1), 
	OST NUMBER(24,0), 
	MB VARCHAR2(1), 
	D020 VARCHAR2(2), 
	ISP NUMBER, 
	ACC NUMBER, 
	TOBO VARCHAR2(30), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RNBU_HISTORY ***
 exec bpa.alter_policies('RNBU_HISTORY');


COMMENT ON TABLE BARS.RNBU_HISTORY IS 'Архив показателей для файла #04';
COMMENT ON COLUMN BARS.RNBU_HISTORY.RECID IS '';
COMMENT ON COLUMN BARS.RNBU_HISTORY.ODATE IS '';
COMMENT ON COLUMN BARS.RNBU_HISTORY.NLS IS '';
COMMENT ON COLUMN BARS.RNBU_HISTORY.KV IS '';
COMMENT ON COLUMN BARS.RNBU_HISTORY.CODCAGENT IS '';
COMMENT ON COLUMN BARS.RNBU_HISTORY.INTS IS '';
COMMENT ON COLUMN BARS.RNBU_HISTORY.S180 IS '';
COMMENT ON COLUMN BARS.RNBU_HISTORY.K081 IS '';
COMMENT ON COLUMN BARS.RNBU_HISTORY.K092 IS '';
COMMENT ON COLUMN BARS.RNBU_HISTORY.DOS IS '';
COMMENT ON COLUMN BARS.RNBU_HISTORY.KOS IS '';
COMMENT ON COLUMN BARS.RNBU_HISTORY.MDATE IS '';
COMMENT ON COLUMN BARS.RNBU_HISTORY.K112 IS '';
COMMENT ON COLUMN BARS.RNBU_HISTORY.OST IS '';
COMMENT ON COLUMN BARS.RNBU_HISTORY.MB IS '';
COMMENT ON COLUMN BARS.RNBU_HISTORY.D020 IS '';
COMMENT ON COLUMN BARS.RNBU_HISTORY.ISP IS '';
COMMENT ON COLUMN BARS.RNBU_HISTORY.ACC IS '';
COMMENT ON COLUMN BARS.RNBU_HISTORY.TOBO IS '';
COMMENT ON COLUMN BARS.RNBU_HISTORY.KF IS '';




PROMPT *** Create  constraint FK_RNBUHISTORY_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNBU_HISTORY ADD CONSTRAINT FK_RNBUHISTORY_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RNBUHISTORY_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNBU_HISTORY MODIFY (KF CONSTRAINT CC_RNBUHISTORY_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_RNBU_HISTORY ***
begin   
 execute immediate '
  CREATE INDEX BARS.PK_RNBU_HISTORY ON BARS.RNBU_HISTORY (ODATE, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index I1_RNBU_HISTORY ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_RNBU_HISTORY ON BARS.RNBU_HISTORY (KF, ODATE, ACC)
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  RNBU_HISTORY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_HISTORY    to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RNBU_HISTORY    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RNBU_HISTORY    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_HISTORY    to RNBU_HIST;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_HISTORY    to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RNBU_HISTORY    to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on RNBU_HISTORY    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RNBU_HISTORY.sql =========*** End *** 
PROMPT ===================================================================================== 
