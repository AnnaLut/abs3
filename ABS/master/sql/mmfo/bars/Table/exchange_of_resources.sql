

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EXCHANGE_OF_RESOURCES.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EXCHANGE_OF_RESOURCES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EXCHANGE_OF_RESOURCES'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''EXCHANGE_OF_RESOURCES'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''EXCHANGE_OF_RESOURCES'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EXCHANGE_OF_RESOURCES ***
begin 
  execute immediate '
  CREATE TABLE BARS.EXCHANGE_OF_RESOURCES 
   (	MFO VARCHAR2(6), 
	NLS2 VARCHAR2(14), 
	NLS_3902 VARCHAR2(14), 
	NLS_3903 VARCHAR2(14), 
	NLS_CCK_SOURCE VARCHAR2(14), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EXCHANGE_OF_RESOURCES ***
 exec bpa.alter_policies('EXCHANGE_OF_RESOURCES');


COMMENT ON TABLE BARS.EXCHANGE_OF_RESOURCES IS '';
COMMENT ON COLUMN BARS.EXCHANGE_OF_RESOURCES.MFO IS '';
COMMENT ON COLUMN BARS.EXCHANGE_OF_RESOURCES.NLS2 IS '';
COMMENT ON COLUMN BARS.EXCHANGE_OF_RESOURCES.NLS_3902 IS '';
COMMENT ON COLUMN BARS.EXCHANGE_OF_RESOURCES.NLS_3903 IS '';
COMMENT ON COLUMN BARS.EXCHANGE_OF_RESOURCES.NLS_CCK_SOURCE IS 'Транзит 3739 для кредитных ресурсов';
COMMENT ON COLUMN BARS.EXCHANGE_OF_RESOURCES.KF IS '';




PROMPT *** Create  constraint PK_EXCHANGEOFRESOURCES ***
begin   
 execute immediate '
  ALTER TABLE BARS.EXCHANGE_OF_RESOURCES ADD CONSTRAINT PK_EXCHANGEOFRESOURCES PRIMARY KEY (KF, MFO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EXCHANGEOFRESOURCES_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EXCHANGE_OF_RESOURCES MODIFY (KF CONSTRAINT CC_EXCHANGEOFRESOURCES_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_EXCHANGEOFRESOURCES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EXCHANGEOFRESOURCES ON BARS.EXCHANGE_OF_RESOURCES (KF, MFO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EXCHANGE_OF_RESOURCES ***
grant SELECT                                                                 on EXCHANGE_OF_RESOURCES to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on EXCHANGE_OF_RESOURCES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EXCHANGE_OF_RESOURCES to BARS_DM;
grant SELECT                                                                 on EXCHANGE_OF_RESOURCES to CDB;
grant DELETE,INSERT,SELECT,UPDATE                                            on EXCHANGE_OF_RESOURCES to START1;
grant SELECT                                                                 on EXCHANGE_OF_RESOURCES to UPLD;



PROMPT *** Create SYNONYM  to EXCHANGE_OF_RESOURCES ***

  CREATE OR REPLACE SYNONYM CDB.BARS_EXCH_OF_RESOURCES FOR BARS.EXCHANGE_OF_RESOURCES;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EXCHANGE_OF_RESOURCES.sql =========***
PROMPT ===================================================================================== 
