

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KLP_ZVIDM.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KLP_ZVIDM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KLP_ZVIDM'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KLP_ZVIDM'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KLP_ZVIDM'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KLP_ZVIDM ***
begin 
  execute immediate '
  CREATE TABLE BARS.KLP_ZVIDM 
   (	ID NUMBER, 
	FL NUMBER, 
	NAMEF VARCHAR2(12), 
	FIO1 VARCHAR2(96), 
	FIO2 VARCHAR2(96), 
	PS_NUMBER1 VARCHAR2(96), 
	PS_NUMBER2 VARCHAR2(96), 
	PS_DATE VARCHAR2(16), 
	PS_TYPE VARCHAR2(32), 
	PS_SUMMA VARCHAR2(96), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KLP_ZVIDM ***
 exec bpa.alter_policies('KLP_ZVIDM');


COMMENT ON TABLE BARS.KLP_ZVIDM IS 'Документообіг - Заява на відміну заяви';
COMMENT ON COLUMN BARS.KLP_ZVIDM.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.KLP_ZVIDM.FL IS 'Флаг обработки';
COMMENT ON COLUMN BARS.KLP_ZVIDM.NAMEF IS '';
COMMENT ON COLUMN BARS.KLP_ZVIDM.FIO1 IS '';
COMMENT ON COLUMN BARS.KLP_ZVIDM.FIO2 IS '';
COMMENT ON COLUMN BARS.KLP_ZVIDM.PS_NUMBER1 IS 'Заява N%';
COMMENT ON COLUMN BARS.KLP_ZVIDM.PS_NUMBER2 IS 'N% заяви, що відмінюється';
COMMENT ON COLUMN BARS.KLP_ZVIDM.PS_DATE IS 'Дата заяви, що відмінюється';
COMMENT ON COLUMN BARS.KLP_ZVIDM.PS_TYPE IS 'Заява, що відмінюється (на)';
COMMENT ON COLUMN BARS.KLP_ZVIDM.PS_SUMMA IS 'Сума заяви, що відмінюється';
COMMENT ON COLUMN BARS.KLP_ZVIDM.KF IS '';




PROMPT *** Create  constraint KLP_ZVIDM_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ZVIDM ADD CONSTRAINT KLP_ZVIDM_PK PRIMARY KEY (ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLPZVIDM_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ZVIDM ADD CONSTRAINT FK_KLPZVIDM_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLPZVIDM_FL ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ZVIDM ADD CONSTRAINT FK_KLPZVIDM_FL FOREIGN KEY (FL)
	  REFERENCES BARS.KLP_FL (FL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPZVIDM_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ZVIDM MODIFY (KF CONSTRAINT CC_KLPZVIDM_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index KLP_ZVIDM_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.KLP_ZVIDM_PK ON BARS.KLP_ZVIDM (ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KLP_ZVIDM ***
grant SELECT                                                                 on KLP_ZVIDM       to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on KLP_ZVIDM       to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on KLP_ZVIDM       to PYOD001;
grant DELETE,INSERT,SELECT,UPDATE                                            on KLP_ZVIDM       to TECH_MOM1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KLP_ZVIDM.sql =========*** End *** ===
PROMPT ===================================================================================== 
