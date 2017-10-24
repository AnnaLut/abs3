

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/REFSYNC_LIST.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  table REFSYNC_LIST ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.REFSYNC_LIST 
   (	TABNAME VARCHAR2(50), 
	 CONSTRAINT PK_REFSYNC_LIST PRIMARY KEY (TABNAME) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE AQTS 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.REFSYNC_LIST IS '';
COMMENT ON COLUMN BARSAQ.REFSYNC_LIST.TABNAME IS '';




PROMPT *** Create  constraint PK_REFSYNC_LIST ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.REFSYNC_LIST ADD CONSTRAINT PK_REFSYNC_LIST PRIMARY KEY (TABNAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REFSYNC_LIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_REFSYNC_LIST ON BARSAQ.REFSYNC_LIST (TABNAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REFSYNC_LIST ***
grant DELETE,INSERT,SELECT                                                   on REFSYNC_LIST    to BARS;
grant SELECT                                                                 on REFSYNC_LIST    to KLBX;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/REFSYNC_LIST.sql =========*** End **
PROMPT ===================================================================================== 
