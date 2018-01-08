

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_KOREL.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_KOREL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_KOREL ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_KOREL 
   (	DAT DATE, 
	KV1 NUMBER(*,0), 
	KV2 NUMBER(*,0), 
	KOEF NUMBER
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_KOREL ***
 exec bpa.alter_policies('TMP_KOREL');


COMMENT ON TABLE BARS.TMP_KOREL IS '';
COMMENT ON COLUMN BARS.TMP_KOREL.DAT IS '';
COMMENT ON COLUMN BARS.TMP_KOREL.KV1 IS '';
COMMENT ON COLUMN BARS.TMP_KOREL.KV2 IS '';
COMMENT ON COLUMN BARS.TMP_KOREL.KOEF IS '';



PROMPT *** Create  grants  TMP_KOREL ***
grant SELECT                                                                 on TMP_KOREL       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_KOREL       to RPBN001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_KOREL       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_KOREL.sql =========*** End *** ===
PROMPT ===================================================================================== 
