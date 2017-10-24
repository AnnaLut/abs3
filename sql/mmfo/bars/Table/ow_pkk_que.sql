

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_PKK_QUE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_PKK_QUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_PKK_QUE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_PKK_QUE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OW_PKK_QUE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_PKK_QUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_PKK_QUE 
   (	REF NUMBER(22,0), 
	ACC NUMBER(22,0), 
	DK NUMBER(1,0), 
	SOS NUMBER(1,0) DEFAULT 0, 
	F_N VARCHAR2(100), 
	RESP_CLASS VARCHAR2(100), 
	RESP_CODE VARCHAR2(100), 
	RESP_TEXT VARCHAR2(254), 
	UNFORM_FLAG NUMBER(1,0), 
	UNFORM_USER NUMBER(22,0), 
	UNFORM_DATE DATE, 
	DRN NUMBER(22,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_PKK_QUE ***
 exec bpa.alter_policies('OW_PKK_QUE');


COMMENT ON TABLE BARS.OW_PKK_QUE IS 'OW. Очередь на отправку/квитовку документов ЦРВ';
COMMENT ON COLUMN BARS.OW_PKK_QUE.REF IS 'Реф';
COMMENT ON COLUMN BARS.OW_PKK_QUE.ACC IS 'Acc';
COMMENT ON COLUMN BARS.OW_PKK_QUE.DK IS '0-Д, 1-К';
COMMENT ON COLUMN BARS.OW_PKK_QUE.SOS IS '0-ожидание отправки, 1-ожидание квитовки';
COMMENT ON COLUMN BARS.OW_PKK_QUE.F_N IS 'Имя файла, в кот. отправлен док.';
COMMENT ON COLUMN BARS.OW_PKK_QUE.RESP_CLASS IS '';
COMMENT ON COLUMN BARS.OW_PKK_QUE.RESP_CODE IS '';
COMMENT ON COLUMN BARS.OW_PKK_QUE.RESP_TEXT IS '';
COMMENT ON COLUMN BARS.OW_PKK_QUE.UNFORM_FLAG IS '';
COMMENT ON COLUMN BARS.OW_PKK_QUE.UNFORM_USER IS '';
COMMENT ON COLUMN BARS.OW_PKK_QUE.UNFORM_DATE IS '';
COMMENT ON COLUMN BARS.OW_PKK_QUE.DRN IS '';
COMMENT ON COLUMN BARS.OW_PKK_QUE.KF IS '';




PROMPT *** Create  constraint PK_OWPKKQUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_PKK_QUE ADD CONSTRAINT PK_OWPKKQUE PRIMARY KEY (REF, DK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWPKKQUE_SOS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_PKK_QUE ADD CONSTRAINT CC_OWPKKQUE_SOS CHECK (sos in (0,1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWPKKQUE_SOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_PKK_QUE MODIFY (SOS CONSTRAINT CC_OWPKKQUE_SOS_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWPKKQUE_DK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_PKK_QUE MODIFY (DK CONSTRAINT CC_OWPKKQUE_DK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWPKKQUE_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_PKK_QUE MODIFY (ACC CONSTRAINT CC_OWPKKQUE_ACC_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWPKKQUE_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_PKK_QUE MODIFY (REF CONSTRAINT CC_OWPKKQUE_REF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OWPKKQUE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_PKK_QUE ADD CONSTRAINT FK_OWPKKQUE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWPKKQUE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_PKK_QUE MODIFY (KF CONSTRAINT CC_OWPKKQUE_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OWPKKQUE_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_PKK_QUE ADD CONSTRAINT FK_OWPKKQUE_STAFF FOREIGN KEY (UNFORM_USER)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWPKKQUE_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_PKK_QUE ADD CONSTRAINT CC_OWPKKQUE_DK CHECK (dk in (0,1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OWPKKQUE_OWIICFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_PKK_QUE ADD CONSTRAINT FK_OWPKKQUE_OWIICFILES FOREIGN KEY (F_N)
	  REFERENCES BARS.OW_IICFILES (FILE_NAME) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OWPKKQUE_FN ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OWPKKQUE_FN ON BARS.OW_PKK_QUE (F_N) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWPKKQUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWPKKQUE ON BARS.OW_PKK_QUE (REF, DK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OWPKKQUE_DRN ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OWPKKQUE_DRN ON BARS.OW_PKK_QUE (DRN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OWPKKQUE_ACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OWPKKQUE_ACC ON BARS.OW_PKK_QUE (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_PKK_QUE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_PKK_QUE      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OW_PKK_QUE      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_PKK_QUE      to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_PKK_QUE.sql =========*** End *** ==
PROMPT ===================================================================================== 
