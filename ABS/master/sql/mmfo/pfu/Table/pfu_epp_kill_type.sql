

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_EPP_KILL_TYPE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_EPP_KILL_TYPE ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_EPP_KILL_TYPE 
   (	ID_TYPE NUMBER(1,0), 
	NAME VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_EPP_KILL_TYPE IS 'Типы уничтожения карт';
COMMENT ON COLUMN PFU.PFU_EPP_KILL_TYPE.ID_TYPE IS 'Идентификатор типа ';
COMMENT ON COLUMN PFU.PFU_EPP_KILL_TYPE.NAME IS 'Наименование типа';




PROMPT *** Create  constraint SYS_C00111449 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_EPP_KILL_TYPE MODIFY (ID_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111450 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_EPP_KILL_TYPE MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PFU_EPP_TYPE ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_EPP_KILL_TYPE ADD CONSTRAINT PK_PFU_EPP_TYPE PRIMARY KEY (ID_TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFU_EPP_TYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFU_EPP_TYPE ON PFU.PFU_EPP_KILL_TYPE (ID_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PFU_EPP_KILL_TYPE ***
grant SELECT                                                                 on PFU_EPP_KILL_TYPE to BARSREADER_ROLE;
grant SELECT                                                                 on PFU_EPP_KILL_TYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PFU_EPP_KILL_TYPE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_EPP_KILL_TYPE.sql =========*** End 
PROMPT ===================================================================================== 
