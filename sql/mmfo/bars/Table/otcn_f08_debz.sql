

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_F08_DEBZ.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_F08_DEBZ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_F08_DEBZ'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_F08_DEBZ'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OTCN_F08_DEBZ'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_F08_DEBZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_F08_DEBZ 
   (	REF NUMBER, 
	TT CHAR(3), 
	FDAT DATE, 
	ACCD NUMBER, 
	NLSD VARCHAR2(15), 
	KV NUMBER(*,0), 
	ACCK NUMBER, 
	NLSK VARCHAR2(15), 
	K072 VARCHAR2(1), 
	S NUMBER, 
	SQ NUMBER, 
	OSTP NUMBER, 
	NAZN VARCHAR2(160), 
	ISP NUMBER, 
	ND VARCHAR2(10), 
	DATD DATE, 
	RECID NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_F08_DEBZ ***
 exec bpa.alter_policies('OTCN_F08_DEBZ');


COMMENT ON TABLE BARS.OTCN_F08_DEBZ IS 'Архив проводок по счетам дебеторской задолженности для файла #08';
COMMENT ON COLUMN BARS.OTCN_F08_DEBZ.REF IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DEBZ.TT IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DEBZ.FDAT IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DEBZ.ACCD IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DEBZ.NLSD IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DEBZ.KV IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DEBZ.ACCK IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DEBZ.NLSK IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DEBZ.K072 IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DEBZ.S IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DEBZ.SQ IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DEBZ.OSTP IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DEBZ.NAZN IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DEBZ.ISP IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DEBZ.ND IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DEBZ.DATD IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DEBZ.RECID IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DEBZ.KF IS '';




PROMPT *** Create  constraint SYS_C0011945 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F08_DEBZ ADD PRIMARY KEY (RECID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005222 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F08_DEBZ MODIFY (REF NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OTCNF08DEBZ_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F08_DEBZ MODIFY (KF CONSTRAINT CC_OTCNF08DEBZ_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005223 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F08_DEBZ MODIFY (RECID NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XSK_F08_DEBZ ***
begin   
 execute immediate '
  CREATE INDEX BARS.XSK_F08_DEBZ ON BARS.OTCN_F08_DEBZ (FDAT, REF, TT, NLSD, KV, NLSK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0011945 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0011945 ON BARS.OTCN_F08_DEBZ (RECID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_F08_DEBZ ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F08_DEBZ   to ABS_ADMIN;
grant SELECT                                                                 on OTCN_F08_DEBZ   to BARSREADER_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on OTCN_F08_DEBZ   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OTCN_F08_DEBZ   to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on OTCN_F08_DEBZ   to RPBN002;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on OTCN_F08_DEBZ   to SALGL;
grant SELECT                                                                 on OTCN_F08_DEBZ   to START1;
grant SELECT                                                                 on OTCN_F08_DEBZ   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTCN_F08_DEBZ   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_F08_DEBZ.sql =========*** End ***
PROMPT ===================================================================================== 
