

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_TRACE_91.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_TRACE_91 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_TRACE_91'', ''FILIAL'' , null, null, null, null);
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
	TOBO VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
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



PROMPT *** Create  grants  OTCN_TRACE_91 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_TRACE_91   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_TRACE_91   to RPBN002;



PROMPT *** Create SYNONYM  to OTCN_TRACE_91 ***

  CREATE OR REPLACE PUBLIC SYNONYM OTCN_TRACE_91 FOR BARS.OTCN_TRACE_91;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_TRACE_91.sql =========*** End ***
PROMPT ===================================================================================== 
