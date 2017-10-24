

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CONTRACTS_LICENCE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CONTRACTS_LICENCE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CONTRACTS_LICENCE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CONTRACTS_LICENCE 
   (	ID NUMBER, 
	PID NUMBER, 
	LICNAME VARCHAR2(50), 
	LICDATE DATE, 
	DATE_ON DATE, 
	DATE_OFF DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 5 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CONTRACTS_LICENCE ***
 exec bpa.alter_policies('CONTRACTS_LICENCE');


COMMENT ON TABLE BARS.CONTRACTS_LICENCE IS 'Лицензии по экспортно-импортным контрактам';
COMMENT ON COLUMN BARS.CONTRACTS_LICENCE.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.CONTRACTS_LICENCE.PID IS 'Референс контракта';
COMMENT ON COLUMN BARS.CONTRACTS_LICENCE.LICNAME IS 'Номер лицензии';
COMMENT ON COLUMN BARS.CONTRACTS_LICENCE.LICDATE IS 'Дата лицензии';
COMMENT ON COLUMN BARS.CONTRACTS_LICENCE.DATE_ON IS 'Начало действия';
COMMENT ON COLUMN BARS.CONTRACTS_LICENCE.DATE_OFF IS 'Окончание действия';




PROMPT *** Create  constraint PK_CONTRACTSLICENCE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CONTRACTS_LICENCE ADD CONSTRAINT PK_CONTRACTSLICENCE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CONTRACTSLICENCE_CONTRACTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CONTRACTS_LICENCE ADD CONSTRAINT FK_CONTRACTSLICENCE_CONTRACTS FOREIGN KEY (PID)
	  REFERENCES BARS.TOP_CONTRACTS (PID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CONTRACTSLICENCE_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CONTRACTS_LICENCE MODIFY (ID CONSTRAINT CC_CONTRACTSLICENCE_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CONTRACTSLICENCE_PID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CONTRACTS_LICENCE MODIFY (PID CONSTRAINT CC_CONTRACTSLICENCE_PID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CONTRACTSLICENCE_LICNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CONTRACTS_LICENCE MODIFY (LICNAME CONSTRAINT CC_CONTRACTSLICENCE_LICNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CONTRACTSLICENCE_LICDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CONTRACTS_LICENCE MODIFY (LICDATE CONSTRAINT CC_CONTRACTSLICENCE_LICDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CONTRACTSLICENCE_DATEON_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CONTRACTS_LICENCE MODIFY (DATE_ON CONSTRAINT CC_CONTRACTSLICENCE_DATEON_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CONTRACTSLICENCE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CONTRACTSLICENCE ON BARS.CONTRACTS_LICENCE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CONTRACTS_LICENCE ***
grant SELECT                                                                 on CONTRACTS_LICENCE to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CONTRACTS_LICENCE to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to CONTRACTS_LICENCE ***

  CREATE OR REPLACE PUBLIC SYNONYM CONTRACTS_LICENCE FOR BARS.CONTRACTS_LICENCE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CONTRACTS_LICENCE.sql =========*** End
PROMPT ===================================================================================== 
