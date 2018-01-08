

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FOLDERS_GOU.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FOLDERS_GOU ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FOLDERS_GOU ***
begin 
  execute immediate '
  CREATE TABLE BARS.FOLDERS_GOU 
   (	IDFO NUMBER(38,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FOLDERS_GOU ***
 exec bpa.alter_policies('FOLDERS_GOU');


COMMENT ON TABLE BARS.FOLDERS_GOU IS '';
COMMENT ON COLUMN BARS.FOLDERS_GOU.IDFO IS '';
COMMENT ON COLUMN BARS.FOLDERS_GOU.NAME IS '';




PROMPT *** Create  constraint SYS_C008975 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FOLDERS_GOU MODIFY (IDFO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FOLDERS_GOU ***
grant SELECT                                                                 on FOLDERS_GOU     to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FOLDERS_GOU.sql =========*** End *** =
PROMPT ===================================================================================== 
