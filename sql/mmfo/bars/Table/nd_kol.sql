

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ND_KOL.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ND_KOL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ND_KOL'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ND_KOL'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ND_KOL ***
begin 
  execute immediate '
  CREATE TABLE BARS.ND_KOL 
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




PROMPT *** ALTER_POLICIES to ND_KOL ***
 exec bpa.alter_policies('ND_KOL');


COMMENT ON TABLE BARS.ND_KOL IS 'таблица просроченных задолженностей';
COMMENT ON COLUMN BARS.ND_KOL.RNK IS 'РНК';
COMMENT ON COLUMN BARS.ND_KOL.ND IS 'Реф.договора';
COMMENT ON COLUMN BARS.ND_KOL.FDAT IS 'Звітна дата';
COMMENT ON COLUMN BARS.ND_KOL.DOS IS 'Непогашенний оборот';
COMMENT ON COLUMN BARS.ND_KOL.KF IS '';




PROMPT *** Create  constraint PK_ND_KOL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_KOL ADD CONSTRAINT PK_ND_KOL PRIMARY KEY (ND, RNK, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NDKOL_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_KOL MODIFY (KF CONSTRAINT CC_NDKOL_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NDKOL_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_KOL ADD CONSTRAINT FK_NDKOL_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ND_KOL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ND_KOL ON BARS.ND_KOL (ND, RNK, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ND_KOL ***
grant SELECT                                                                 on ND_KOL          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ND_KOL          to RCC_DEAL;
grant SELECT                                                                 on ND_KOL          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ND_KOL.sql =========*** End *** ======
PROMPT ===================================================================================== 
