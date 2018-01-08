

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_F42_TEMP.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_F42_TEMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_F42_TEMP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_F42_TEMP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_F42_TEMP ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.OTCN_F42_TEMP 
   (	ACC NUMBER, 
	KV NUMBER(*,0), 
	FDAT DATE, 
	NBS CHAR(4), 
	NLS VARCHAR2(15), 
	OST_NOM NUMBER, 
	OST_EQV NUMBER, 
	AP NUMBER, 
	R012 CHAR(1), 
	DDD CHAR(3), 
	R020 CHAR(4), 
	ACCC NUMBER(*,0), 
	ZAL NUMBER, 
	RNK NUMBER, 
	OB22 VARCHAR2(2)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_F42_TEMP ***
 exec bpa.alter_policies('OTCN_F42_TEMP');


COMMENT ON TABLE BARS.OTCN_F42_TEMP IS 'Временная таблица счетов и остатков для файла #42';
COMMENT ON COLUMN BARS.OTCN_F42_TEMP.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_F42_TEMP.KV IS '';
COMMENT ON COLUMN BARS.OTCN_F42_TEMP.FDAT IS '';
COMMENT ON COLUMN BARS.OTCN_F42_TEMP.NBS IS '';
COMMENT ON COLUMN BARS.OTCN_F42_TEMP.NLS IS '';
COMMENT ON COLUMN BARS.OTCN_F42_TEMP.OST_NOM IS '';
COMMENT ON COLUMN BARS.OTCN_F42_TEMP.OST_EQV IS '';
COMMENT ON COLUMN BARS.OTCN_F42_TEMP.AP IS '';
COMMENT ON COLUMN BARS.OTCN_F42_TEMP.R012 IS '';
COMMENT ON COLUMN BARS.OTCN_F42_TEMP.DDD IS '';
COMMENT ON COLUMN BARS.OTCN_F42_TEMP.R020 IS '';
COMMENT ON COLUMN BARS.OTCN_F42_TEMP.ACCC IS '';
COMMENT ON COLUMN BARS.OTCN_F42_TEMP.ZAL IS '';
COMMENT ON COLUMN BARS.OTCN_F42_TEMP.RNK IS '';
COMMENT ON COLUMN BARS.OTCN_F42_TEMP.OB22 IS '';




PROMPT *** Create  constraint SYS_C00139665 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F42_TEMP MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_OTCN_F42_TEMP ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_OTCN_F42_TEMP ON BARS.OTCN_F42_TEMP (RNK) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_OTCN_F42_TEMP ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_OTCN_F42_TEMP ON BARS.OTCN_F42_TEMP (NBS, R012) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_F42_TEMP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F42_TEMP   to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F42_TEMP   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F42_TEMP   to RPBN002;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTCN_F42_TEMP   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_F42_TEMP.sql =========*** End ***
PROMPT ===================================================================================== 
