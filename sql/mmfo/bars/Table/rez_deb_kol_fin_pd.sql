

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_DEB_KOL_FIN_PD.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_DEB_KOL_FIN_PD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_DEB_KOL_FIN_PD'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''REZ_DEB_KOL_FIN_PD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_DEB_KOL_FIN_PD ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_DEB_KOL_FIN_PD 
   (	DEB NUMBER(*,0), 
	KOL_MIN NUMBER, 
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




PROMPT *** ALTER_POLICIES to REZ_DEB_KOL_FIN_PD ***
 exec bpa.alter_policies('REZ_DEB_KOL_FIN_PD');


COMMENT ON TABLE BARS.REZ_DEB_KOL_FIN_PD IS 'Довідник груп формування резерву';
COMMENT ON COLUMN BARS.REZ_DEB_KOL_FIN_PD.DEB IS 'Тип дебиторки 1-фин. 2-хоз';
COMMENT ON COLUMN BARS.REZ_DEB_KOL_FIN_PD.KOL_MIN IS 'К-ть днів просрочення від';
COMMENT ON COLUMN BARS.REZ_DEB_KOL_FIN_PD.KOL_MAX IS 'К-ть днів просрочення до';
COMMENT ON COLUMN BARS.REZ_DEB_KOL_FIN_PD.FIN IS 'Клас контрагента';
COMMENT ON COLUMN BARS.REZ_DEB_KOL_FIN_PD.PD IS 'Значення коефіцієнту імовірності дефолту ';




PROMPT *** Create  index I1_REZ_DEB_KOL_FIN_PD ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_REZ_DEB_KOL_FIN_PD ON BARS.REZ_DEB_KOL_FIN_PD (DEB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REZ_DEB_KOL_FIN_PD ***
grant SELECT                                                                 on REZ_DEB_KOL_FIN_PD to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REZ_DEB_KOL_FIN_PD to RCC_DEAL;
grant SELECT                                                                 on REZ_DEB_KOL_FIN_PD to START1;
grant SELECT                                                                 on REZ_DEB_KOL_FIN_PD to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_DEB_KOL_FIN_PD.sql =========*** En
PROMPT ===================================================================================== 
