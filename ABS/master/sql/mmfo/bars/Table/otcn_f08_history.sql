

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_F08_HISTORY.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_F08_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_F08_HISTORY'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OTCN_F08_HISTORY'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OTCN_F08_HISTORY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_F08_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_F08_HISTORY 
   (	ACCD NUMBER, 
	TT CHAR(3), 
	REF NUMBER, 
	KV NUMBER(*,0), 
	NLSD VARCHAR2(15), 
	S VARCHAR2(16), 
	SQ VARCHAR2(16), 
	FDAT DATE, 
	NAZN VARCHAR2(160), 
	ACCK NUMBER, 
	NLSK VARCHAR2(15), 
	ISP NUMBER, 
	USERID NUMBER, 
	TOBO VARCHAR2(30), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	VOB NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_F08_HISTORY ***
 exec bpa.alter_policies('OTCN_F08_HISTORY');


COMMENT ON TABLE BARS.OTCN_F08_HISTORY IS 'Архив проводок по счетам доходов/расходов для файла #08';
COMMENT ON COLUMN BARS.OTCN_F08_HISTORY.ACCD IS '';
COMMENT ON COLUMN BARS.OTCN_F08_HISTORY.TT IS '';
COMMENT ON COLUMN BARS.OTCN_F08_HISTORY.REF IS '';
COMMENT ON COLUMN BARS.OTCN_F08_HISTORY.KV IS '';
COMMENT ON COLUMN BARS.OTCN_F08_HISTORY.NLSD IS '';
COMMENT ON COLUMN BARS.OTCN_F08_HISTORY.S IS '';
COMMENT ON COLUMN BARS.OTCN_F08_HISTORY.SQ IS '';
COMMENT ON COLUMN BARS.OTCN_F08_HISTORY.FDAT IS '';
COMMENT ON COLUMN BARS.OTCN_F08_HISTORY.NAZN IS '';
COMMENT ON COLUMN BARS.OTCN_F08_HISTORY.ACCK IS '';
COMMENT ON COLUMN BARS.OTCN_F08_HISTORY.NLSK IS '';
COMMENT ON COLUMN BARS.OTCN_F08_HISTORY.ISP IS '';
COMMENT ON COLUMN BARS.OTCN_F08_HISTORY.USERID IS '';
COMMENT ON COLUMN BARS.OTCN_F08_HISTORY.TOBO IS '';
COMMENT ON COLUMN BARS.OTCN_F08_HISTORY.KF IS '';
COMMENT ON COLUMN BARS.OTCN_F08_HISTORY.VOB IS '';




PROMPT *** Create  constraint SYS_C007589 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F08_HISTORY MODIFY (KV NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_OTCN_F08_HISTORY ***
begin   
 execute immediate '
  CREATE INDEX BARS.XPK_OTCN_F08_HISTORY ON BARS.OTCN_F08_HISTORY (FDAT, REF, TT, ACCD, NLSD, KV, ACCK, NLSK, TOBO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_OTCN_F08_HISTORY ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_OTCN_F08_HISTORY ON BARS.OTCN_F08_HISTORY (KF, FDAT, NLSD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_OTCN_F08_HISTORY ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_OTCN_F08_HISTORY ON BARS.OTCN_F08_HISTORY (KF, FDAT, NLSK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_F08_HISTORY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F08_HISTORY to ABS_ADMIN;
grant SELECT                                                                 on OTCN_F08_HISTORY to BARSREADER_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on OTCN_F08_HISTORY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OTCN_F08_HISTORY to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on OTCN_F08_HISTORY to RPBN002;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on OTCN_F08_HISTORY to SALGL;
grant SELECT                                                                 on OTCN_F08_HISTORY to START1;
grant SELECT                                                                 on OTCN_F08_HISTORY to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTCN_F08_HISTORY to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_F08_HISTORY.sql =========*** End 
PROMPT ===================================================================================== 
