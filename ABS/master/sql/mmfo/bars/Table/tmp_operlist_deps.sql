

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OPERLIST_DEPS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OPERLIST_DEPS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OPERLIST_DEPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OPERLIST_DEPS 
   (	ID_PARENT NUMBER(38,0), 
	ID_CHILD NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OPERLIST_DEPS ***
 exec bpa.alter_policies('TMP_OPERLIST_DEPS');


COMMENT ON TABLE BARS.TMP_OPERLIST_DEPS IS '';
COMMENT ON COLUMN BARS.TMP_OPERLIST_DEPS.ID_PARENT IS '';
COMMENT ON COLUMN BARS.TMP_OPERLIST_DEPS.ID_CHILD IS '';




PROMPT *** Create  constraint SYS_C0025578 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OPERLIST_DEPS MODIFY (ID_PARENT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025579 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OPERLIST_DEPS MODIFY (ID_CHILD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_OPERLIST_DEPS ***
grant SELECT                                                                 on TMP_OPERLIST_DEPS to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_OPERLIST_DEPS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OPERLIST_DEPS.sql =========*** End
PROMPT ===================================================================================== 
