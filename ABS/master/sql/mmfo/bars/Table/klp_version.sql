

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KLP_VERSION.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KLP_VERSION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KLP_VERSION'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KLP_VERSION'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KLP_VERSION'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KLP_VERSION ***
begin 
  execute immediate '
  CREATE TABLE BARS.KLP_VERSION 
   (	RNK NUMBER, 
	VERSION VARCHAR2(15), 
	FILEE NUMBER(1,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KLP_VERSION ***
 exec bpa.alter_policies('KLP_VERSION');


COMMENT ON TABLE BARS.KLP_VERSION IS 'Версии Клиент-банк';
COMMENT ON COLUMN BARS.KLP_VERSION.RNK IS 'Рег.№ клиента';
COMMENT ON COLUMN BARS.KLP_VERSION.VERSION IS 'Версия программы Клиент-банк в формате NN.nn';
COMMENT ON COLUMN BARS.KLP_VERSION.FILEE IS 'Формирование файла E (1-да,0-нет)';
COMMENT ON COLUMN BARS.KLP_VERSION.KF IS '';




PROMPT *** Create  constraint CC_KLPVERSION_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_VERSION MODIFY (KF CONSTRAINT CC_KLPVERSION_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_KLPVERSION ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_VERSION ADD CONSTRAINT PK_KLPVERSION PRIMARY KEY (KF, RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KLPVERSION ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KLPVERSION ON BARS.KLP_VERSION (KF, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KLP_VERSION ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KLP_VERSION ON BARS.KLP_VERSION (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KLP_VERSION ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KLP_VERSION     to ABS_ADMIN;
grant SELECT                                                                 on KLP_VERSION     to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KLP_VERSION     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KLP_VERSION     to BARS_DM;
grant SELECT                                                                 on KLP_VERSION     to OPERKKK;
grant DELETE,INSERT,SELECT,UPDATE                                            on KLP_VERSION     to REF0000;
grant SELECT                                                                 on KLP_VERSION     to TECH_MOM1;
grant SELECT                                                                 on KLP_VERSION     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KLP_VERSION     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on KLP_VERSION     to WR_REFREAD;



PROMPT *** Create SYNONYM  to KLP_VERSION ***

  CREATE OR REPLACE PUBLIC SYNONYM KLP_VERSION FOR BARS.KLP_VERSION;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KLP_VERSION.sql =========*** End *** =
PROMPT ===================================================================================== 
