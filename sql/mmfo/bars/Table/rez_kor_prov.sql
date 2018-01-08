

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_KOR_PROV.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_KOR_PROV ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_KOR_PROV'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REZ_KOR_PROV'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REZ_KOR_PROV'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_KOR_PROV ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.REZ_KOR_PROV 
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




PROMPT *** ALTER_POLICIES to REZ_KOR_PROV ***
 exec bpa.alter_policies('REZ_KOR_PROV');


COMMENT ON TABLE BARS.REZ_KOR_PROV IS '';
COMMENT ON COLUMN BARS.REZ_KOR_PROV.REF IS '';
COMMENT ON COLUMN BARS.REZ_KOR_PROV.DK IS '';
COMMENT ON COLUMN BARS.REZ_KOR_PROV.ACC IS '';
COMMENT ON COLUMN BARS.REZ_KOR_PROV.S IS '';
COMMENT ON COLUMN BARS.REZ_KOR_PROV.FDAT IS '';
COMMENT ON COLUMN BARS.REZ_KOR_PROV.SOS IS '';
COMMENT ON COLUMN BARS.REZ_KOR_PROV.VOB IS '';
COMMENT ON COLUMN BARS.REZ_KOR_PROV.VDAT IS '';
COMMENT ON COLUMN BARS.REZ_KOR_PROV.SQ IS '';



PROMPT *** Create  grants  REZ_KOR_PROV ***
grant SELECT                                                                 on REZ_KOR_PROV    to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REZ_KOR_PROV    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_KOR_PROV.sql =========*** End *** 
PROMPT ===================================================================================== 
