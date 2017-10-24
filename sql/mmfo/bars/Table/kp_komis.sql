

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KP_KOMIS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KP_KOMIS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KP_KOMIS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KP_KOMIS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KP_KOMIS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KP_KOMIS ***
begin 
  execute immediate '
  CREATE TABLE BARS.KP_KOMIS 
   (	ID NUMBER(*,0), 
	ND NUMBER(*,0), 
	S1 NUMBER, 
	S2 NUMBER, 
	PR_FL NUMBER, 
	PR_UL NUMBER, 
	SUM_FL NUMBER, 
	SUM_UL NUMBER, 
	TYPE NUMBER(*,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KP_KOMIS ***
 exec bpa.alter_policies('KP_KOMIS');


COMMENT ON TABLE BARS.KP_KOMIS IS 'КП. Договора и комиссия банку';
COMMENT ON COLUMN BARS.KP_KOMIS.ID IS 'Уникальный индитификатор';
COMMENT ON COLUMN BARS.KP_KOMIS.ND IS 'реф дог';
COMMENT ON COLUMN BARS.KP_KOMIS.S1 IS 'Сумма платежа >=';
COMMENT ON COLUMN BARS.KP_KOMIS.S2 IS 'Сумма платежа <';
COMMENT ON COLUMN BARS.KP_KOMIS.PR_FL IS '% с ФЛ (плательщика)';
COMMENT ON COLUMN BARS.KP_KOMIS.PR_UL IS '% с ЮЛ (получателя)';
COMMENT ON COLUMN BARS.KP_KOMIS.SUM_FL IS 'Фиксированная сумма с ФЛ (плательщика)';
COMMENT ON COLUMN BARS.KP_KOMIS.SUM_UL IS 'Фиксированная сумма с ЮЛ (получателя)';
COMMENT ON COLUMN BARS.KP_KOMIS.TYPE IS 'Тип комиссии 0-физ,1-юр.';




PROMPT *** Create  constraint CHK_KP_KOMIS ***
begin   
 execute immediate '
  ALTER TABLE BARS.KP_KOMIS ADD CONSTRAINT CHK_KP_KOMIS CHECK (S1<=S2) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KP_KOMIS ***
begin   
 execute immediate '
  ALTER TABLE BARS.KP_KOMIS ADD CONSTRAINT FK_KP_KOMIS FOREIGN KEY (ND)
	  REFERENCES BARS.KP_DEAL (ND) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005407 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KP_KOMIS MODIFY (ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005408 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KP_KOMIS MODIFY (S1 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005409 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KP_KOMIS MODIFY (S2 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_KP_KOMIS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_KP_KOMIS ON BARS.KP_KOMIS (ND, S1, S2) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KP_KOMIS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KP_KOMIS ON BARS.KP_KOMIS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KP_KOMIS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KP_KOMIS        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KP_KOMIS        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KP_KOMIS        to R_KP;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KP_KOMIS        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KP_KOMIS.sql =========*** End *** ====
PROMPT ===================================================================================== 
