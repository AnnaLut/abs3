

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VIDD_TIP.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VIDD_TIP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VIDD_TIP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''VIDD_TIP'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''VIDD_TIP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VIDD_TIP ***
begin 
  execute immediate '
  CREATE TABLE BARS.VIDD_TIP 
   (	VIDD NUMBER, 
	TIP CHAR(3), 
	FORCE_OPEN VARCHAR2(4000) DEFAULT ''0''
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VIDD_TIP ***
 exec bpa.alter_policies('VIDD_TIP');


COMMENT ON TABLE BARS.VIDD_TIP IS 'Связь Виды договоров <-> Типы счетов';
COMMENT ON COLUMN BARS.VIDD_TIP.VIDD IS 'Вид Договора';
COMMENT ON COLUMN BARS.VIDD_TIP.TIP IS 'Тип счета';
COMMENT ON COLUMN BARS.VIDD_TIP.FORCE_OPEN IS 'Принудительное открытие счета 0 - не открывать, 1 - открывать, <условие where выражения select count(*) from dual where <sql блок> (обязательно должно содержать парамтр :p_nd), прим. nvl(to_number(cck_app.get_nd_txt(:p_nd, 'CCSRC')), -1) != 2> ';




PROMPT *** Create  constraint PK_VIDDTIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIDD_TIP ADD CONSTRAINT PK_VIDDTIP PRIMARY KEY (TIP, VIDD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_VIDDTIP_FOPEN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIDD_TIP MODIFY (FORCE_OPEN CONSTRAINT CC_VIDDTIP_FOPEN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_VIDD_TIP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_VIDD_TIP ON BARS.VIDD_TIP (TIP, VIDD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VIDD_TIP ***
grant SELECT                                                                 on VIDD_TIP        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VIDD_TIP        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VIDD_TIP        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on VIDD_TIP        to RCC_DEAL;
grant SELECT                                                                 on VIDD_TIP        to START1;
grant SELECT                                                                 on VIDD_TIP        to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on VIDD_TIP        to VIDD_TIP;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VIDD_TIP        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on VIDD_TIP        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VIDD_TIP.sql =========*** End *** ====
PROMPT ===================================================================================== 
