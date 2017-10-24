

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BIRJA.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BIRJA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BIRJA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BIRJA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BIRJA ***
begin 
  execute immediate '
  CREATE TABLE BARS.BIRJA 
   (	PAR VARCHAR2(8), 
	COMM VARCHAR2(70), 
	VAL VARCHAR2(254)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BIRJA ***
 exec bpa.alter_policies('BIRJA');


COMMENT ON TABLE BARS.BIRJA IS 'Конфиг.параметры модулей "Бирж.операции" и "Вал.контроль"';
COMMENT ON COLUMN BARS.BIRJA.VAL IS '';
COMMENT ON COLUMN BARS.BIRJA.PAR IS 'Код параметра';
COMMENT ON COLUMN BARS.BIRJA.COMM IS 'Комментарий';




PROMPT *** Create  constraint PK_BIRJA ***
begin   
 execute immediate '
  ALTER TABLE BARS.BIRJA ADD CONSTRAINT PK_BIRJA PRIMARY KEY (PAR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BIRJA_PAR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BIRJA MODIFY (PAR CONSTRAINT CC_BIRJA_PAR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BIRJA_COMM_NOT_NULL ***
begin   
 execute immediate '
  ALTER TABLE BARS.BIRJA MODIFY (COMM CONSTRAINT CC_BIRJA_COMM_NOT_NULL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BIRJA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BIRJA ON BARS.BIRJA (PAR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BIRJA ***
grant FLASHBACK,REFERENCES,SELECT                                            on BIRJA           to BARSAQ with grant option;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BIRJA           to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BIRJA           to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on BIRJA           to WR_REFREAD;
grant DELETE,INSERT,SELECT,UPDATE                                            on BIRJA           to ZAY;



PROMPT *** Create SYNONYM  to BIRJA ***

  CREATE OR REPLACE PUBLIC SYNONYM BIRJA FOR BARS.BIRJA;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BIRJA.sql =========*** End *** =======
PROMPT ===================================================================================== 
