

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_FIN_PD_GRUPA_UL.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_FIN_PD_GRUPA_UL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_FIN_PD_GRUPA_UL'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''REZ_FIN_PD_GRUPA_UL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_FIN_PD_GRUPA_UL ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_FIN_PD_GRUPA_UL 
   (	PR_MIN NUMBER, 
	PR_MAX NUMBER, 
	FIN NUMBER(*,0), 
	PD NUMBER, 
	LGD NUMBER, 
	LGDV NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_FIN_PD_GRUPA_UL ***
 exec bpa.alter_policies('REZ_FIN_PD_GRUPA_UL');


COMMENT ON TABLE BARS.REZ_FIN_PD_GRUPA_UL IS 'Довідник груп формування резерву';
COMMENT ON COLUMN BARS.REZ_FIN_PD_GRUPA_UL.PR_MIN IS '% забезп. від';
COMMENT ON COLUMN BARS.REZ_FIN_PD_GRUPA_UL.PR_MAX IS '% забезп. до';
COMMENT ON COLUMN BARS.REZ_FIN_PD_GRUPA_UL.FIN IS 'Клас контрагента';
COMMENT ON COLUMN BARS.REZ_FIN_PD_GRUPA_UL.PD IS 'Значення коефіцієнту імовірності дефолту ';
COMMENT ON COLUMN BARS.REZ_FIN_PD_GRUPA_UL.LGD IS 'LGD грн. ';
COMMENT ON COLUMN BARS.REZ_FIN_PD_GRUPA_UL.LGDV IS 'LGD вал. ';



PROMPT *** Create  grants  REZ_FIN_PD_GRUPA_UL ***
grant SELECT                                                                 on REZ_FIN_PD_GRUPA_UL to BARSREADER_ROLE;
grant SELECT                                                                 on REZ_FIN_PD_GRUPA_UL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REZ_FIN_PD_GRUPA_UL to RCC_DEAL;
grant SELECT                                                                 on REZ_FIN_PD_GRUPA_UL to START1;
grant SELECT                                                                 on REZ_FIN_PD_GRUPA_UL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_FIN_PD_GRUPA_UL.sql =========*** E
PROMPT ===================================================================================== 
