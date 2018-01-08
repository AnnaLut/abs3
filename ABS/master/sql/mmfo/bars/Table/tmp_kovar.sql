

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_KOVAR.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_KOVAR ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_KOVAR ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_KOVAR 
   (	DAT DATE, 
	KV1 NUMBER(*,0), 
	KV2 NUMBER(*,0), 
	KOEF NUMBER
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_KOVAR ***
 exec bpa.alter_policies('TMP_KOVAR');


COMMENT ON TABLE BARS.TMP_KOVAR IS '';
COMMENT ON COLUMN BARS.TMP_KOVAR.DAT IS '';
COMMENT ON COLUMN BARS.TMP_KOVAR.KV1 IS '';
COMMENT ON COLUMN BARS.TMP_KOVAR.KV2 IS '';
COMMENT ON COLUMN BARS.TMP_KOVAR.KOEF IS '';



PROMPT *** Create  grants  TMP_KOVAR ***
grant SELECT                                                                 on TMP_KOVAR       to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_KOVAR       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_KOVAR       to RPBN001;
grant SELECT                                                                 on TMP_KOVAR       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_KOVAR       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_KOVAR.sql =========*** End *** ===
PROMPT ===================================================================================== 
