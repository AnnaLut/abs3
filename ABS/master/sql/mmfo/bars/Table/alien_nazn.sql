

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ALIEN_NAZN.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ALIEN_NAZN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ALIEN_NAZN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ALIEN_NAZN'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ALIEN_NAZN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ALIEN_NAZN ***
begin 
  execute immediate '
  CREATE TABLE BARS.ALIEN_NAZN 
   (	IDT NUMBER(38,0), 
	IDN NUMBER(38,0), 
	NAZN VARCHAR2(160)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ALIEN_NAZN ***
 exec bpa.alter_policies('ALIEN_NAZN');


COMMENT ON TABLE BARS.ALIEN_NAZN IS 'Справочник типовых назначений для ком. платежей';
COMMENT ON COLUMN BARS.ALIEN_NAZN.IDT IS 'Код однотипной группы ';
COMMENT ON COLUMN BARS.ALIEN_NAZN.IDN IS 'Идентификатор';
COMMENT ON COLUMN BARS.ALIEN_NAZN.NAZN IS 'Текст-заготовка наз.пл ';




PROMPT *** Create  constraint CC_ALIENNAZN_IDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ALIEN_NAZN MODIFY (IDT CONSTRAINT CC_ALIENNAZN_IDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ALIENNAZN_IDN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ALIEN_NAZN MODIFY (IDN CONSTRAINT CC_ALIENNAZN_IDN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ALIENNAZN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ALIEN_NAZN ADD CONSTRAINT PK_ALIENNAZN PRIMARY KEY (IDN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ALIENNAZN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ALIENNAZN ON BARS.ALIEN_NAZN (IDN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ALIEN_NAZN ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ALIEN_NAZN      to ABS_ADMIN;
grant SELECT                                                                 on ALIEN_NAZN      to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ALIEN_NAZN      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ALIEN_NAZN      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ALIEN_NAZN      to PYOD001;
grant SELECT                                                                 on ALIEN_NAZN      to START1;
grant SELECT                                                                 on ALIEN_NAZN      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ALIEN_NAZN      to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on ALIEN_NAZN      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ALIEN_NAZN.sql =========*** End *** ==
PROMPT ===================================================================================== 
