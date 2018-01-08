

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCC.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ACCC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ACCC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCC ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCC 
   (	ACC NUMBER(38,0), 
	HIGH NUMBER, 
	PERS NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCC ***
 exec bpa.alter_policies('ACCC');


COMMENT ON TABLE BARS.ACCC IS 'Справочник для отбора файлов состояний C';
COMMENT ON COLUMN BARS.ACCC.ACC IS '';
COMMENT ON COLUMN BARS.ACCC.HIGH IS 'Отбор вышестоящим';
COMMENT ON COLUMN BARS.ACCC.PERS IS 'Отбор клиенту';
COMMENT ON COLUMN BARS.ACCC.KF IS '';




PROMPT *** Create  constraint FK_ACCC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCC ADD CONSTRAINT FK_ACCC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCC_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCC ADD CONSTRAINT FK_ACCC_ACCOUNTS FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCC MODIFY (KF CONSTRAINT CC_ACCC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_ACCC ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCC ADD CONSTRAINT XPK_ACCC PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ACCС ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ACCС ON BARS.ACCC (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCC            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCC            to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on ACCC            to OPERKKK;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCC            to TECH_MOM1;



PROMPT *** Create SYNONYM  to ACCC ***

  CREATE OR REPLACE PUBLIC SYNONYM ACCC FOR BARS.ACCC;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCC.sql =========*** End *** ========
PROMPT ===================================================================================== 
