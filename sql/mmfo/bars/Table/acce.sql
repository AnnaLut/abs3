

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCE.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ACCE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ACCE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCE 
   (	ACC NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	DIO DATE, 
	HIGH NUMBER, 
	PERS NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCE ***
 exec bpa.alter_policies('ACCE');


COMMENT ON TABLE BARS.ACCE IS 'Счета для отбора в выписки электронным клиентам';
COMMENT ON COLUMN BARS.ACCE.ACC IS '';
COMMENT ON COLUMN BARS.ACCE.KF IS '';
COMMENT ON COLUMN BARS.ACCE.DIO IS 'Дата изменения остатка';
COMMENT ON COLUMN BARS.ACCE.HIGH IS 'Доступ вышестоящим';
COMMENT ON COLUMN BARS.ACCE.PERS IS 'Доступ себе';




PROMPT *** Create  constraint XPK_ACCE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCE ADD CONSTRAINT XPK_ACCE PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCE_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCE ADD CONSTRAINT FK_ACCE_ACCOUNTS FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCE ADD CONSTRAINT FK_ACCE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCE MODIFY (KF CONSTRAINT CC_ACCE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ACCE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ACCE ON BARS.ACCE (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCE ***
grant DELETE,INSERT,SELECT                                                   on ACCE            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCE            to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on ACCE            to OPERKKK;
grant DELETE,INSERT,SELECT                                                   on ACCE            to TECH_MOM1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACCE            to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to ACCE ***

  CREATE OR REPLACE PUBLIC SYNONYM ACCE FOR BARS.ACCE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCE.sql =========*** End *** ========
PROMPT ===================================================================================== 
