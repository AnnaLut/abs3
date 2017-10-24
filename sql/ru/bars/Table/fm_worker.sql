

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FM_WORKER.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FM_WORKER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FM_WORKER'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FM_WORKER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FM_WORKER ***
begin 
  execute immediate '
  CREATE TABLE BARS.FM_WORKER 
   (	ID NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FM_WORKER ***
 exec bpa.alter_policies('FM_WORKER');


COMMENT ON TABLE BARS.FM_WORKER IS 'ФМ. Відповідальні користувачі';
COMMENT ON COLUMN BARS.FM_WORKER.ID IS 'Код користувача';




PROMPT *** Create  constraint FK_FMWORKER_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_WORKER ADD CONSTRAINT FK_FMWORKER_STAFF FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_FMWORKER ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_WORKER ADD CONSTRAINT PK_FMWORKER PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FMWORKER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FMWORKER ON BARS.FM_WORKER (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FM_WORKER ***
grant DELETE,INSERT,SELECT,UPDATE                                            on FM_WORKER       to FINMON01;
grant FLASHBACK,SELECT                                                       on FM_WORKER       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FM_WORKER.sql =========*** End *** ===
PROMPT ===================================================================================== 
