

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOR_PROV.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOR_PROV ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOR_PROV ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.KOR_PROV 
   (	REF NUMBER(38,0), 
	DK NUMBER(38,0), 
	ACC NUMBER, 
	S NUMBER(24,0), 
	FDAT DATE, 
	SOS NUMBER(38,0), 
	VOB NUMBER(38,0), 
	VDAT DATE, 
	SQ NUMBER(24,0)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOR_PROV ***
 exec bpa.alter_policies('KOR_PROV');


COMMENT ON TABLE BARS.KOR_PROV IS '';
COMMENT ON COLUMN BARS.KOR_PROV.REF IS '';
COMMENT ON COLUMN BARS.KOR_PROV.DK IS '';
COMMENT ON COLUMN BARS.KOR_PROV.ACC IS '';
COMMENT ON COLUMN BARS.KOR_PROV.S IS '';
COMMENT ON COLUMN BARS.KOR_PROV.FDAT IS '';
COMMENT ON COLUMN BARS.KOR_PROV.SOS IS '';
COMMENT ON COLUMN BARS.KOR_PROV.VOB IS '';
COMMENT ON COLUMN BARS.KOR_PROV.VDAT IS '';
COMMENT ON COLUMN BARS.KOR_PROV.SQ IS '';



PROMPT *** Create  grants  KOR_PROV ***
grant SELECT                                                                 on KOR_PROV        to BARSREADER_ROLE;
grant SELECT                                                                 on KOR_PROV        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KOR_PROV        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOR_PROV.sql =========*** End *** ====
PROMPT ===================================================================================== 
