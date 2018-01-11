

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TIPS.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TIPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TIPS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TIPS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TIPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TIPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TIPS 
   (	TIP CHAR(3), 
	NAME VARCHAR2(35), 
	ORD NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TIPS ***
 exec bpa.alter_policies('TIPS');


COMMENT ON TABLE BARS.TIPS IS 'Справочник типов счетов';
COMMENT ON COLUMN BARS.TIPS.TIP IS 'Тип счета';
COMMENT ON COLUMN BARS.TIPS.NAME IS 'Наименование типа счета';
COMMENT ON COLUMN BARS.TIPS.ORD IS 'Порядок сортировки';




PROMPT *** Create  constraint CC_TIPS_TIP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TIPS MODIFY (TIP CONSTRAINT CC_TIPS_TIP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TIPS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TIPS MODIFY (NAME CONSTRAINT CC_TIPS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TIPS ADD CONSTRAINT PK_TIPS PRIMARY KEY (TIP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TIPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TIPS ON BARS.TIPS (TIP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TIPS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TIPS            to ABS_ADMIN;
grant SELECT                                                                 on TIPS            to BARSREADER_ROLE;
grant SELECT                                                                 on TIPS            to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TIPS            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TIPS            to BARS_DM;
grant SELECT                                                                 on TIPS            to CUST001;
grant SELECT                                                                 on TIPS            to JBOSS_USR;
grant SELECT                                                                 on TIPS            to KLBX;
grant SELECT                                                                 on TIPS            to RCC_DEAL;
grant SELECT                                                                 on TIPS            to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on TIPS            to TIPS;
grant SELECT                                                                 on TIPS            to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TIPS            to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on TIPS            to WR_REFREAD;
grant SELECT                                                                 on TIPS            to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TIPS.sql =========*** End *** ========
PROMPT ===================================================================================== 
