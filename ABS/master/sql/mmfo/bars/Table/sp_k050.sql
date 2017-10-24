

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SP_K050.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SP_K050 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SP_K050'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SP_K050'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SP_K050'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SP_K050 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SP_K050 
   (	K050 CHAR(3), 
	K051 CHAR(2), 
	K052 CHAR(1), 
	NAME VARCHAR2(96), 
	D_OPEN DATE, 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SP_K050 ***
 exec bpa.alter_policies('SP_K050');


COMMENT ON TABLE BARS.SP_K050 IS 'КЛАССИФИКАЦИЯ ОРГАНИЗАЦИОННО-ПРАВОВЫХ ФОРМ ХОЗЯЙСТВОВАНИЯ';
COMMENT ON COLUMN BARS.SP_K050.K050 IS 'Код k050';
COMMENT ON COLUMN BARS.SP_K050.K051 IS 'Код k051';
COMMENT ON COLUMN BARS.SP_K050.K052 IS 'Код k052';
COMMENT ON COLUMN BARS.SP_K050.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.SP_K050.D_OPEN IS 'Дата начала действия показателя';
COMMENT ON COLUMN BARS.SP_K050.D_CLOSE IS 'Дата окончания действия показателя';




PROMPT *** Create  constraint CC_SP050_K050_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SP_K050 MODIFY (K050 CONSTRAINT CC_SP050_K050_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SPK050 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SP_K050 ADD CONSTRAINT PK_SPK050 PRIMARY KEY (K050)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SPK050 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SPK050 ON BARS.SP_K050 (K050) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SP_K050 ***
grant SELECT                                                                 on SP_K050         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SP_K050         to BARS_DM;
grant SELECT                                                                 on SP_K050         to CUST001;
grant SELECT                                                                 on SP_K050         to WR_CUSTREG;



PROMPT *** Create SYNONYM  to SP_K050 ***

  CREATE OR REPLACE PUBLIC SYNONYM SP_K050 FOR BARS.SP_K050;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SP_K050.sql =========*** End *** =====
PROMPT ===================================================================================== 
