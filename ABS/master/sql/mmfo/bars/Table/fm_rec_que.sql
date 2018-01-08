

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FM_REC_QUE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FM_REC_QUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FM_REC_QUE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''FM_REC_QUE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''FM_REC_QUE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FM_REC_QUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.FM_REC_QUE 
   (	REC NUMBER(38,0), 
	OTM NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FM_REC_QUE ***
 exec bpa.alter_policies('FM_REC_QUE');


COMMENT ON TABLE BARS.FM_REC_QUE IS 'ФМ. Приостановленные документы';
COMMENT ON COLUMN BARS.FM_REC_QUE.REC IS 'Рефе документа';
COMMENT ON COLUMN BARS.FM_REC_QUE.OTM IS 'Признак: №-оплата приостановлена, 0-снят признак блокировки';
COMMENT ON COLUMN BARS.FM_REC_QUE.KF IS '';




PROMPT *** Create  constraint PK_FMRECQUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_REC_QUE ADD CONSTRAINT PK_FMRECQUE PRIMARY KEY (KF, REC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FMRECQUE_REC ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_REC_QUE MODIFY (REC CONSTRAINT CC_FMRECQUE_REC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FMRECQUE_OTM ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_REC_QUE MODIFY (OTM CONSTRAINT CC_FMRECQUE_OTM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FMRECQUE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_REC_QUE MODIFY (KF CONSTRAINT CC_FMRECQUE_KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FMRECQUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FMRECQUE ON BARS.FM_REC_QUE (KF, REC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FM_REC_QUE ***
grant SELECT                                                                 on FM_REC_QUE      to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on FM_REC_QUE      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FM_REC_QUE      to BARS_DM;
grant SELECT                                                                 on FM_REC_QUE      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FM_REC_QUE.sql =========*** End *** ==
PROMPT ===================================================================================== 
