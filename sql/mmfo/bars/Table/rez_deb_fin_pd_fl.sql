

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_DEB_FIN_PD_FL.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_DEB_FIN_PD_FL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_DEB_FIN_PD_FL'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''REZ_DEB_FIN_PD_FL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_DEB_FIN_PD_FL ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_DEB_FIN_PD_FL 
   (	KOL_MIN NUMBER, 
	KOL_MAX NUMBER, 
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




PROMPT *** ALTER_POLICIES to REZ_DEB_FIN_PD_FL ***
 exec bpa.alter_policies('REZ_DEB_FIN_PD_FL');


COMMENT ON TABLE BARS.REZ_DEB_FIN_PD_FL IS 'Довідник коефіцієнту імовірності дефолту ДЛЯ дебіторки < 3 міс.';
COMMENT ON COLUMN BARS.REZ_DEB_FIN_PD_FL.KOL_MIN IS 'К-ть днів просрочення від';
COMMENT ON COLUMN BARS.REZ_DEB_FIN_PD_FL.KOL_MAX IS 'К-ть днів просрочення до';
COMMENT ON COLUMN BARS.REZ_DEB_FIN_PD_FL.FIN IS 'Клас контрагента';
COMMENT ON COLUMN BARS.REZ_DEB_FIN_PD_FL.PD IS 'Значення коефіцієнту імовірності дефолту ';



PROMPT *** Create  grants  REZ_DEB_FIN_PD_FL ***
grant SELECT                                                                 on REZ_DEB_FIN_PD_FL to BARSREADER_ROLE;
grant SELECT                                                                 on REZ_DEB_FIN_PD_FL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REZ_DEB_FIN_PD_FL to RCC_DEAL;
grant SELECT                                                                 on REZ_DEB_FIN_PD_FL to START1;
grant SELECT                                                                 on REZ_DEB_FIN_PD_FL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_DEB_FIN_PD_FL.sql =========*** End
PROMPT ===================================================================================== 
