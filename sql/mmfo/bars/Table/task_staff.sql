

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TASK_STAFF.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TASK_STAFF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TASK_STAFF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TASK_STAFF'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TASK_STAFF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TASK_STAFF ***
begin 
  execute immediate '
  CREATE TABLE BARS.TASK_STAFF 
   (	ID NUMBER, 
	TASK_ID NUMBER, 
	ORD NUMBER, 
	INTERVAL NUMBER, 
	METHOD NUMBER, 
	TRIGGER_DATE DATE, 
	IDKEY NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TASK_STAFF ***
 exec bpa.alter_policies('TASK_STAFF');


COMMENT ON TABLE BARS.TASK_STAFF IS 'Задача для авто выполнения';
COMMENT ON COLUMN BARS.TASK_STAFF.ID IS '';
COMMENT ON COLUMN BARS.TASK_STAFF.TASK_ID IS '';
COMMENT ON COLUMN BARS.TASK_STAFF.ORD IS '';
COMMENT ON COLUMN BARS.TASK_STAFF.INTERVAL IS '';
COMMENT ON COLUMN BARS.TASK_STAFF.METHOD IS '';
COMMENT ON COLUMN BARS.TASK_STAFF.TRIGGER_DATE IS '';
COMMENT ON COLUMN BARS.TASK_STAFF.IDKEY IS '';




PROMPT *** Create  constraint SYS_C0011532 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TASK_STAFF ADD PRIMARY KEY (IDKEY)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0011532 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0011532 ON BARS.TASK_STAFF (IDKEY) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XUI_TASK_STAFF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XUI_TASK_STAFF ON BARS.TASK_STAFF (ID, ORD, TASK_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TASK_STAFF ***
grant SELECT                                                                 on TASK_STAFF      to BARSREADER_ROLE;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on TASK_STAFF      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TASK_STAFF      to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on TASK_STAFF      to TASK_LIST;
grant DELETE,INSERT,SELECT,UPDATE                                            on TASK_STAFF      to TASK_STAFF;
grant SELECT                                                                 on TASK_STAFF      to UPLD;
grant FLASHBACK,SELECT                                                       on TASK_STAFF      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TASK_STAFF.sql =========*** End *** ==
PROMPT ===================================================================================== 
