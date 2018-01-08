

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CP_WORK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CP_WORK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CP_WORK ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_CP_WORK 
   (	REF NUMBER(*,0), 
	ACC NUMBER(*,0), 
	DOSQ NUMBER, 
	KOSQ NUMBER, 
	DOS NUMBER, 
	KOS NUMBER, 
	FDAT DATE
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CP_WORK ***
 exec bpa.alter_policies('TMP_CP_WORK');


COMMENT ON TABLE BARS.TMP_CP_WORK IS '';
COMMENT ON COLUMN BARS.TMP_CP_WORK.REF IS '';
COMMENT ON COLUMN BARS.TMP_CP_WORK.ACC IS '';
COMMENT ON COLUMN BARS.TMP_CP_WORK.DOSQ IS '';
COMMENT ON COLUMN BARS.TMP_CP_WORK.KOSQ IS '';
COMMENT ON COLUMN BARS.TMP_CP_WORK.DOS IS '';
COMMENT ON COLUMN BARS.TMP_CP_WORK.KOS IS '';
COMMENT ON COLUMN BARS.TMP_CP_WORK.FDAT IS '';




PROMPT *** Create  constraint PK_TMP_CP_WORK ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CP_WORK ADD CONSTRAINT PK_TMP_CP_WORK PRIMARY KEY (REF, ACC, FDAT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMP_CP_WORK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMP_CP_WORK ON BARS.TMP_CP_WORK (REF, ACC, FDAT) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_CP_WORK ***
grant SELECT                                                                 on TMP_CP_WORK     to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_CP_WORK     to UPLD;



PROMPT *** Create SYNONYM  to TMP_CP_WORK ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_CP_WORK FOR BARS.TMP_CP_WORK;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CP_WORK.sql =========*** End *** =
PROMPT ===================================================================================== 
