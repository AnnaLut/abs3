

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REFERENCES_RU.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REFERENCES_RU ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REFERENCES_RU ***
begin 
  execute immediate '
  CREATE TABLE BARS.REFERENCES_RU 
   (	TABID NUMBER(*,0), 
	TYPE NUMBER(38,0), 
	DLGNAME VARCHAR2(200), 
	ROLE2EDIT VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REFERENCES_RU ***
 exec bpa.alter_policies('REFERENCES_RU');


COMMENT ON TABLE BARS.REFERENCES_RU IS '';
COMMENT ON COLUMN BARS.REFERENCES_RU.TABID IS '';
COMMENT ON COLUMN BARS.REFERENCES_RU.TYPE IS '';
COMMENT ON COLUMN BARS.REFERENCES_RU.DLGNAME IS '';
COMMENT ON COLUMN BARS.REFERENCES_RU.ROLE2EDIT IS '';




PROMPT *** Create  constraint SYS_C008966 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REFERENCES_RU MODIFY (TABID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008967 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REFERENCES_RU MODIFY (TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REFERENCES_RU ***
grant SELECT                                                                 on REFERENCES_RU   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on REFERENCES_RU   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REFERENCES_RU   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on REFERENCES_RU   to START1;
grant SELECT                                                                 on REFERENCES_RU   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REFERENCES_RU.sql =========*** End ***
PROMPT ===================================================================================== 
