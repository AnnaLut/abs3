

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_DEB_23.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_DEB_23 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC_DEB_23'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACC_DEB_23'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACC_DEB_23'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_DEB_23 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_DEB_23 
   (	ACC NUMBER, 
	FIN NUMBER(*,0), 
	OBS NUMBER(*,0), 
	KAT NUMBER(*,0), 
	K NUMBER, 
	SERR VARCHAR2(100), 
	D_P DATE, 
	D_V DATE, 
	KOL_P NUMBER(*,0), 
	KOL_VZ NUMBER(*,0), 
	RNK NUMBER, 
	DAT DATE, 
	DEB NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_DEB_23 ***
 exec bpa.alter_policies('ACC_DEB_23');


COMMENT ON TABLE BARS.ACC_DEB_23 IS 'НБУ-23.Параметри для рах.дебзаборг';
COMMENT ON COLUMN BARS.ACC_DEB_23.ACC IS '';
COMMENT ON COLUMN BARS.ACC_DEB_23.FIN IS 'НБУ-23/1.ФiнКлас ';
COMMENT ON COLUMN BARS.ACC_DEB_23.OBS IS 'НБУ-23/2.Обсл.боргу';
COMMENT ON COLUMN BARS.ACC_DEB_23.KAT IS 'НБУ-23/3.Категорiя якостi';
COMMENT ON COLUMN BARS.ACC_DEB_23.K IS '';
COMMENT ON COLUMN BARS.ACC_DEB_23.SERR IS '';
COMMENT ON COLUMN BARS.ACC_DEB_23.D_P IS '';
COMMENT ON COLUMN BARS.ACC_DEB_23.D_V IS '';
COMMENT ON COLUMN BARS.ACC_DEB_23.KOL_P IS '';
COMMENT ON COLUMN BARS.ACC_DEB_23.KOL_VZ IS '';
COMMENT ON COLUMN BARS.ACC_DEB_23.RNK IS '';
COMMENT ON COLUMN BARS.ACC_DEB_23.DAT IS '';
COMMENT ON COLUMN BARS.ACC_DEB_23.DEB IS 'Признак дебиторки:0-фин.1-хоз.';




PROMPT *** Create  constraint PK_ACCDEB23 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_DEB_23 ADD CONSTRAINT PK_ACCDEB23 PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCDEB23_KAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_DEB_23 ADD CONSTRAINT FK_ACCDEB23_KAT FOREIGN KEY (KAT)
	  REFERENCES BARS.STAN_KAT23 (KAT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCDEB23_OBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_DEB_23 ADD CONSTRAINT FK_ACCDEB23_OBS FOREIGN KEY (OBS)
	  REFERENCES BARS.STAN_OBS23 (OBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCDEB23_FIN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_DEB_23 ADD CONSTRAINT FK_ACCDEB23_FIN FOREIGN KEY (FIN)
	  REFERENCES BARS.STAN_FIN23 (FIN) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCDEB23 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCDEB23 ON BARS.ACC_DEB_23 (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACC_DEB_23 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_DEB_23      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_DEB_23      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_DEB_23      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_DEB_23.sql =========*** End *** ==
PROMPT ===================================================================================== 
