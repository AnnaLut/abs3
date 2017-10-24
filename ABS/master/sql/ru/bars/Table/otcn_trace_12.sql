

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_TRACE_12.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_TRACE_12 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_TRACE_12'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_TRACE_12'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_TRACE_12 ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_TRACE_12 
   (	DATF DATE, 
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




PROMPT *** ALTER_POLICIES to OTCN_TRACE_12 ***
 exec bpa.alter_policies('OTCN_TRACE_12');


COMMENT ON TABLE BARS.OTCN_TRACE_12 IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_12.DATF IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_12.USERID IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_12.NLS IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_12.KV IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_12.ODATE IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_12.KODP IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_12.ZNAP IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_12.NBUC IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_12.ISP IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_12.RNK IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_12.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_12.REF IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_12.COMM IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_12.ND IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_12.MDATE IS '';
COMMENT ON COLUMN BARS.OTCN_TRACE_12.TOBO IS '';



PROMPT *** Create  grants  OTCN_TRACE_12 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_TRACE_12   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_TRACE_12   to RPBN002;



PROMPT *** Create SYNONYM  to OTCN_TRACE_12 ***

  CREATE OR REPLACE PUBLIC SYNONYM OTCN_TRACE_12 FOR BARS.OTCN_TRACE_12;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_TRACE_12.sql =========*** End ***
PROMPT ===================================================================================== 
