

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_ND.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_ND ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_ND'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_ND'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''FIN_ND'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_ND ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_ND 
   (	FDAT DATE, 
	IDF NUMBER(38,0), 
	KOD VARCHAR2(4), 
	S NUMBER(24,3), 
	ND NUMBER, 
	RNK NUMBER(*,0), 
	VAL_DATE DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_ND ***
 exec bpa.alter_policies('FIN_ND');


COMMENT ON TABLE BARS.FIN_ND IS 'Фiн.звiти клiєнтiв';
COMMENT ON COLUMN BARS.FIN_ND.FDAT IS 'Дата звiту';
COMMENT ON COLUMN BARS.FIN_ND.IDF IS 'Форма';
COMMENT ON COLUMN BARS.FIN_ND.KOD IS 'Код рядка';
COMMENT ON COLUMN BARS.FIN_ND.S IS 'Показник поточний';
COMMENT ON COLUMN BARS.FIN_ND.ND IS 'Реф КД';
COMMENT ON COLUMN BARS.FIN_ND.RNK IS '';
COMMENT ON COLUMN BARS.FIN_ND.VAL_DATE IS 'Дата';
COMMENT ON COLUMN BARS.FIN_ND.KF IS '';




PROMPT *** Create  constraint FK_FINND_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_ND ADD CONSTRAINT FK_FINND_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FINND_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_ND MODIFY (KF CONSTRAINT CC_FINND_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_FIN_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_ND ADD CONSTRAINT XPK_FIN_ND PRIMARY KEY (RNK, ND, IDF, KOD, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FIN_ND ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FIN_ND ON BARS.FIN_ND (RNK, ND, IDF, KOD, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_ND ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_ND          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_ND          to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_ND          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_ND.sql =========*** End *** ======
PROMPT ===================================================================================== 
