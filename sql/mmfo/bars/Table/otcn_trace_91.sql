

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_TRACE_91.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_TRACE_91 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_TRACE_91'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OTCN_TRACE_91'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OTCN_TRACE_91'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_TRACE_91 ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_TRACE_91 
   (	RECID NUMBER, 
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
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_TRACE_91 ***
 exec bpa.alter_policies('OTCN_TRACE_91');


COMMENT ON TABLE BARS.OTCN_TRACE_91 IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_91.RECID IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_91.USERID IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_91.NLS IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_91.KV IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_91.ODATE IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_91.KODP IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_91.ZNAP IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_91.NBUC IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_91.ISP IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_91.RNK IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_91.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_91.REF IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_91.COMM IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_91.ND IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_91.MDATE IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_91.TOBO IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_91.KF IS '';




PROMPT *** Create  constraint CC_OTCNTRACE91_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_TRACE_91 MODIFY (KF CONSTRAINT CC_OTCNTRACE91_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_TRACE_91 ***
grant SELECT                                                                 on OTCN_TRACE_91   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_TRACE_91   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_TRACE_91   to RPBN002;
grant SELECT                                                                 on OTCN_TRACE_91   to UPLD;



PROMPT *** Create SYNONYM  to OTCN_TRACE_91 ***

  CREATE OR REPLACE PUBLIC SYNONYM OTCN_TRACE_91 FOR BARS.OTCN_TRACE_91;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_TRACE_91.sql =========*** End ***
PROMPT ===================================================================================== 
