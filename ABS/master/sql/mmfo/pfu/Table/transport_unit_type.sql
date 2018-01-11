

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/TRANSPORT_UNIT_TYPE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  table TRANSPORT_UNIT_TYPE ***
begin 
  execute immediate '
  CREATE TABLE PFU.TRANSPORT_UNIT_TYPE 
   (	ID NUMBER(5,0), 
	TRANSPORT_TYPE_CODE VARCHAR2(30 CHAR), 
	TRANSPORT_TYPE_NAME VARCHAR2(300 CHAR), 
	DIRECTION NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.TRANSPORT_UNIT_TYPE IS '';
COMMENT ON COLUMN PFU.TRANSPORT_UNIT_TYPE.ID IS '';
COMMENT ON COLUMN PFU.TRANSPORT_UNIT_TYPE.TRANSPORT_TYPE_CODE IS '';
COMMENT ON COLUMN PFU.TRANSPORT_UNIT_TYPE.TRANSPORT_TYPE_NAME IS '';
COMMENT ON COLUMN PFU.TRANSPORT_UNIT_TYPE.DIRECTION IS '1 - OneWay, 2 - TwoWay';




PROMPT *** Create  constraint SYS_C00111464 ***
begin   
 execute immediate '
  ALTER TABLE PFU.TRANSPORT_UNIT_TYPE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TRANSPORT_UNIT_TYPE ***
begin   
 execute immediate '
  ALTER TABLE PFU.TRANSPORT_UNIT_TYPE ADD CONSTRAINT PK_TRANSPORT_UNIT_TYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TRANSPORT_UNIT_TYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_TRANSPORT_UNIT_TYPE ON PFU.TRANSPORT_UNIT_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TRANSPORT_UNIT_TYPE ***
grant SELECT                                                                 on TRANSPORT_UNIT_TYPE to BARSREADER_ROLE;
grant SELECT                                                                 on TRANSPORT_UNIT_TYPE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/TRANSPORT_UNIT_TYPE.sql =========*** En
PROMPT ===================================================================================== 
