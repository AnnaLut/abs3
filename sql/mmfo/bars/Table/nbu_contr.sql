

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBU_CONTR.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBU_CONTR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBU_CONTR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''NBU_CONTR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NBU_CONTR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBU_CONTR ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBU_CONTR 
   (	RNK NUMBER, 
	NAME VARCHAR2(50), 
	CONFIRM VARCHAR2(50), 
	DATE_C DATE, 
	PID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBU_CONTR ***
 exec bpa.alter_policies('NBU_CONTR');


COMMENT ON TABLE BARS.NBU_CONTR IS 'Подтверждения НБУ для имп.контрактов';
COMMENT ON COLUMN BARS.NBU_CONTR.RNK IS 'РНК';
COMMENT ON COLUMN BARS.NBU_CONTR.NAME IS 'Номер контракта';
COMMENT ON COLUMN BARS.NBU_CONTR.CONFIRM IS 'Номер подтверждения';
COMMENT ON COLUMN BARS.NBU_CONTR.DATE_C IS 'Дата подтверждения';
COMMENT ON COLUMN BARS.NBU_CONTR.PID IS 'Референс контракта';




PROMPT *** Create  constraint PK_NBUCONTR ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBU_CONTR ADD CONSTRAINT PK_NBUCONTR PRIMARY KEY (PID, DATE_C)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NBUCONTR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NBUCONTR ON BARS.NBU_CONTR (PID, DATE_C) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBU_CONTR ***
grant SELECT                                                                 on NBU_CONTR       to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on NBU_CONTR       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBU_CONTR       to BARS_DM;
grant SELECT                                                                 on NBU_CONTR       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NBU_CONTR       to WR_ALL_RIGHTS;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on NBU_CONTR       to ZAY;



PROMPT *** Create SYNONYM  to NBU_CONTR ***

  CREATE OR REPLACE PUBLIC SYNONYM NBU_CONTR FOR BARS.NBU_CONTR;


PROMPT *** Create SYNONYM  to NBU_CONTR ***

  CREATE OR REPLACE PUBLIC SYNONYM NBU_CONTR1 FOR BARS.NBU_CONTR;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBU_CONTR.sql =========*** End *** ===
PROMPT ===================================================================================== 
