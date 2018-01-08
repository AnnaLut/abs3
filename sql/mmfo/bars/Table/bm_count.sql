

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BM_COUNT.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BM_COUNT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BM_COUNT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BM_COUNT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BM_COUNT ***
begin 
  execute immediate '
  CREATE TABLE BARS.BM_COUNT 
   (	ACC NUMBER, 
	KOD VARCHAR2(10), 
	FDAT DATE, 
	C_INP NUMBER(*,0), 
	DOS0 NUMBER(*,0), 
	DOS1 NUMBER(*,0), 
	KOS1 NUMBER(*,0), 
	KOS0 NUMBER(*,0), 
	C_OUT NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BM_COUNT ***
 exec bpa.alter_policies('BM_COUNT');


COMMENT ON TABLE BARS.BM_COUNT IS 'Сальдовка по виробам з БМ - кількісний облік';
COMMENT ON COLUMN BARS.BM_COUNT.ACC IS 'Касовий рахунок';
COMMENT ON COLUMN BARS.BM_COUNT.KOD IS 'Код виробу';
COMMENT ON COLUMN BARS.BM_COUNT.FDAT IS 'Банк.дата';
COMMENT ON COLUMN BARS.BM_COUNT.C_INP IS 'вх.сальдо';
COMMENT ON COLUMN BARS.BM_COUNT.DOS0 IS 'Надійшло';
COMMENT ON COLUMN BARS.BM_COUNT.DOS1 IS 'Куплено';
COMMENT ON COLUMN BARS.BM_COUNT.KOS1 IS 'Продано';
COMMENT ON COLUMN BARS.BM_COUNT.KOS0 IS 'Видано';
COMMENT ON COLUMN BARS.BM_COUNT.C_OUT IS 'Вих.сальдо';




PROMPT *** Create  constraint XPK_BMCOUNT ***
begin   
 execute immediate '
  ALTER TABLE BARS.BM_COUNT ADD CONSTRAINT XPK_BMCOUNT PRIMARY KEY (ACC, KOD, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_BMCOUNT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_BMCOUNT ON BARS.BM_COUNT (ACC, KOD, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BM_COUNT ***
grant SELECT                                                                 on BM_COUNT        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BM_COUNT.sql =========*** End *** ====
PROMPT ===================================================================================== 
