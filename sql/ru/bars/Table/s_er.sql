

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S_ER.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S_ER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''S_ER'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''S_ER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S_ER ***
begin 
  execute immediate '
  CREATE TABLE BARS.S_ER 
   (	K_ER CHAR(4), 
	N_ER VARCHAR2(100), 
	K_TASK VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S_ER ***
 exec bpa.alter_policies('S_ER');


COMMENT ON TABLE BARS.S_ER IS 'Справочник кодов ошибок';
COMMENT ON COLUMN BARS.S_ER.K_ER IS 'Код ошибки';
COMMENT ON COLUMN BARS.S_ER.N_ER IS 'Наименование ошибки';
COMMENT ON COLUMN BARS.S_ER.K_TASK IS '';




PROMPT *** Create  constraint PK_SER ***
begin   
 execute immediate '
  ALTER TABLE BARS.S_ER ADD CONSTRAINT PK_SER PRIMARY KEY (K_ER)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SER_NER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.S_ER MODIFY (N_ER CONSTRAINT CC_SER_NER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0011694 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S_ER MODIFY (K_ER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SER ON BARS.S_ER (K_ER) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  S_ER ***
grant DELETE,INSERT,SELECT,UPDATE                                            on S_ER            to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on S_ER            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_ER            to BASIC_INFO;
grant DELETE,INSERT,SELECT,UPDATE                                            on S_ER            to SEP_ROLE;
grant SELECT                                                                 on S_ER            to START1;
grant SELECT                                                                 on S_ER            to TOSS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on S_ER            to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on S_ER            to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S_ER.sql =========*** End *** ========
PROMPT ===================================================================================== 
