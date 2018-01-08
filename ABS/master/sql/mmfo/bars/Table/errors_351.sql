

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERRORS_351.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERRORS_351 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ERRORS_351'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ERRORS_351'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERRORS_351 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERRORS_351 
   (	FDAT DATE, 
	ND NUMBER(*,0), 
	ID NUMBER(*,0), 
	CUSTTYPE NUMBER(*,0), 
	BRANCH VARCHAR2(30), 
	ACC NUMBER(*,0), 
	RNK NUMBER(*,0), 
	NLS VARCHAR2(15), 
	KV NUMBER(3,0), 
	TIP NUMBER(*,0), 
	ERROR_TXT VARCHAR2(1000), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERRORS_351 ***
 exec bpa.alter_policies('ERRORS_351');


COMMENT ON TABLE BARS.ERRORS_351 IS 'Помилки при розрахунку кредитного ризику по 351 Постанові';
COMMENT ON COLUMN BARS.ERRORS_351.FDAT IS 'Звітна дата';
COMMENT ON COLUMN BARS.ERRORS_351.ND IS 'Реф.договора';
COMMENT ON COLUMN BARS.ERRORS_351.ID IS 'Номер користувача';
COMMENT ON COLUMN BARS.ERRORS_351.CUSTTYPE IS 'Тип клиента';
COMMENT ON COLUMN BARS.ERRORS_351.BRANCH IS 'Бранч';
COMMENT ON COLUMN BARS.ERRORS_351.ACC IS 'Внутр. номер рахунку';
COMMENT ON COLUMN BARS.ERRORS_351.RNK IS 'РНК ';
COMMENT ON COLUMN BARS.ERRORS_351.NLS IS 'Номер рахунку';
COMMENT ON COLUMN BARS.ERRORS_351.KV IS 'Код валюти';
COMMENT ON COLUMN BARS.ERRORS_351.TIP IS 'Тип помилки';
COMMENT ON COLUMN BARS.ERRORS_351.ERROR_TXT IS 'Текст  помилки';
COMMENT ON COLUMN BARS.ERRORS_351.KF IS '';




PROMPT *** Create  constraint PK_ERRORS_351 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ERRORS_351 ADD CONSTRAINT PK_ERRORS_351 PRIMARY KEY (FDAT, ND, RNK, TIP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ERRORS351_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ERRORS_351 MODIFY (KF CONSTRAINT CC_ERRORS351_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ERRORS_351 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ERRORS_351 ON BARS.ERRORS_351 (FDAT, ND, RNK, TIP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ERRORS_351 ***
grant SELECT                                                                 on ERRORS_351      to BARSREADER_ROLE;
grant SELECT                                                                 on ERRORS_351      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ERRORS_351      to RCC_DEAL;
grant SELECT                                                                 on ERRORS_351      to START1;
grant SELECT                                                                 on ERRORS_351      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERRORS_351.sql =========*** End *** ==
PROMPT ===================================================================================== 
