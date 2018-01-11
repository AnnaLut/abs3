

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DBLIST.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DBLIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DBLIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DBLIST'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DBLIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DBLIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.DBLIST 
   (	DBNAME VARCHAR2(16), 
	NAME VARCHAR2(35), 
	TYPE NUMBER(*,0), 
	 CONSTRAINT PK_DBLIST PRIMARY KEY (DBNAME) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLD 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DBLIST ***
 exec bpa.alter_policies('DBLIST');


COMMENT ON TABLE BARS.DBLIST IS '';
COMMENT ON COLUMN BARS.DBLIST.DBNAME IS '';
COMMENT ON COLUMN BARS.DBLIST.NAME IS '';
COMMENT ON COLUMN BARS.DBLIST.TYPE IS '';




PROMPT *** Create  constraint CC_DBLIST_DBNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DBLIST MODIFY (DBNAME CONSTRAINT CC_DBLIST_DBNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DBLIST_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DBLIST MODIFY (NAME CONSTRAINT CC_DBLIST_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DBLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.DBLIST ADD CONSTRAINT PK_DBLIST PRIMARY KEY (DBNAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DBLIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DBLIST ON BARS.DBLIST (DBNAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DBLIST ***
grant DELETE,INSERT,UPDATE                                                   on DBLIST          to ABS_ADMIN;
grant SELECT                                                                 on DBLIST          to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DBLIST          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DBLIST          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DBLIST          to DBLIST;
grant SELECT                                                                 on DBLIST          to START1;
grant FLASHBACK,SELECT                                                       on DBLIST          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DBLIST.sql =========*** End *** ======
PROMPT ===================================================================================== 
