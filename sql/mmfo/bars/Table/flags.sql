

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FLAGS.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FLAGS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FLAGS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FLAGS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''FLAGS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FLAGS ***
begin 
  execute immediate '
  CREATE TABLE BARS.FLAGS 
   (	CODE NUMBER(38,0), 
	NAME VARCHAR2(105), 
	EDIT NUMBER(1,0), 
	OPT NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FLAGS ***
 exec bpa.alter_policies('FLAGS');


COMMENT ON TABLE BARS.FLAGS IS 'Флаги транзакций(операций)';
COMMENT ON COLUMN BARS.FLAGS.CODE IS 'Идентификатор флага';
COMMENT ON COLUMN BARS.FLAGS.NAME IS 'Имя флага';
COMMENT ON COLUMN BARS.FLAGS.EDIT IS 'Редактируемость флага';
COMMENT ON COLUMN BARS.FLAGS.OPT IS 'Необязятельность флага';




PROMPT *** Create  constraint PK_FLAGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.FLAGS ADD CONSTRAINT PK_FLAGS PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FLAGS_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FLAGS MODIFY (CODE CONSTRAINT CC_FLAGS_CODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FLAGS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FLAGS MODIFY (NAME CONSTRAINT CC_FLAGS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FLAGS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FLAGS ON BARS.FLAGS (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FLAGS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on FLAGS           to ABS_ADMIN;
grant SELECT                                                                 on FLAGS           to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FLAGS           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FLAGS           to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FLAGS           to FLAGS;
grant SELECT                                                                 on FLAGS           to START1;
grant SELECT                                                                 on FLAGS           to TECH005;
grant SELECT                                                                 on FLAGS           to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FLAGS           to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on FLAGS           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FLAGS.sql =========*** End *** =======
PROMPT ===================================================================================== 
