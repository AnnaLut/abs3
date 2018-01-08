

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_MBK_DSW_REP.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_MBK_DSW_REP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_MBK_DSW_REP ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_MBK_DSW_REP 
   (	ORD NUMBER(3,0), 
	ND VARCHAR2(100), 
	NTIK VARCHAR2(100), 
	MB NUMBER(1,0), 
	TIPD NUMBER(1,0), 
	ID NUMBER(2,0), 
	DAT1 DATE, 
	DAT2 DATE, 
	RNK NUMBER(10,0), 
	KV NUMBER(3,0), 
	NLS VARCHAR2(14), 
	S NUMBER(20,0), 
	IR VARCHAR2(20), 
	CON NUMBER(3,0)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_MBK_DSW_REP ***
 exec bpa.alter_policies('TMP_MBK_DSW_REP');


COMMENT ON TABLE BARS.TMP_MBK_DSW_REP IS 'Платіжний календар МБК+DSW';
COMMENT ON COLUMN BARS.TMP_MBK_DSW_REP.ORD IS '';
COMMENT ON COLUMN BARS.TMP_MBK_DSW_REP.ND IS '';
COMMENT ON COLUMN BARS.TMP_MBK_DSW_REP.NTIK IS '';
COMMENT ON COLUMN BARS.TMP_MBK_DSW_REP.MB IS '';
COMMENT ON COLUMN BARS.TMP_MBK_DSW_REP.TIPD IS '';
COMMENT ON COLUMN BARS.TMP_MBK_DSW_REP.ID IS '';
COMMENT ON COLUMN BARS.TMP_MBK_DSW_REP.DAT1 IS '';
COMMENT ON COLUMN BARS.TMP_MBK_DSW_REP.DAT2 IS '';
COMMENT ON COLUMN BARS.TMP_MBK_DSW_REP.RNK IS '';
COMMENT ON COLUMN BARS.TMP_MBK_DSW_REP.KV IS '';
COMMENT ON COLUMN BARS.TMP_MBK_DSW_REP.NLS IS '';
COMMENT ON COLUMN BARS.TMP_MBK_DSW_REP.S IS '';
COMMENT ON COLUMN BARS.TMP_MBK_DSW_REP.IR IS '';
COMMENT ON COLUMN BARS.TMP_MBK_DSW_REP.CON IS '';



PROMPT *** Create  grants  TMP_MBK_DSW_REP ***
grant SELECT                                                                 on TMP_MBK_DSW_REP to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_MBK_DSW_REP to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_MBK_DSW_REP.sql =========*** End *
PROMPT ===================================================================================== 
