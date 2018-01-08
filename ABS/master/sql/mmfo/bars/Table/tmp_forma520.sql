

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_FORMA520.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_FORMA520 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_FORMA520'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_FORMA520'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_FORMA520'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_FORMA520 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_FORMA520 
   (	NLS VARCHAR2(14), 
	KV NUMBER(3,0), 
	NMS VARCHAR2(38), 
	IN_OST NUMBER(24,0), 
	DOS NUMBER(24,0), 
	KOS NUMBER(24,0), 
	OUT_OST NUMBER(24,0), 
	USERID NUMBER, 
	DATE1 DATE, 
	DATE2 DATE
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_FORMA520 ***
 exec bpa.alter_policies('TMP_FORMA520');


COMMENT ON TABLE BARS.TMP_FORMA520 IS '';
COMMENT ON COLUMN BARS.TMP_FORMA520.NLS IS '';
COMMENT ON COLUMN BARS.TMP_FORMA520.KV IS '';
COMMENT ON COLUMN BARS.TMP_FORMA520.NMS IS '';
COMMENT ON COLUMN BARS.TMP_FORMA520.IN_OST IS '';
COMMENT ON COLUMN BARS.TMP_FORMA520.DOS IS '';
COMMENT ON COLUMN BARS.TMP_FORMA520.KOS IS '';
COMMENT ON COLUMN BARS.TMP_FORMA520.OUT_OST IS '';
COMMENT ON COLUMN BARS.TMP_FORMA520.USERID IS '';
COMMENT ON COLUMN BARS.TMP_FORMA520.DATE1 IS '';
COMMENT ON COLUMN BARS.TMP_FORMA520.DATE2 IS '';



PROMPT *** Create  grants  TMP_FORMA520 ***
grant SELECT                                                                 on TMP_FORMA520    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_FORMA520    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_FORMA520    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_FORMA520    to START1;
grant SELECT                                                                 on TMP_FORMA520    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_FORMA520.sql =========*** End *** 
PROMPT ===================================================================================== 
