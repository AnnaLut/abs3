

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_TRACE_70.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_TRACE_70 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_TRACE_70'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OTCN_TRACE_70'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OTCN_TRACE_70'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_TRACE_70 ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_TRACE_70 
   (	KODF VARCHAR2(2), 
	DATF DATE, 
	USERID NUMBER, 
	NLS VARCHAR2(15), 
	KV NUMBER, 
	ODATE DATE, 
	KODP VARCHAR2(35), 
	ZNAP VARCHAR2(70), 
	NBUC VARCHAR2(30), 
	ISP NUMBER, 
	RNK NUMBER, 
	ACC NUMBER, 
	REF NUMBER, 
	COMM VARCHAR2(200), 
	ND NUMBER, 
	MDATE DATE, 
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




PROMPT *** ALTER_POLICIES to OTCN_TRACE_70 ***
 exec bpa.alter_policies('OTCN_TRACE_70');


COMMENT ON TABLE BARS.OTCN_TRACE_70 IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_70.KODF IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_70.DATF IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_70.USERID IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_70.NLS IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_70.KV IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_70.ODATE IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_70.KODP IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_70.ZNAP IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_70.NBUC IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_70.ISP IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_70.RNK IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_70.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_70.REF IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_70.COMM IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_70.ND IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_70.MDATE IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_70.TOBO IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_70.KF IS '';




PROMPT *** Create  index XPK_OTCN_TRACE_70 ***
begin   
 execute immediate '
  CREATE INDEX BARS.XPK_OTCN_TRACE_70 ON BARS.OTCN_TRACE_70 (KF, KODF, DATF, REF, ZNAP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_OTCN_TRACE_70 ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_OTCN_TRACE_70 ON BARS.OTCN_TRACE_70 (KF, DATF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_TRACE_70 ***
grant SELECT                                                                 on OTCN_TRACE_70   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_TRACE_70   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OTCN_TRACE_70   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_TRACE_70   to RPBN002;
grant SELECT                                                                 on OTCN_TRACE_70   to UPLD;



PROMPT *** Create SYNONYM  to OTCN_TRACE_70 ***

  CREATE OR REPLACE PUBLIC SYNONYM OTCN_TRACE_70 FOR BARS.OTCN_TRACE_70;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_TRACE_70.sql =========*** End ***
PROMPT ===================================================================================== 
