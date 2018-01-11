

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACR_INTN.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACR_INTN ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACR_INTN ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.ACR_INTN 
   (	ACC NUMBER(38,0), 
	ID NUMBER(1,0), 
	FDAT DATE, 
	TDAT DATE, 
	IR NUMBER, 
	BR NUMBER, 
	OSTS NUMBER(24,0), 
	ACRD NUMBER(24,0), 
	REMI NUMBER, 
	NAZN VARCHAR2(160)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACR_INTN ***
 exec bpa.alter_policies('ACR_INTN');


COMMENT ON TABLE BARS.ACR_INTN IS 'Временная таблица для начисления процентов';
COMMENT ON COLUMN BARS.ACR_INTN.ACC IS '';
COMMENT ON COLUMN BARS.ACR_INTN.ID IS '№ депозитного договра';
COMMENT ON COLUMN BARS.ACR_INTN.FDAT IS 'Банковская дата';
COMMENT ON COLUMN BARS.ACR_INTN.TDAT IS '';
COMMENT ON COLUMN BARS.ACR_INTN.IR IS 'Индивидуальная процентная ставка';
COMMENT ON COLUMN BARS.ACR_INTN.BR IS 'Код базовой процентной ставки';
COMMENT ON COLUMN BARS.ACR_INTN.OSTS IS 'Сумма остатка на счете';
COMMENT ON COLUMN BARS.ACR_INTN.ACRD IS '';
COMMENT ON COLUMN BARS.ACR_INTN.REMI IS '';
COMMENT ON COLUMN BARS.ACR_INTN.NAZN IS 'Назначение платежа';




PROMPT *** Create  constraint PK_ACRINTN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACR_INTN ADD CONSTRAINT PK_ACRINTN PRIMARY KEY (ACC, ID, FDAT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010162 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACR_INTN MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010163 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACR_INTN MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010164 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACR_INTN MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACRINTN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACRINTN ON BARS.ACR_INTN (ACC, ID, FDAT) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACR_INTN ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACR_INTN        to ABS_ADMIN;
grant DELETE,SELECT                                                          on ACR_INTN        to BARS009;
grant DELETE,SELECT                                                          on ACR_INTN        to BARS010;
grant SELECT                                                                 on ACR_INTN        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACR_INTN        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACR_INTN        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACR_INTN        to DPT_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACR_INTN        to RCC_DEAL;
grant SELECT                                                                 on ACR_INTN        to START1;
grant SELECT                                                                 on ACR_INTN        to UPLD;
grant DELETE,UPDATE                                                          on ACR_INTN        to WR_ACRINT;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACR_INTN        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACR_INTN.sql =========*** End *** ====
PROMPT ===================================================================================== 
