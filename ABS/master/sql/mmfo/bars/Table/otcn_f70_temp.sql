

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_F70_TEMP.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_F70_TEMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_F70_TEMP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_F70_TEMP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_F70_TEMP ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.OTCN_F70_TEMP 
   (	KO NUMBER, 
	RNK NUMBER, 
	REF NUMBER, 
	ACCK NUMBER, 
	NLSK VARCHAR2(20), 
	KV NUMBER, 
	NLSD VARCHAR2(20), 
	S_NOM NUMBER DEFAULT 0, 
	S_EQV NUMBER DEFAULT 0, 
	S_KOM NUMBER DEFAULT 0, 
	NAZN VARCHAR2(160), 
	ACCD NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_F70_TEMP ***
 exec bpa.alter_policies('OTCN_F70_TEMP');


COMMENT ON TABLE BARS.OTCN_F70_TEMP IS 'Временная таблица проводок для файлов #С9';
COMMENT ON COLUMN BARS.OTCN_F70_TEMP.KO IS '';
COMMENT ON COLUMN BARS.OTCN_F70_TEMP.RNK IS '';
COMMENT ON COLUMN BARS.OTCN_F70_TEMP.REF IS '';
COMMENT ON COLUMN BARS.OTCN_F70_TEMP.ACCK IS '';
COMMENT ON COLUMN BARS.OTCN_F70_TEMP.NLSK IS '';
COMMENT ON COLUMN BARS.OTCN_F70_TEMP.KV IS '';
COMMENT ON COLUMN BARS.OTCN_F70_TEMP.NLSD IS '';
COMMENT ON COLUMN BARS.OTCN_F70_TEMP.S_NOM IS '';
COMMENT ON COLUMN BARS.OTCN_F70_TEMP.S_EQV IS '';
COMMENT ON COLUMN BARS.OTCN_F70_TEMP.S_KOM IS '';
COMMENT ON COLUMN BARS.OTCN_F70_TEMP.NAZN IS '';
COMMENT ON COLUMN BARS.OTCN_F70_TEMP.ACCD IS '';



PROMPT *** Create  grants  OTCN_F70_TEMP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F70_TEMP   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F70_TEMP   to RPBN002;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTCN_F70_TEMP   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_F70_TEMP.sql =========*** End ***
PROMPT ===================================================================================== 
