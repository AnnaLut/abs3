

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TASK_LIST.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TASK_LIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TASK_LIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TASK_LIST'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TASK_LIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TASK_LIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.TASK_LIST 
   (	TASK_ID NUMBER, 
	NAME VARCHAR2(100), 
	FUNCTION VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TASK_LIST ***
 exec bpa.alter_policies('TASK_LIST');


COMMENT ON TABLE BARS.TASK_LIST IS 'Список задач на автоматич. выполнение';
COMMENT ON COLUMN BARS.TASK_LIST.TASK_ID IS '';
COMMENT ON COLUMN BARS.TASK_LIST.NAME IS '';
COMMENT ON COLUMN BARS.TASK_LIST.FUNCTION IS '';




PROMPT *** Create  constraint SYS_C0012619 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TASK_LIST ADD PRIMARY KEY (TASK_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0012619 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0012619 ON BARS.TASK_LIST (TASK_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TASK_LIST ***
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on TASK_LIST       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TASK_LIST       to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on TASK_LIST       to TASK_LIST;
grant FLASHBACK,SELECT                                                       on TASK_LIST       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TASK_LIST.sql =========*** End *** ===
PROMPT ===================================================================================== 
