

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_LOG.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_LOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_LOG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_LOG'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OTCN_LOG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_LOG 
   (	ID NUMBER, 
	TXT VARCHAR2(200), 
	KODF VARCHAR2(2), 
	USERID NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_LOG ***
 exec bpa.alter_policies('OTCN_LOG');


COMMENT ON TABLE BARS.OTCN_LOG IS 'Таблица для формирования контрольных точек (проверок) файлов отчетности';
COMMENT ON COLUMN BARS.OTCN_LOG.ID IS '';
COMMENT ON COLUMN BARS.OTCN_LOG.TXT IS '';
COMMENT ON COLUMN BARS.OTCN_LOG.KODF IS '';
COMMENT ON COLUMN BARS.OTCN_LOG.USERID IS '';
COMMENT ON COLUMN BARS.OTCN_LOG.KF IS '';




PROMPT *** Create  constraint PK_OTCN_LOG ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_LOG ADD CONSTRAINT PK_OTCN_LOG PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009903 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_LOG MODIFY (ID NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OTCNLOG_KODF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_LOG MODIFY (KODF CONSTRAINT CC_OTCNLOG_KODF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OTCNLOG_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_LOG MODIFY (USERID CONSTRAINT CC_OTCNLOG_USERID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OTCNLOG_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_LOG MODIFY (KF CONSTRAINT CC_OTCNLOG_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OTCN_LOG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OTCN_LOG ON BARS.OTCN_LOG (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_LOG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_LOG        to ABS_ADMIN;
grant SELECT                                                                 on OTCN_LOG        to BARSREADER_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on OTCN_LOG        to BARS_ACCESS_DEFROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on OTCN_LOG        to RPBN002;
grant SELECT                                                                 on OTCN_LOG        to START1;
grant SELECT                                                                 on OTCN_LOG        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTCN_LOG        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_LOG.sql =========*** End *** ====
PROMPT ===================================================================================== 
