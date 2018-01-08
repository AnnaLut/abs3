

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_NEINF.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_NEINF ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_NEINF ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_NEINF 
   (	NAME VARCHAR2(22), 
	ID NUMBER(*,0), 
	COMM3 VARCHAR2(200), 
	COMM1 VARCHAR2(200), 
	COMM2 VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_NEINF ***
 exec bpa.alter_policies('CCK_NEINF');


COMMENT ON TABLE BARS.CCK_NEINF IS '';
COMMENT ON COLUMN BARS.CCK_NEINF.NAME IS '';
COMMENT ON COLUMN BARS.CCK_NEINF.ID IS '';
COMMENT ON COLUMN BARS.CCK_NEINF.COMM3 IS '';
COMMENT ON COLUMN BARS.CCK_NEINF.COMM1 IS '';
COMMENT ON COLUMN BARS.CCK_NEINF.COMM2 IS '';




PROMPT *** Create  constraint SYS_C006348 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_NEINF MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CCK_NEINF ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_NEINF       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_NEINF       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_NEINF       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_NEINF.sql =========*** End *** ===
PROMPT ===================================================================================== 
