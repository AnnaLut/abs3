

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUST_REL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUST_REL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUST_REL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUST_REL'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CUST_REL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUST_REL ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUST_REL 
   (	ID NUMBER(38,0), 
	RELATEDNESS VARCHAR2(100), 
	F_VAGA NUMBER(1,0) DEFAULT 0, 
	INUSE NUMBER(1,0) DEFAULT 1, 
	SORT NUMBER(22,0), 
	B NUMBER(1,0), 
	U NUMBER(1,0), 
	F NUMBER(1,0), 
	U_NREZ NUMBER(1,0), 
	F_NREZ NUMBER(1,0), 
	F_SPD NUMBER(1,0), 
	TYPE NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUST_REL ***
 exec bpa.alter_policies('CUST_REL');


COMMENT ON TABLE BARS.CUST_REL IS 'Признаки связанности клиентов';
COMMENT ON COLUMN BARS.CUST_REL.ID IS 'Код';
COMMENT ON COLUMN BARS.CUST_REL.RELATEDNESS IS 'Описание признака';
COMMENT ON COLUMN BARS.CUST_REL.F_VAGA IS 'Признак: учитывать Удельный вес';
COMMENT ON COLUMN BARS.CUST_REL.INUSE IS 'Признак действующего признака связанности';
COMMENT ON COLUMN BARS.CUST_REL.SORT IS 'Сортировка в карточке клиента';
COMMENT ON COLUMN BARS.CUST_REL.B IS 'Признак заполнения для клиента Банк';
COMMENT ON COLUMN BARS.CUST_REL.U IS 'Признак заполнения для клиента ЮЛ-резидент';
COMMENT ON COLUMN BARS.CUST_REL.F IS 'Признак заполнения для клиента ФЛ-резидент"';
COMMENT ON COLUMN BARS.CUST_REL.U_NREZ IS 'Признак заполнения для клиента ЮЛ-нерезидент';
COMMENT ON COLUMN BARS.CUST_REL.F_NREZ IS 'Признак заполнения для клиента ФЛ-нерезидент';
COMMENT ON COLUMN BARS.CUST_REL.F_SPD IS 'Признак заполнения для клиента ФЛ-СПД';
COMMENT ON COLUMN BARS.CUST_REL.TYPE IS '';




PROMPT *** Create  constraint CC_CUSTREL_FVAGA ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_REL ADD CONSTRAINT CC_CUSTREL_FVAGA CHECK (f_vaga in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CUSTREL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_REL ADD CONSTRAINT PK_CUSTREL PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTREL_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_REL MODIFY (ID CONSTRAINT CC_CUSTREL_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTREL_RELTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_REL MODIFY (RELATEDNESS CONSTRAINT CC_CUSTREL_RELTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTREL_INUSE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_REL MODIFY (INUSE CONSTRAINT CC_CUSTREL_INUSE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTREL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTREL ON BARS.CUST_REL (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUST_REL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CUST_REL        to ABS_ADMIN;
grant SELECT                                                                 on CUST_REL        to BARSREADER_ROLE;
grant SELECT                                                                 on CUST_REL        to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUST_REL        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUST_REL        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUST_REL        to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUST_REL        to REF0000;
grant SELECT                                                                 on CUST_REL        to START1;
grant SELECT                                                                 on CUST_REL        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUST_REL        to WR_ALL_RIGHTS;
grant SELECT                                                                 on CUST_REL        to WR_CUSTREG;
grant FLASHBACK,SELECT                                                       on CUST_REL        to WR_REFREAD;



PROMPT *** Create SYNONYM  to CUST_REL ***

  CREATE OR REPLACE PUBLIC SYNONYM CUST_REL FOR BARS.CUST_REL;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUST_REL.sql =========*** End *** ====
PROMPT ===================================================================================== 
