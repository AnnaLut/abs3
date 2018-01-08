

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_SHEM.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_SHEM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_SHEM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_SHEM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_SHEM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_SHEM ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_SHEM 
   (	KOD_SHEM CHAR(2), 
	TXT VARCHAR2(48)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_SHEM ***
 exec bpa.alter_policies('KOD_SHEM');


COMMENT ON TABLE BARS.KOD_SHEM IS '';
COMMENT ON COLUMN BARS.KOD_SHEM.KOD_SHEM IS '';
COMMENT ON COLUMN BARS.KOD_SHEM.TXT IS '';



PROMPT *** Create  grants  KOD_SHEM ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_SHEM        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_SHEM        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_SHEM.sql =========*** End *** ====
PROMPT ===================================================================================== 
