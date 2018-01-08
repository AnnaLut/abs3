

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BIRJA_PARAM.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BIRJA_PARAM ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BIRJA_PARAM ***
begin 
  execute immediate '
  CREATE TABLE BARS.BIRJA_PARAM 
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




PROMPT *** ALTER_POLICIES to BIRJA_PARAM ***
 exec bpa.alter_policies('BIRJA_PARAM');


COMMENT ON TABLE BARS.BIRJA_PARAM IS 'Конфиг.параметры модулей "Бирж.операции" и "Вал.контроль"';
COMMENT ON COLUMN BARS.BIRJA_PARAM.PAR IS 'Код параметра';
COMMENT ON COLUMN BARS.BIRJA_PARAM.COMM IS 'Комментарий';
COMMENT ON COLUMN BARS.BIRJA_PARAM.VAL IS '';




PROMPT *** Create  constraint PK_BIRJA ***
begin   
 execute immediate '
  ALTER TABLE BARS.BIRJA_PARAM ADD CONSTRAINT PK_BIRJA PRIMARY KEY (PAR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BIRJA_COMM_NOT_NULL ***
begin   
 execute immediate '
  ALTER TABLE BARS.BIRJA_PARAM MODIFY (COMM CONSTRAINT CC_BIRJA_COMM_NOT_NULL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BIRJA_PAR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BIRJA_PARAM MODIFY (PAR CONSTRAINT CC_BIRJA_PAR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BIRJA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BIRJA ON BARS.BIRJA_PARAM (PAR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BIRJA_PARAM ***
grant FLASHBACK,REFERENCES,SELECT                                            on BIRJA_PARAM     to BARSAQ with grant option;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BIRJA_PARAM     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BIRJA_PARAM     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BIRJA_PARAM     to F_500;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BIRJA_PARAM     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on BIRJA_PARAM     to WR_REFREAD;
grant DELETE,INSERT,SELECT,UPDATE                                            on BIRJA_PARAM     to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BIRJA_PARAM.sql =========*** End *** =
PROMPT ===================================================================================== 
