

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FM_REF_QUE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FM_REF_QUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FM_REF_QUE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''FM_REF_QUE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''FM_REF_QUE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FM_REF_QUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.FM_REF_QUE 
   (	REF NUMBER, 
	OTM NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FM_REF_QUE ***
 exec bpa.alter_policies('FM_REF_QUE');


COMMENT ON TABLE BARS.FM_REF_QUE IS 'ФМ. Приостановленные документы';
COMMENT ON COLUMN BARS.FM_REF_QUE.REF IS 'Референс документа';
COMMENT ON COLUMN BARS.FM_REF_QUE.OTM IS 'Признак: 1-оплата приостановлена, 0-снят признак блокировки';
COMMENT ON COLUMN BARS.FM_REF_QUE.KF IS '';




PROMPT *** Create  constraint NK_FM_REF_QUE_REF ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_REF_QUE MODIFY (REF CONSTRAINT NK_FM_REF_QUE_REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FM_REF_QUE_OTM ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_REF_QUE MODIFY (OTM CONSTRAINT NK_FM_REF_QUE_OTM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FMREFQUE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_REF_QUE MODIFY (KF CONSTRAINT CC_FMREFQUE_KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_FM_REF_QUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_REF_QUE ADD CONSTRAINT XPK_FM_REF_QUE PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FM_REF_QUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FM_REF_QUE ON BARS.FM_REF_QUE (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FM_REF_QUE ***
grant SELECT                                                                 on FM_REF_QUE      to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on FM_REF_QUE      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FM_REF_QUE      to BARS_DM;
grant SELECT                                                                 on FM_REF_QUE      to UPLD;



PROMPT *** Create SYNONYM  to FM_REF_QUE ***

  CREATE OR REPLACE PUBLIC SYNONYM FM_REF_QUE FOR BARS.FM_REF_QUE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FM_REF_QUE.sql =========*** End *** ==
PROMPT ===================================================================================== 
