

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BMS_MSG.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BMS_MSG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BMS_MSG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BMS_MSG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BMS_MSG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BMS_MSG ***
begin 
  execute immediate '
  CREATE TABLE BARS.BMS_MSG 
   (	CODE VARCHAR2(30), 
	MSG VARCHAR2(254)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BMS_MSG ***
 exec bpa.alter_policies('BMS_MSG');


COMMENT ON TABLE BARS.BMS_MSG IS 'Шаблони повідомлень';
COMMENT ON COLUMN BARS.BMS_MSG.CODE IS 'Код шаблону';
COMMENT ON COLUMN BARS.BMS_MSG.MSG IS 'Повідомлення';




PROMPT *** Create  constraint PK_BMSMSG ***
begin   
 execute immediate '
  ALTER TABLE BARS.BMS_MSG ADD CONSTRAINT PK_BMSMSG PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BMSMSG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BMS_MSG MODIFY (CODE CONSTRAINT CC_BMSMSG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BMSMSG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BMSMSG ON BARS.BMS_MSG (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BMS_MSG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BMS_MSG         to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on BMS_MSG         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BMS_MSG         to BARS_DM;



PROMPT *** Create SYNONYM  to BMS_MSG ***

  CREATE OR REPLACE PUBLIC SYNONYM BMS_MSG FOR BARS.BMS_MSG;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BMS_MSG.sql =========*** End *** =====
PROMPT ===================================================================================== 
