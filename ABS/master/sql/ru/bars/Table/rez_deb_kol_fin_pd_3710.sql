

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_DEB_KOL_FIN_PD_3710.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_DEB_KOL_FIN_PD_3710 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_DEB_KOL_FIN_PD_3710'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REZ_DEB_KOL_FIN_PD_3710'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_DEB_KOL_FIN_PD_3710 ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_DEB_KOL_FIN_PD_3710 
   (	KOL_MIN NUMBER(*,0), 
	KOL_MAX NUMBER(*,0), 
	FIN NUMBER(*,0), 
	PD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_DEB_KOL_FIN_PD_3710 ***
 exec bpa.alter_policies('REZ_DEB_KOL_FIN_PD_3710');


COMMENT ON TABLE BARS.REZ_DEB_KOL_FIN_PD_3710 IS 'Довідник груп формування резерву';
COMMENT ON COLUMN BARS.REZ_DEB_KOL_FIN_PD_3710.KOL_MIN IS 'К-ть днів просрочення від';
COMMENT ON COLUMN BARS.REZ_DEB_KOL_FIN_PD_3710.KOL_MAX IS 'К-ть днів просрочення до';
COMMENT ON COLUMN BARS.REZ_DEB_KOL_FIN_PD_3710.FIN IS 'Клас контрагента';
COMMENT ON COLUMN BARS.REZ_DEB_KOL_FIN_PD_3710.PD IS 'Значення коефіцієнту імовірності дефолту ';



PROMPT *** Create  grants  REZ_DEB_KOL_FIN_PD_3710 ***
grant SELECT                                                                 on REZ_DEB_KOL_FIN_PD_3710 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REZ_DEB_KOL_FIN_PD_3710 to RCC_DEAL;
grant SELECT                                                                 on REZ_DEB_KOL_FIN_PD_3710 to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_DEB_KOL_FIN_PD_3710.sql =========*
PROMPT ===================================================================================== 
