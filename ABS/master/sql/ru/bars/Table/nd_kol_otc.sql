PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARS/Table/ND_KOL_OTC.sql =======*** Run *** ======
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to ND_KOL_OTC ***

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ND_KOL_OTC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ND_KOL_OTC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ND_KOL_OTC ***
begin 
  execute immediate '
  CREATE TABLE BARS.ND_KOL_OTC 
   (	RNK NUMBER(*,0), 
	ND NUMBER(*,0), 
	FDAT DATE, 
	DOS NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ND_KOL_OTC ***
 exec bpa.alter_policies('ND_KOL_OTC');


COMMENT ON TABLE BARS.ND_KOL_OTC IS 'таблица просроченных задолженностей';
COMMENT ON COLUMN BARS.ND_KOL_OTC.RNK IS 'РНК';
COMMENT ON COLUMN BARS.ND_KOL_OTC.ND IS 'Реф.договора';
COMMENT ON COLUMN BARS.ND_KOL_OTC.FDAT IS 'Звітна дата';
COMMENT ON COLUMN BARS.ND_KOL_OTC.DOS IS 'Непогашенний оборот';
COMMENT ON COLUMN BARS.ND_KOL_OTC.KF IS '';




PROMPT *** Create  constraint PK_ND_KOL_OTC ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_KOL_OTC ADD CONSTRAINT PK_ND_KOL_OTC PRIMARY KEY (ND, RNK, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NDKOL_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_KOL_OTC MODIFY (KF CONSTRAINT CC_NDKOLOTC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NDKOL_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_KOL_OTC ADD CONSTRAINT FK_NDKOLOTC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index PK_ND_KOL_OTC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ND_KOL_OTC ON BARS.ND_KOL_OTC (ND, RNK, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ND_KOL_OTC ***
grant SELECT                                                                 on ND_KOL_OTC          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ND_KOL_OTC          to RCC_DEAL;
grant SELECT                                                                 on ND_KOL_OTC          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/Table/ND_KOL_OTC.sql =======*** End *** ======
PROMPT ===================================================================================== 
