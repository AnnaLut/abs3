

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_XOZ_OPER.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_XOZ_OPER ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_XOZ_OPER ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_XOZ_OPER 
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
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_XOZ_OPER ***
 exec bpa.alter_policies('TMP_XOZ_OPER');


COMMENT ON TABLE BARS.TMP_XOZ_OPER IS '';
COMMENT ON COLUMN BARS.TMP_XOZ_OPER.S1 IS '';
COMMENT ON COLUMN BARS.TMP_XOZ_OPER.S2 IS '';
COMMENT ON COLUMN BARS.TMP_XOZ_OPER.S IS '';
COMMENT ON COLUMN BARS.TMP_XOZ_OPER.NLSA IS '';
COMMENT ON COLUMN BARS.TMP_XOZ_OPER.NAMA IS '';
COMMENT ON COLUMN BARS.TMP_XOZ_OPER.NLSB IS '';
COMMENT ON COLUMN BARS.TMP_XOZ_OPER.NAMB IS '';
COMMENT ON COLUMN BARS.TMP_XOZ_OPER.ND IS '';
COMMENT ON COLUMN BARS.TMP_XOZ_OPER.MFOA IS '';
COMMENT ON COLUMN BARS.TMP_XOZ_OPER.MFOB IS '';
COMMENT ON COLUMN BARS.TMP_XOZ_OPER.SOS IS '';
COMMENT ON COLUMN BARS.TMP_XOZ_OPER.REC IS '';
COMMENT ON COLUMN BARS.TMP_XOZ_OPER.REF IS '';
COMMENT ON COLUMN BARS.TMP_XOZ_OPER.DK IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_XOZ_OPER.sql =========*** End *** 
PROMPT ===================================================================================== 
