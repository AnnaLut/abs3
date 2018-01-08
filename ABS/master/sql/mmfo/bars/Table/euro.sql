

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EURO.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EURO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EURO'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EURO'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''EURO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EURO ***
begin 
  execute immediate '
  CREATE TABLE BARS.EURO 
   (	KV NUMBER(3,0), 
	E1 NUMBER(17,8)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EURO ***
 exec bpa.alter_policies('EURO');


COMMENT ON TABLE BARS.EURO IS 'Евро-валюты';
COMMENT ON COLUMN BARS.EURO.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.EURO.E1 IS 'Курс к EUR';




PROMPT *** Create  constraint FK_EURO_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.EURO ADD CONSTRAINT FK_EURO_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EURO_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EURO MODIFY (KV CONSTRAINT CC_EURO_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EURO_E1_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EURO MODIFY (E1 CONSTRAINT CC_EURO_E1_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_EURO ***
begin   
 execute immediate '
  ALTER TABLE BARS.EURO ADD CONSTRAINT PK_EURO PRIMARY KEY (KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_EURO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EURO ON BARS.EURO (KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EURO ***
grant DELETE,INSERT,SELECT,UPDATE                                            on EURO            to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on EURO            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EURO            to BARS_DM;
grant SELECT                                                                 on EURO            to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on EURO            to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EURO.sql =========*** End *** ========
PROMPT ===================================================================================== 
