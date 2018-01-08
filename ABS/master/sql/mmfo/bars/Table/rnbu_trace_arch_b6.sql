

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RNBU_TRACE_ARCH_B6.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RNBU_TRACE_ARCH_B6 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RNBU_TRACE_ARCH_B6'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''RNBU_TRACE_ARCH_B6'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''RNBU_TRACE_ARCH_B6'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RNBU_TRACE_ARCH_B6 ***
begin 
  execute immediate '
  CREATE TABLE BARS.RNBU_TRACE_ARCH_B6 
   (	KODF VARCHAR2(2), 
	DATF DATE, 
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
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RNBU_TRACE_ARCH_B6 ***
 exec bpa.alter_policies('RNBU_TRACE_ARCH_B6');


COMMENT ON TABLE BARS.RNBU_TRACE_ARCH_B6 IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE_ARCH_B6.KODF IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE_ARCH_B6.DATF IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE_ARCH_B6.NLS IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE_ARCH_B6.KV IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE_ARCH_B6.ODATE IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE_ARCH_B6.KODP IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE_ARCH_B6.ZNAP IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE_ARCH_B6.NBUC IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE_ARCH_B6.ISP IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE_ARCH_B6.RNK IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE_ARCH_B6.ACC IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE_ARCH_B6.REF IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE_ARCH_B6.COMM IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE_ARCH_B6.ND IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE_ARCH_B6.MDATE IS '';
COMMENT ON COLUMN BARS.RNBU_TRACE_ARCH_B6.TOBO IS '';



PROMPT *** Create  grants  RNBU_TRACE_ARCH_B6 ***
grant SELECT                                                                 on RNBU_TRACE_ARCH_B6 to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_TRACE_ARCH_B6 to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNBU_TRACE_ARCH_B6 to START1;
grant SELECT                                                                 on RNBU_TRACE_ARCH_B6 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RNBU_TRACE_ARCH_B6.sql =========*** En
PROMPT ===================================================================================== 
