

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_OBS_KAT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_OBS_KAT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_OBS_KAT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_OBS_KAT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_OBS_KAT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_OBS_KAT ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_OBS_KAT 
   (	CUS NUMBER(*,0), 
	FIN NUMBER(38,0), 
	OBS NUMBER(38,0), 
	KAT NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_OBS_KAT ***
 exec bpa.alter_policies('FIN_OBS_KAT');


COMMENT ON TABLE BARS.FIN_OBS_KAT IS 'НБУ-23/4.ТАБЛИЦЯ для вирахування Категорiя якостi';
COMMENT ON COLUMN BARS.FIN_OBS_KAT.CUS IS 'НБУ-23/0.Тип кл(1,2,3) ';
COMMENT ON COLUMN BARS.FIN_OBS_KAT.FIN IS 'НБУ-23/1.ФiнКлас ';
COMMENT ON COLUMN BARS.FIN_OBS_KAT.OBS IS 'НБУ-23/2.Обсл.боргу';
COMMENT ON COLUMN BARS.FIN_OBS_KAT.KAT IS 'НБУ-23/3.Категорiя якостi';




PROMPT *** Create  constraint PK_FINOBSKAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBS_KAT ADD CONSTRAINT PK_FINOBSKAT PRIMARY KEY (CUS, FIN, OBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FINOBSKAT_CUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBS_KAT MODIFY (CUS CONSTRAINT CC_FINOBSKAT_CUS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FINOBSKAT_FIN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBS_KAT MODIFY (FIN CONSTRAINT CC_FINOBSKAT_FIN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FINOBSKAT_OBS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBS_KAT MODIFY (OBS CONSTRAINT CC_FINOBSKAT_OBS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FINOBSKAT_KAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBS_KAT MODIFY (KAT CONSTRAINT CC_FINOBSKAT_KAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FINOBSKAT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FINOBSKAT ON BARS.FIN_OBS_KAT (CUS, FIN, OBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_OBS_KAT ***
grant SELECT                                                                 on FIN_OBS_KAT     to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_OBS_KAT     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_OBS_KAT     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_OBS_KAT     to START1;
grant SELECT                                                                 on FIN_OBS_KAT     to UPLD;
grant FLASHBACK,SELECT                                                       on FIN_OBS_KAT     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_OBS_KAT.sql =========*** End *** =
PROMPT ===================================================================================== 
