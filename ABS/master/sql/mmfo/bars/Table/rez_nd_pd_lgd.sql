

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_ND_PD_LGD.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_ND_PD_LGD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_ND_PD_LGD'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''REZ_ND_PD_LGD'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_ND_PD_LGD ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_ND_PD_LGD 
   (	FDAT DATE, 
	RNK NUMBER(*,0), 
	ND NUMBER(*,0), 
	FIN NUMBER(*,0), 
	PD NUMBER, 
	LGD NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_ND_PD_LGD ***
 exec bpa.alter_policies('REZ_ND_PD_LGD');


COMMENT ON TABLE BARS.REZ_ND_PD_LGD IS 'Таблиця змін';
COMMENT ON COLUMN BARS.REZ_ND_PD_LGD.FDAT IS 'Звітна дата';
COMMENT ON COLUMN BARS.REZ_ND_PD_LGD.RNK IS 'РНК Клієнта';
COMMENT ON COLUMN BARS.REZ_ND_PD_LGD.ND IS 'Реф.договору';
COMMENT ON COLUMN BARS.REZ_ND_PD_LGD.FIN IS 'Клас контрагента';
COMMENT ON COLUMN BARS.REZ_ND_PD_LGD.PD IS 'Значення коефіцієнту імовірності дефолту ';
COMMENT ON COLUMN BARS.REZ_ND_PD_LGD.LGD IS 'LGD';
COMMENT ON COLUMN BARS.REZ_ND_PD_LGD.KF IS '';




PROMPT *** Create  constraint CC_REZNDPDLGD_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_ND_PD_LGD MODIFY (KF CONSTRAINT CC_REZNDPDLGD_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_REZ_ND_PD_LGD ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_REZ_ND_PD_LGD ON BARS.REZ_ND_PD_LGD (FDAT, RNK, ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REZ_ND_PD_LGD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on REZ_ND_PD_LGD   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on REZ_ND_PD_LGD   to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on REZ_ND_PD_LGD   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_ND_PD_LGD.sql =========*** End ***
PROMPT ===================================================================================== 
