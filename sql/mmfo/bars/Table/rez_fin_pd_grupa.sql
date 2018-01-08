

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_FIN_PD_GRUPA.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_FIN_PD_GRUPA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_FIN_PD_GRUPA'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''REZ_FIN_PD_GRUPA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_FIN_PD_GRUPA ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_FIN_PD_GRUPA 
   (	KOL_MIN NUMBER, 
	KOL_MAX NUMBER, 
	FIN NUMBER(*,0), 
	PD NUMBER, 
	PDV NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_FIN_PD_GRUPA ***
 exec bpa.alter_policies('REZ_FIN_PD_GRUPA');


COMMENT ON TABLE BARS.REZ_FIN_PD_GRUPA IS 'Довідник груп формування резерву';
COMMENT ON COLUMN BARS.REZ_FIN_PD_GRUPA.KOL_MIN IS 'К-ть днів просрочення від';
COMMENT ON COLUMN BARS.REZ_FIN_PD_GRUPA.KOL_MAX IS 'К-ть днів просрочення до';
COMMENT ON COLUMN BARS.REZ_FIN_PD_GRUPA.FIN IS 'Клас контрагента';
COMMENT ON COLUMN BARS.REZ_FIN_PD_GRUPA.PD IS 'Значення коефіцієнту імовірності дефолту ';
COMMENT ON COLUMN BARS.REZ_FIN_PD_GRUPA.PDV IS '';



PROMPT *** Create  grants  REZ_FIN_PD_GRUPA ***
grant SELECT                                                                 on REZ_FIN_PD_GRUPA to BARSREADER_ROLE;
grant SELECT                                                                 on REZ_FIN_PD_GRUPA to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REZ_FIN_PD_GRUPA to RCC_DEAL;
grant SELECT                                                                 on REZ_FIN_PD_GRUPA to START1;
grant SELECT                                                                 on REZ_FIN_PD_GRUPA to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_FIN_PD_GRUPA.sql =========*** End 
PROMPT ===================================================================================== 
