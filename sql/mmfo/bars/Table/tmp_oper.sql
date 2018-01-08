

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OPER.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OPER ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OPER ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OPER 
   (	S1 NUMBER(24,0), 
	S2 NUMBER(24,0), 
	S NUMBER(24,0), 
	NLSA VARCHAR2(14), 
	NAMA VARCHAR2(38), 
	NLSB VARCHAR2(14), 
	NAMB VARCHAR2(38), 
	ND CHAR(10), 
	MFOA VARCHAR2(12), 
	MFOB VARCHAR2(12), 
	SOS NUMBER(1,0), 
	REC NUMBER(38,0), 
	REF NUMBER(38,0), 
	DK NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYNI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OPER ***
 exec bpa.alter_policies('TMP_OPER');


COMMENT ON TABLE BARS.TMP_OPER IS '';
COMMENT ON COLUMN BARS.TMP_OPER.S1 IS '';
COMMENT ON COLUMN BARS.TMP_OPER.S2 IS '';
COMMENT ON COLUMN BARS.TMP_OPER.S IS '';
COMMENT ON COLUMN BARS.TMP_OPER.NLSA IS '';
COMMENT ON COLUMN BARS.TMP_OPER.NAMA IS '';
COMMENT ON COLUMN BARS.TMP_OPER.NLSB IS '';
COMMENT ON COLUMN BARS.TMP_OPER.NAMB IS '';
COMMENT ON COLUMN BARS.TMP_OPER.ND IS '';
COMMENT ON COLUMN BARS.TMP_OPER.MFOA IS '';
COMMENT ON COLUMN BARS.TMP_OPER.MFOB IS '';
COMMENT ON COLUMN BARS.TMP_OPER.SOS IS '';
COMMENT ON COLUMN BARS.TMP_OPER.REC IS '';
COMMENT ON COLUMN BARS.TMP_OPER.REF IS '';
COMMENT ON COLUMN BARS.TMP_OPER.DK IS '';



PROMPT *** Create  grants  TMP_OPER ***
grant SELECT                                                                 on TMP_OPER        to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_OPER        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OPER.sql =========*** End *** ====
PROMPT ===================================================================================== 
