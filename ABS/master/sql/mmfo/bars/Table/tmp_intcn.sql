

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_INTCN.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_INTCN ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_INTCN ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_INTCN 
   (	ACC NUMBER(38,0), 
	ID NUMBER(1,0), 
	FDAT DATE, 
	TDAT DATE, 
	IR NUMBER(20,4), 
	BR NUMBER, 
	OSTS NUMBER(24,0), 
	ACRD NUMBER(24,0), 
	REMI NUMBER DEFAULT 0
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_INTCN ***
 exec bpa.alter_policies('TMP_INTCN');


COMMENT ON TABLE BARS.TMP_INTCN IS 'Временная таблица';
COMMENT ON COLUMN BARS.TMP_INTCN.ACC IS 'Внутр. номер счета';
COMMENT ON COLUMN BARS.TMP_INTCN.ID IS 'ID';
COMMENT ON COLUMN BARS.TMP_INTCN.FDAT IS 'Дата закрытия';
COMMENT ON COLUMN BARS.TMP_INTCN.TDAT IS '';
COMMENT ON COLUMN BARS.TMP_INTCN.IR IS '';
COMMENT ON COLUMN BARS.TMP_INTCN.BR IS '';
COMMENT ON COLUMN BARS.TMP_INTCN.OSTS IS 'Остатко на счету';
COMMENT ON COLUMN BARS.TMP_INTCN.ACRD IS 'Вспомог. рекв.';
COMMENT ON COLUMN BARS.TMP_INTCN.REMI IS '';




PROMPT *** Create  constraint PK_TMPINTCN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTCN ADD CONSTRAINT PK_TMPINTCN PRIMARY KEY (ACC, ID, FDAT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010443 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTCN MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010442 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTCN MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010441 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTCN MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMPINTCN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMPINTCN ON BARS.TMP_INTCN (ACC, ID, FDAT) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_INTCN ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_INTCN       to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_INTCN       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_INTCN       to BARS_DM;
grant SELECT                                                                 on TMP_INTCN       to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_INTCN       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_INTCN.sql =========*** End *** ===
PROMPT ===================================================================================== 
