

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_BORG_MESSAGE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_BORG_MESSAGE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_BORG_MESSAGE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_BORG_MESSAGE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_BORG_MESSAGE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_BORG_MESSAGE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_BORG_MESSAGE 
   (	ID NUMBER, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'', ''user_branch''), 
	RNK NUMBER, 
	NOM_DOG VARCHAR2(60), 
	DATE_DOG DATE, 
	DATE_PLAT DATE, 
	FILE_NAME VARCHAR2(51), 
	DELETE_DATE DATE, 
	DELETE_UID NUMBER, 
	DOC_KIND NUMBER, 
	DOC_TYPE NUMBER, 
	BOUND_ID NUMBER, 
	CONTROL_DATE DATE, 
	APPROVE NUMBER DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_BORG_MESSAGE ***
 exec bpa.alter_policies('CIM_BORG_MESSAGE');


COMMENT ON TABLE BARS.CIM_BORG_MESSAGE IS 'Повідомлення про заборгованість';
COMMENT ON COLUMN BARS.CIM_BORG_MESSAGE.ID IS 'id повідомлення';
COMMENT ON COLUMN BARS.CIM_BORG_MESSAGE.BRANCH IS 'Branch відділення';
COMMENT ON COLUMN BARS.CIM_BORG_MESSAGE.RNK IS 'RNK клієнта';
COMMENT ON COLUMN BARS.CIM_BORG_MESSAGE.NOM_DOG IS 'Номер договору';
COMMENT ON COLUMN BARS.CIM_BORG_MESSAGE.DATE_DOG IS 'Дата договору';
COMMENT ON COLUMN BARS.CIM_BORG_MESSAGE.DATE_PLAT IS 'Дата платежу/МД';
COMMENT ON COLUMN BARS.CIM_BORG_MESSAGE.FILE_NAME IS 'Ім`я файлу';
COMMENT ON COLUMN BARS.CIM_BORG_MESSAGE.DELETE_DATE IS 'Дата видалення';
COMMENT ON COLUMN BARS.CIM_BORG_MESSAGE.DELETE_UID IS 'id користувача, який видалив';
COMMENT ON COLUMN BARS.CIM_BORG_MESSAGE.DOC_KIND IS 'Вид документу';
COMMENT ON COLUMN BARS.CIM_BORG_MESSAGE.DOC_TYPE IS 'Тип документу';
COMMENT ON COLUMN BARS.CIM_BORG_MESSAGE.BOUND_ID IS 'Id документу';
COMMENT ON COLUMN BARS.CIM_BORG_MESSAGE.CONTROL_DATE IS 'Контрольна дата';
COMMENT ON COLUMN BARS.CIM_BORG_MESSAGE.APPROVE IS 'Відмітка про підтвердження';




PROMPT *** Create  constraint PK_BORG_MESSAGE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_BORG_MESSAGE ADD CONSTRAINT PK_BORG_MESSAGE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMBORGMESSAGE_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_BORG_MESSAGE MODIFY (BRANCH CONSTRAINT CC_CIMBORGMESSAGE_BRANCH_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMBORGMESSAGE_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_BORG_MESSAGE MODIFY (RNK CONSTRAINT CC_CIMBORGMESSAGE_RNK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMBORGMESSAGE_NOMDOG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_BORG_MESSAGE MODIFY (NOM_DOG CONSTRAINT CC_CIMBORGMESSAGE_NOMDOG_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMBORGMESSAGE_DATEDOG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_BORG_MESSAGE MODIFY (DATE_DOG CONSTRAINT CC_CIMBORGMESSAGE_DATEDOG_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMBORGMESSAGE_DATEPLAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_BORG_MESSAGE MODIFY (DATE_PLAT CONSTRAINT CC_CIMBORGMESSAGE_DATEPLAT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BORG_MESSAGE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BORG_MESSAGE ON BARS.CIM_BORG_MESSAGE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_BORG_MESSAGE ***
grant SELECT                                                                 on CIM_BORG_MESSAGE to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_BORG_MESSAGE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_BORG_MESSAGE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_BORG_MESSAGE to CIM_ROLE;
grant SELECT                                                                 on CIM_BORG_MESSAGE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_BORG_MESSAGE.sql =========*** End 
PROMPT ===================================================================================== 
