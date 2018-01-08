

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_LOB.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_LOB ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_LOB ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_LOB 
   (	ID NUMBER(10,0), 
	BLOBDATA BLOB, 
	RAWDATA RAW(2000), 
	RAWLEN NUMBER(5,0), 
	STRDATA VARCHAR2(4000)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_LOB ***
 exec bpa.alter_policies('TMP_LOB');


COMMENT ON TABLE BARS.TMP_LOB IS 'Временная таблица для работы с большими объектами';
COMMENT ON COLUMN BARS.TMP_LOB.ID IS 'Номер части';
COMMENT ON COLUMN BARS.TMP_LOB.BLOBDATA IS 'Часть бинарного объекта (вх)';
COMMENT ON COLUMN BARS.TMP_LOB.RAWDATA IS 'Часть бинарного объекта (исх)';
COMMENT ON COLUMN BARS.TMP_LOB.RAWLEN IS 'Длина части бинарного объекта (исх)';
COMMENT ON COLUMN BARS.TMP_LOB.STRDATA IS 'Часть символьного объекта (вх/исх)';




PROMPT *** Create  constraint CC_TMPLOB_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_LOB MODIFY (ID CONSTRAINT CC_TMPLOB_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TMPLOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_LOB ADD CONSTRAINT PK_TMPLOB PRIMARY KEY (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMPLOB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMPLOB ON BARS.TMP_LOB (ID) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_LOB ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_LOB         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT                                                   on TMP_LOB         to CC_DOC;
grant DELETE,INSERT,SELECT                                                   on TMP_LOB         to CUST001;
grant DELETE,INSERT,UPDATE                                                   on TMP_LOB         to IMPEXP;
grant DELETE,INSERT,SELECT                                                   on TMP_LOB         to OW;
grant DELETE                                                                 on TMP_LOB         to PUBLIC;
grant INSERT                                                                 on TMP_LOB         to PYOD001;
grant DELETE,INSERT,SELECT                                                   on TMP_LOB         to RPBN001;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_LOB         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_LOB         to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to TMP_LOB ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_LOB FOR BARS.TMP_LOB;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_LOB.sql =========*** End *** =====
PROMPT ===================================================================================== 
