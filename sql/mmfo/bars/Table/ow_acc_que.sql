

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_ACC_QUE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_ACC_QUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_ACC_QUE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_ACC_QUE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OW_ACC_QUE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_ACC_QUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_ACC_QUE 
   (	ACC NUMBER(22,0), 
	S NUMBER(24,0), 
	DAT DATE DEFAULT sysdate, 
	SOS NUMBER(1,0), 
	F_N VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_ACC_QUE ***
 exec bpa.alter_policies('OW_ACC_QUE');


COMMENT ON TABLE BARS.OW_ACC_QUE IS 'Черга арештованих рахунків до відправки в ПЦ';
COMMENT ON COLUMN BARS.OW_ACC_QUE.ACC IS 'ACC';
COMMENT ON COLUMN BARS.OW_ACC_QUE.S IS 'Арештована сума';
COMMENT ON COLUMN BARS.OW_ACC_QUE.DAT IS 'Дата встановлення суми арешту';
COMMENT ON COLUMN BARS.OW_ACC_QUE.SOS IS 'Стан: 0-внесено (чекає відправки), 1-відправлено (чекає квітовки)';
COMMENT ON COLUMN BARS.OW_ACC_QUE.F_N IS 'Ім'я файлу';




PROMPT *** Create  constraint CC_OWACCQUE_SOS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_ACC_QUE ADD CONSTRAINT CC_OWACCQUE_SOS CHECK (sos in (0, 1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OWACCQUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_ACC_QUE ADD CONSTRAINT PK_OWACCQUE PRIMARY KEY (ACC, SOS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWACCQUE_DAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_ACC_QUE MODIFY (DAT CONSTRAINT CC_OWACCQUE_DAT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWACCQUE_SOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_ACC_QUE MODIFY (SOS CONSTRAINT CC_OWACCQUE_SOS_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWACCQUE_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_ACC_QUE MODIFY (ACC CONSTRAINT CC_OWACCQUE_ACC_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWACCQUE_S_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_ACC_QUE MODIFY (S CONSTRAINT CC_OWACCQUE_S_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWACCQUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWACCQUE ON BARS.OW_ACC_QUE (ACC, SOS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_ACC_QUE ***
grant SELECT                                                                 on OW_ACC_QUE      to BARSREADER_ROLE;
grant SELECT                                                                 on OW_ACC_QUE      to BARS_DM;
grant SELECT                                                                 on OW_ACC_QUE      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_ACC_QUE.sql =========*** End *** ==
PROMPT ===================================================================================== 
