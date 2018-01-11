

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_PAR_9200.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_PAR_9200 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_PAR_9200'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''REZ_PAR_9200'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_PAR_9200 ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_PAR_9200 
   (	RNK NUMBER(*,0), 
	ND NUMBER(*,0), 
	FIN NUMBER, 
	VKR VARCHAR2(3), 
	PD NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	COMM VARCHAR2(254), 
	FDAT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_PAR_9200 ***
 exec bpa.alter_policies('REZ_PAR_9200');


COMMENT ON TABLE BARS.REZ_PAR_9200 IS 'Параметри рахунків';
COMMENT ON COLUMN BARS.REZ_PAR_9200.KF IS '';
COMMENT ON COLUMN BARS.REZ_PAR_9200.COMM IS 'Підстава';
COMMENT ON COLUMN BARS.REZ_PAR_9200.FDAT IS 'Звітна дата';
COMMENT ON COLUMN BARS.REZ_PAR_9200.RNK IS 'РНК';
COMMENT ON COLUMN BARS.REZ_PAR_9200.ND IS 'Реф договора';
COMMENT ON COLUMN BARS.REZ_PAR_9200.FIN IS 'Клас контрагента';
COMMENT ON COLUMN BARS.REZ_PAR_9200.VKR IS 'ВКР';
COMMENT ON COLUMN BARS.REZ_PAR_9200.PD IS 'Значення коефіцієнту імовірності дефолту ';




PROMPT *** Create  constraint PK_REZ_PAR_9200 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_PAR_9200 ADD CONSTRAINT PK_REZ_PAR_9200 PRIMARY KEY (FDAT, RNK, ND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REZPAR9200_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_PAR_9200 MODIFY (KF CONSTRAINT CC_REZPAR9200_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REZ_PAR_9200 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REZ_PAR_9200 ON BARS.REZ_PAR_9200 (FDAT, RNK, ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REZ_PAR_9200 ***
grant SELECT                                                                 on REZ_PAR_9200    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REZ_PAR_9200    to RCC_DEAL;
grant SELECT                                                                 on REZ_PAR_9200    to START1;
grant SELECT                                                                 on REZ_PAR_9200    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_PAR_9200.sql =========*** End *** 
PROMPT ===================================================================================== 
