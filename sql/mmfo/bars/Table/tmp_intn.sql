

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_INTN.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_INTN ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_INTN ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_INTN 
   (	ID NUMBER(38,0), 
	DAT DATE, 
	OSTF NUMBER(24,0), 
	IR NUMBER(20,4), 
	BR NUMBER, 
	BRN NUMBER, 
	OTM NUMBER(1,0), 
	S NUMBER(24,0), 
	OP NUMBER(4,0)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_INTN ***
 exec bpa.alter_policies('TMP_INTN');


COMMENT ON TABLE BARS.TMP_INTN IS 'Временная таблица';
COMMENT ON COLUMN BARS.TMP_INTN.ID IS 'Идентификатор сессии';
COMMENT ON COLUMN BARS.TMP_INTN.DAT IS 'Дата';
COMMENT ON COLUMN BARS.TMP_INTN.OSTF IS 'Фактич. остаток';
COMMENT ON COLUMN BARS.TMP_INTN.IR IS '';
COMMENT ON COLUMN BARS.TMP_INTN.BR IS '';
COMMENT ON COLUMN BARS.TMP_INTN.BRN IS '';
COMMENT ON COLUMN BARS.TMP_INTN.OTM IS 'Отметка';
COMMENT ON COLUMN BARS.TMP_INTN.S IS 'Сумма';
COMMENT ON COLUMN BARS.TMP_INTN.OP IS 'Операция';




PROMPT *** Create  constraint CC_TMPINTN_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTN MODIFY (ID CONSTRAINT CC_TMPINTN_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPINTN_DAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTN MODIFY (DAT CONSTRAINT CC_TMPINTN_DAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPINTN_OTM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTN MODIFY (OTM CONSTRAINT CC_TMPINTN_OTM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMPINTN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMPINTN ON BARS.TMP_INTN (ID, DAT, OTM) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_INTN ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_INTN        to ABS_ADMIN;
grant SELECT                                                                 on TMP_INTN        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_INTN        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_INTN        to START1;
grant SELECT                                                                 on TMP_INTN        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_INTN        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_INTN.sql =========*** End *** ====
PROMPT ===================================================================================== 
