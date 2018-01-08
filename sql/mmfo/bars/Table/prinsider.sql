

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRINSIDER.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRINSIDER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PRINSIDER'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PRINSIDER'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PRINSIDER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PRINSIDER ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRINSIDER 
   (	PRINSIDER NUMBER(38,0), 
	PRINSIDERLV1 NUMBER(38,0), 
	NAME VARCHAR2(254), 
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




PROMPT *** ALTER_POLICIES to PRINSIDER ***
 exec bpa.alter_policies('PRINSIDER');


COMMENT ON TABLE BARS.PRINSIDER IS 'Признак инсайдера';
COMMENT ON COLUMN BARS.PRINSIDER.PRINSIDER IS 'Признак инсайдера';
COMMENT ON COLUMN BARS.PRINSIDER.PRINSIDERLV1 IS 'Пр инсайдера 1-го уровня';
COMMENT ON COLUMN BARS.PRINSIDER.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.PRINSIDER.D_OPEN IS 'Дата відкриття коду';
COMMENT ON COLUMN BARS.PRINSIDER.D_CLOSE IS 'Дата закриття коду';




PROMPT *** Create  constraint PK_PRINSIDER ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRINSIDER ADD CONSTRAINT PK_PRINSIDER PRIMARY KEY (PRINSIDER)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005228 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRINSIDER MODIFY (PRINSIDER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRINSIDER_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRINSIDER MODIFY (NAME CONSTRAINT CC_PRINSIDER_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PRINSIDER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PRINSIDER ON BARS.PRINSIDER (PRINSIDER) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PRINSIDER ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PRINSIDER       to ABS_ADMIN;
grant SELECT                                                                 on PRINSIDER       to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on PRINSIDER       to BARSREADER_ROLE;
grant SELECT                                                                 on PRINSIDER       to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PRINSIDER       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PRINSIDER       to BARS_DM;
grant SELECT                                                                 on PRINSIDER       to CUST001;
grant SELECT                                                                 on PRINSIDER       to RPBN002;
grant SELECT                                                                 on PRINSIDER       to START1;
grant SELECT                                                                 on PRINSIDER       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PRINSIDER       to WR_ALL_RIGHTS;
grant SELECT                                                                 on PRINSIDER       to WR_CUSTREG;
grant FLASHBACK,SELECT                                                       on PRINSIDER       to WR_REFREAD;



PROMPT *** Create SYNONYM  to PRINSIDER ***

  CREATE OR REPLACE PUBLIC SYNONYM PRINSIDER FOR BARS.PRINSIDER;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRINSIDER.sql =========*** End *** ===
PROMPT ===================================================================================== 
