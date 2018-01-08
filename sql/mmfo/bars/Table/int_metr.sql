

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INT_METR.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INT_METR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INT_METR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''INT_METR'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''INT_METR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INT_METR ***
begin 
  execute immediate '
  CREATE TABLE BARS.INT_METR 
   (	METR NUMBER(2,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INT_METR ***
 exec bpa.alter_policies('INT_METR');


COMMENT ON TABLE BARS.INT_METR IS '% Методы расчета процентов';
COMMENT ON COLUMN BARS.INT_METR.METR IS 'Метод расчета';
COMMENT ON COLUMN BARS.INT_METR.NAME IS 'Наименование метода расчта';




PROMPT *** Create  constraint PK_INTMETR ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_METR ADD CONSTRAINT PK_INTMETR PRIMARY KEY (METR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTMETR_METR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_METR MODIFY (METR CONSTRAINT CC_INTMETR_METR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTMETR_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_METR MODIFY (NAME CONSTRAINT CC_INTMETR_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INTMETR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INTMETR ON BARS.INT_METR (METR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INT_METR ***
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_METR        to ABS_ADMIN;
grant SELECT                                                                 on INT_METR        to BARS010;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on INT_METR        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INT_METR        to BARS_DM;
grant SELECT                                                                 on INT_METR        to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_METR        to DPT_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_METR        to INT_METR;
grant SELECT                                                                 on INT_METR        to START1;
grant SELECT                                                                 on INT_METR        to WR_ACRINT;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on INT_METR        to WR_ALL_RIGHTS;
grant SELECT                                                                 on INT_METR        to WR_CREDIT;
grant FLASHBACK,SELECT                                                       on INT_METR        to WR_REFREAD;
grant SELECT                                                                 on INT_METR        to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INT_METR.sql =========*** End *** ====
PROMPT ===================================================================================== 
