

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_ND_HIST.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_ND_HIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_ND_HIST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_ND_HIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_ND_HIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_ND_HIST 
   (	FDAT DATE, 
	IDF NUMBER(38,0), 
	KOD VARCHAR2(4), 
	S NUMBER(24,3), 
	ND NUMBER, 
	RNK NUMBER(*,0), 
	VAL_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_ND_HIST ***
 exec bpa.alter_policies('FIN_ND_HIST');


COMMENT ON TABLE BARS.FIN_ND_HIST IS 'Фiн.звiти клiєнтiв';
COMMENT ON COLUMN BARS.FIN_ND_HIST.FDAT IS 'Дата звiту';
COMMENT ON COLUMN BARS.FIN_ND_HIST.IDF IS 'Форма';
COMMENT ON COLUMN BARS.FIN_ND_HIST.KOD IS 'Код рядка';
COMMENT ON COLUMN BARS.FIN_ND_HIST.S IS 'Показник поточний';
COMMENT ON COLUMN BARS.FIN_ND_HIST.ND IS 'Реф КД';
COMMENT ON COLUMN BARS.FIN_ND_HIST.RNK IS '';
COMMENT ON COLUMN BARS.FIN_ND_HIST.VAL_DATE IS 'Дата';




PROMPT *** Create  constraint XPK_FIN_ND_HIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_ND_HIST ADD CONSTRAINT XPK_FIN_ND_HIST PRIMARY KEY (RNK, ND, IDF, KOD, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FIN_ND_HIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FIN_ND_HIST ON BARS.FIN_ND_HIST (RNK, ND, IDF, KOD, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_ND_HIST ***
grant SELECT                                                                 on FIN_ND_HIST     to BARSREADER_ROLE;
grant INSERT,SELECT,UPDATE                                                   on FIN_ND_HIST     to BARS_ACCESS_DEFROLE;
grant INSERT,SELECT,UPDATE                                                   on FIN_ND_HIST     to START1;
grant SELECT                                                                 on FIN_ND_HIST     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_ND_HIST.sql =========*** End *** =
PROMPT ===================================================================================== 
