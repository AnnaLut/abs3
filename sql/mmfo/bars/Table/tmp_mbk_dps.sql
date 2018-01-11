

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_MBK_DPS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_MBK_DPS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_MBK_DPS ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_MBK_DPS 
   (	PR NUMBER, 
	SROK NUMBER, 
	KV NUMBER(*,0), 
	N1 NUMBER, 
	N2 NUMBER, 
	N3 NUMBER, 
	N4 NUMBER, 
	N5 NUMBER, 
	N6 NUMBER, 
	N7 NUMBER, 
	N8 NUMBER, 
	N9 NUMBER, 
	N10 NUMBER, 
	N11 NUMBER, 
	N12 NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_MBK_DPS ***
 exec bpa.alter_policies('TMP_MBK_DPS');


COMMENT ON TABLE BARS.TMP_MBK_DPS IS '';
COMMENT ON COLUMN BARS.TMP_MBK_DPS.PR IS '';
COMMENT ON COLUMN BARS.TMP_MBK_DPS.SROK IS '';
COMMENT ON COLUMN BARS.TMP_MBK_DPS.KV IS '';
COMMENT ON COLUMN BARS.TMP_MBK_DPS.N1 IS '';
COMMENT ON COLUMN BARS.TMP_MBK_DPS.N2 IS '';
COMMENT ON COLUMN BARS.TMP_MBK_DPS.N3 IS '';
COMMENT ON COLUMN BARS.TMP_MBK_DPS.N4 IS '';
COMMENT ON COLUMN BARS.TMP_MBK_DPS.N5 IS '';
COMMENT ON COLUMN BARS.TMP_MBK_DPS.N6 IS '';
COMMENT ON COLUMN BARS.TMP_MBK_DPS.N7 IS '';
COMMENT ON COLUMN BARS.TMP_MBK_DPS.N8 IS '';
COMMENT ON COLUMN BARS.TMP_MBK_DPS.N9 IS '';
COMMENT ON COLUMN BARS.TMP_MBK_DPS.N10 IS '';
COMMENT ON COLUMN BARS.TMP_MBK_DPS.N11 IS '';
COMMENT ON COLUMN BARS.TMP_MBK_DPS.N12 IS '';



PROMPT *** Create  grants  TMP_MBK_DPS ***
grant SELECT                                                                 on TMP_MBK_DPS     to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_MBK_DPS     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_MBK_DPS.sql =========*** End *** =
PROMPT ===================================================================================== 
