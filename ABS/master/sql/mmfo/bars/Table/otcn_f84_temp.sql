

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_F84_TEMP.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_F84_TEMP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_F84_TEMP ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.OTCN_F84_TEMP 
   (	ACCD NUMBER, 
	NLSD VARCHAR2(15), 
	KV NUMBER, 
	FDAT DATE, 
	S NUMBER DEFAULT 0, 
	ACCK NUMBER, 
	NLSK VARCHAR2(15), 
	DDD VARCHAR2(3), 
	NAZN VARCHAR2(160), 
	REF NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_F84_TEMP ***
 exec bpa.alter_policies('OTCN_F84_TEMP');


COMMENT ON TABLE BARS.OTCN_F84_TEMP IS 'Временная таблица проводок для файла #84';
COMMENT ON COLUMN BARS.OTCN_F84_TEMP.ACCD IS '';
COMMENT ON COLUMN BARS.OTCN_F84_TEMP.NLSD IS '';
COMMENT ON COLUMN BARS.OTCN_F84_TEMP.KV IS '';
COMMENT ON COLUMN BARS.OTCN_F84_TEMP.FDAT IS '';
COMMENT ON COLUMN BARS.OTCN_F84_TEMP.S IS '';
COMMENT ON COLUMN BARS.OTCN_F84_TEMP.ACCK IS '';
COMMENT ON COLUMN BARS.OTCN_F84_TEMP.NLSK IS '';
COMMENT ON COLUMN BARS.OTCN_F84_TEMP.DDD IS '';
COMMENT ON COLUMN BARS.OTCN_F84_TEMP.NAZN IS '';
COMMENT ON COLUMN BARS.OTCN_F84_TEMP.REF IS '';



PROMPT *** Create  grants  OTCN_F84_TEMP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F84_TEMP   to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F84_TEMP   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F84_TEMP   to RPBN002;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTCN_F84_TEMP   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_F84_TEMP.sql =========*** End ***
PROMPT ===================================================================================== 
