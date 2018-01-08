

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_TRANS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_TRANS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_TRANS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_TRANS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CC_TRANS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_TRANS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_TRANS 
   (	NPP NUMBER(*,0), 
	REF NUMBER(*,0), 
	ACC NUMBER(*,0), 
	FDAT DATE, 
	SV NUMBER, 
	SZ NUMBER, 
	D_PLAN DATE, 
	D_FAKT DATE, 
	DAPP DATE, 
	REFP NUMBER(*,0), 
	COMM VARCHAR2(100), 
	ID0 NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_TRANS ***
 exec bpa.alter_policies('CC_TRANS');


COMMENT ON TABLE BARS.CC_TRANS IS 'Транши выдачи кредита';
COMMENT ON COLUMN BARS.CC_TRANS.NPP IS '№ пп - первичный ключ';
COMMENT ON COLUMN BARS.CC_TRANS.REF IS 'Реф.операции выдачи';
COMMENT ON COLUMN BARS.CC_TRANS.ACC IS 'ACC счета SS';
COMMENT ON COLUMN BARS.CC_TRANS.FDAT IS 'Дата выдачи';
COMMENT ON COLUMN BARS.CC_TRANS.SV IS 'Сумма факт.выдачи';
COMMENT ON COLUMN BARS.CC_TRANS.SZ IS 'Сумма факт.погашення';
COMMENT ON COLUMN BARS.CC_TRANS.D_PLAN IS 'План-дата погашения';
COMMENT ON COLUMN BARS.CC_TRANS.D_FAKT IS 'Факт-дата погашения';
COMMENT ON COLUMN BARS.CC_TRANS.DAPP IS 'Дата последнего разбора';
COMMENT ON COLUMN BARS.CC_TRANS.REFP IS 'Реф.погашения';
COMMENT ON COLUMN BARS.CC_TRANS.COMM IS 'Комментарий';
COMMENT ON COLUMN BARS.CC_TRANS.ID0 IS 'Iд.Поч.Траншу(Ід.)';
COMMENT ON COLUMN BARS.CC_TRANS.KF IS '';




PROMPT *** Create  constraint PK_CCTRANS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_TRANS ADD CONSTRAINT PK_CCTRANS PRIMARY KEY (NPP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCTRANS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_TRANS MODIFY (KF CONSTRAINT CC_CCTRANS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCTRANS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_TRANS ADD CONSTRAINT FK_CCTRANS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCTRANS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCTRANS ON BARS.CC_TRANS (NPP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_CCTRANS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_CCTRANS ON BARS.CC_TRANS (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_TRANS ***
grant SELECT                                                                 on CC_TRANS        to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_TRANS        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_TRANS        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_TRANS        to RCC_DEAL;
grant FLASHBACK,SELECT                                                       on CC_TRANS        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_TRANS.sql =========*** End *** ====
PROMPT ===================================================================================== 
