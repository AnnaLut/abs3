

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SGI.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SGI ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SGI ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_SGI 
   (	ID NUMBER, 
	BIN_DATA BLOB, 
	TXT_DATA CLOB
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SGI ***
 exec bpa.alter_policies('TMP_SGI');


COMMENT ON TABLE BARS.TMP_SGI IS '';
COMMENT ON COLUMN BARS.TMP_SGI.ID IS '';
COMMENT ON COLUMN BARS.TMP_SGI.BIN_DATA IS '';
COMMENT ON COLUMN BARS.TMP_SGI.TXT_DATA IS '';




PROMPT *** Create  constraint PK_TMP_SGI ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SGI ADD CONSTRAINT PK_TMP_SGI PRIMARY KEY (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMP_SGI ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMP_SGI ON BARS.TMP_SGI (ID) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_SGI ***
grant SELECT                                                                 on TMP_SGI         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_SGI         to START1;
grant SELECT                                                                 on TMP_SGI         to UPLD;



PROMPT *** Create SYNONYM  to TMP_SGI ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_SGI FOR BARS.TMP_SGI;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SGI.sql =========*** End *** =====
PROMPT ===================================================================================== 
