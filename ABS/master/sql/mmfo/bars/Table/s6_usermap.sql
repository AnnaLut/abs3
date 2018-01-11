

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_USERMAP.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_USERMAP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_USERMAP ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_USERMAP 
   (	KF VARCHAR2(24), 
	ISPS6 NUMBER, 
	USERSUFFIX VARCHAR2(24), 
	FILIAL VARCHAR2(6), 
	ID NUMBER(*,0), 
	LOGNAME VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_USERMAP ***
 exec bpa.alter_policies('S6_USERMAP');


COMMENT ON TABLE BARS.S6_USERMAP IS '';
COMMENT ON COLUMN BARS.S6_USERMAP.KF IS '';
COMMENT ON COLUMN BARS.S6_USERMAP.ISPS6 IS '';
COMMENT ON COLUMN BARS.S6_USERMAP.USERSUFFIX IS '';
COMMENT ON COLUMN BARS.S6_USERMAP.FILIAL IS '';
COMMENT ON COLUMN BARS.S6_USERMAP.ID IS '';
COMMENT ON COLUMN BARS.S6_USERMAP.LOGNAME IS '';




PROMPT *** Create  constraint SYS_C009628 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_USERMAP MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009629 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_USERMAP MODIFY (ISPS6 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009630 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_USERMAP MODIFY (USERSUFFIX NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAK_S6_USERMAP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XAK_S6_USERMAP ON BARS.S6_USERMAP (KF, ISPS6, FILIAL) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  S6_USERMAP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on S6_USERMAP      to ABS_ADMIN;
grant SELECT                                                                 on S6_USERMAP      to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on S6_USERMAP      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S6_USERMAP      to UPLD;
grant FLASHBACK,SELECT                                                       on S6_USERMAP      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_USERMAP.sql =========*** End *** ==
PROMPT ===================================================================================== 
