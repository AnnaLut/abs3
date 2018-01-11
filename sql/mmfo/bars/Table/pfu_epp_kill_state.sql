

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PFU_EPP_KILL_STATE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PFU_EPP_KILL_STATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PFU_EPP_KILL_STATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PFU_EPP_KILL_STATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PFU_EPP_KILL_STATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.PFU_EPP_KILL_STATE 
   (	ID_STATE NUMBER(1,0), 
	NAME VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PFU_EPP_KILL_STATE ***
 exec bpa.alter_policies('PFU_EPP_KILL_STATE');


COMMENT ON TABLE BARS.PFU_EPP_KILL_STATE IS 'Состояние передачи значения в ГРЦ';
COMMENT ON COLUMN BARS.PFU_EPP_KILL_STATE.ID_STATE IS 'Идентификатор состояния';
COMMENT ON COLUMN BARS.PFU_EPP_KILL_STATE.NAME IS 'Наименование состояния';




PROMPT *** Create  constraint SYS_C00109497 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PFU_EPP_KILL_STATE MODIFY (ID_STATE NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109498 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PFU_EPP_KILL_STATE MODIFY (NAME NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PFU_EPP_KILL_STATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.PFU_EPP_KILL_STATE ADD CONSTRAINT PK_PFU_EPP_KILL_STATE PRIMARY KEY (ID_STATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFU_EPP_KILL_STATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PFU_EPP_KILL_STATE ON BARS.PFU_EPP_KILL_STATE (ID_STATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PFU_EPP_KILL_STATE ***
grant SELECT                                                                 on PFU_EPP_KILL_STATE to BARSREADER_ROLE;
grant SELECT                                                                 on PFU_EPP_KILL_STATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PFU_EPP_KILL_STATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PFU_EPP_KILL_STATE.sql =========*** En
PROMPT ===================================================================================== 
