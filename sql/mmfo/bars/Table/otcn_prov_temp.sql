

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_PROV_TEMP.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_PROV_TEMP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_PROV_TEMP ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.OTCN_PROV_TEMP 
   (	KO NUMBER, 
	RNK NUMBER, 
	REF NUMBER, 
	TT VARCHAR2(20), 
	FDAT DATE, 
	ACCK NUMBER, 
	NLSK VARCHAR2(20), 
	KV NUMBER, 
	ACCD NUMBER, 
	NLSD VARCHAR2(20), 
	S_NOM NUMBER DEFAULT 0, 
	S_EQV NUMBER DEFAULT 0, 
	S_KOM NUMBER, 
	NAZN VARCHAR2(160), 
	BRANCH VARCHAR2(30)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_PROV_TEMP ***
 exec bpa.alter_policies('OTCN_PROV_TEMP');


COMMENT ON TABLE BARS.OTCN_PROV_TEMP IS 'Временная таблица проводок для файлов #70, #C9, #D3';
COMMENT ON COLUMN BARS.OTCN_PROV_TEMP.KO IS '';
COMMENT ON COLUMN BARS.OTCN_PROV_TEMP.RNK IS '';
COMMENT ON COLUMN BARS.OTCN_PROV_TEMP.REF IS '';
COMMENT ON COLUMN BARS.OTCN_PROV_TEMP.TT IS '';
COMMENT ON COLUMN BARS.OTCN_PROV_TEMP.FDAT IS '';
COMMENT ON COLUMN BARS.OTCN_PROV_TEMP.ACCK IS '';
COMMENT ON COLUMN BARS.OTCN_PROV_TEMP.NLSK IS '';
COMMENT ON COLUMN BARS.OTCN_PROV_TEMP.KV IS '';
COMMENT ON COLUMN BARS.OTCN_PROV_TEMP.ACCD IS '';
COMMENT ON COLUMN BARS.OTCN_PROV_TEMP.NLSD IS '';
COMMENT ON COLUMN BARS.OTCN_PROV_TEMP.S_NOM IS '';
COMMENT ON COLUMN BARS.OTCN_PROV_TEMP.S_EQV IS '';
COMMENT ON COLUMN BARS.OTCN_PROV_TEMP.S_KOM IS '';
COMMENT ON COLUMN BARS.OTCN_PROV_TEMP.NAZN IS '';
COMMENT ON COLUMN BARS.OTCN_PROV_TEMP.BRANCH IS '';



PROMPT *** Create  grants  OTCN_PROV_TEMP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_PROV_TEMP  to ABS_ADMIN;
grant SELECT                                                                 on OTCN_PROV_TEMP  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_PROV_TEMP  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_PROV_TEMP  to RPBN002;
grant SELECT                                                                 on OTCN_PROV_TEMP  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTCN_PROV_TEMP  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_PROV_TEMP.sql =========*** End **
PROMPT ===================================================================================== 
