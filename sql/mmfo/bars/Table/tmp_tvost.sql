

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_TVOST.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_TVOST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_TVOST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_TVOST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_TVOST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_TVOST ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_TVOST 
   (	ID NUMBER(8,0), 
	DATOD DATE, 
	MFO NUMBER(9,0), 
	NLS NUMBER(14,0), 
	KV NUMBER(3,0), 
	DOS NUMBER(14,0), 
	DOSQ NUMBER(14,0), 
	KOS NUMBER(14,0), 
	KOSQ NUMBER(14,0), 
	OSTF NUMBER(14,0), 
	OSTQ NUMBER(14,0), 
	OKPO VARCHAR2(14), 
	NMK VARCHAR2(254), 
	ID_KLI CHAR(2)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_TVOST ***
 exec bpa.alter_policies('TMP_TVOST');


COMMENT ON TABLE BARS.TMP_TVOST IS '';
COMMENT ON COLUMN BARS.TMP_TVOST.KOSQ IS '';
COMMENT ON COLUMN BARS.TMP_TVOST.OSTF IS '';
COMMENT ON COLUMN BARS.TMP_TVOST.OSTQ IS '';
COMMENT ON COLUMN BARS.TMP_TVOST.OKPO IS '';
COMMENT ON COLUMN BARS.TMP_TVOST.NMK IS '';
COMMENT ON COLUMN BARS.TMP_TVOST.ID_KLI IS '';
COMMENT ON COLUMN BARS.TMP_TVOST.ID IS '';
COMMENT ON COLUMN BARS.TMP_TVOST.DATOD IS '';
COMMENT ON COLUMN BARS.TMP_TVOST.MFO IS '';
COMMENT ON COLUMN BARS.TMP_TVOST.NLS IS '';
COMMENT ON COLUMN BARS.TMP_TVOST.KV IS '';
COMMENT ON COLUMN BARS.TMP_TVOST.DOS IS '';
COMMENT ON COLUMN BARS.TMP_TVOST.DOSQ IS '';
COMMENT ON COLUMN BARS.TMP_TVOST.KOS IS '';



PROMPT *** Create  grants  TMP_TVOST ***
grant SELECT                                                                 on TMP_TVOST       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_TVOST       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_TVOST       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_TVOST       to START1;
grant SELECT                                                                 on TMP_TVOST       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_TVOST.sql =========*** End *** ===
PROMPT ===================================================================================== 
