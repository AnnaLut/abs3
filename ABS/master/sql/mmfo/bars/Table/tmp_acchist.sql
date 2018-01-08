

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ACCHIST.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ACCHIST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ACCHIST ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_ACCHIST 
   (	IDUSER NUMBER, 
	ACC NUMBER, 
	TABID NUMBER, 
	COLID NUMBER, 
	VALOLD VARCHAR2(70), 
	VALNEW VARCHAR2(70), 
	ISP VARCHAR2(30), 
	DAT DATE, 
	PARNAME VARCHAR2(110), 
	IDUPD NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ACCHIST ***
 exec bpa.alter_policies('TMP_ACCHIST');


COMMENT ON TABLE BARS.TMP_ACCHIST IS 'Временная таблица';
COMMENT ON COLUMN BARS.TMP_ACCHIST.IDUSER IS 'Код пользователя';
COMMENT ON COLUMN BARS.TMP_ACCHIST.ACC IS 'acc счета/rnk клиента';
COMMENT ON COLUMN BARS.TMP_ACCHIST.TABID IS 'Код таблицы';
COMMENT ON COLUMN BARS.TMP_ACCHIST.COLID IS 'Код колонки';
COMMENT ON COLUMN BARS.TMP_ACCHIST.VALOLD IS 'Старое значение';
COMMENT ON COLUMN BARS.TMP_ACCHIST.VALNEW IS 'Новое значение';
COMMENT ON COLUMN BARS.TMP_ACCHIST.ISP IS 'Кто менял';
COMMENT ON COLUMN BARS.TMP_ACCHIST.DAT IS 'Дата изменения';
COMMENT ON COLUMN BARS.TMP_ACCHIST.PARNAME IS 'Наименование параметра';
COMMENT ON COLUMN BARS.TMP_ACCHIST.IDUPD IS '№ изменения';




PROMPT *** Create  constraint PK_TMPACCHIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ACCHIST ADD CONSTRAINT PK_TMPACCHIST PRIMARY KEY (IDUSER, ACC, TABID, COLID, IDUPD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMPACCHIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMPACCHIST ON BARS.TMP_ACCHIST (IDUSER, ACC, TABID, COLID, IDUPD) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_ACCHIST ***
grant SELECT                                                                 on TMP_ACCHIST     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_ACCHIST     to CUST001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_ACCHIST     to WR_ALL_RIGHTS;
grant SELECT                                                                 on TMP_ACCHIST     to WR_ND_ACCOUNTS;



PROMPT *** Create SYNONYM  to TMP_ACCHIST ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_ACCHIST FOR BARS.TMP_ACCHIST;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ACCHIST.sql =========*** End *** =
PROMPT ===================================================================================== 
