

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BLK_CODES.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BLK_CODES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BLK_CODES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BLK_CODES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BLK_CODES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BLK_CODES ***
begin 
  execute immediate '
  CREATE TABLE BARS.BLK_CODES 
   (	BLK NUMBER(*,0), 
	NAME VARCHAR2(32)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BLK_CODES ***
 exec bpa.alter_policies('BLK_CODES');


COMMENT ON TABLE BARS.BLK_CODES IS 'Коды блокировок участников расчетов';
COMMENT ON COLUMN BARS.BLK_CODES.BLK IS 'Код блокировки участника расчетов';
COMMENT ON COLUMN BARS.BLK_CODES.NAME IS 'Семантика кода блокировки участника расчетов';




PROMPT *** Create  constraint XPK_BLK_CODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.BLK_CODES ADD CONSTRAINT XPK_BLK_CODES PRIMARY KEY (BLK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_BLK_CODES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_BLK_CODES ON BARS.BLK_CODES (BLK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BLK_CODES ***
grant SELECT                                                                 on BLK_CODES       to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BLK_CODES       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BLK_CODES       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BLK_CODES       to BLK_CODES;
grant DELETE,INSERT,SELECT,UPDATE                                            on BLK_CODES       to SEP_ROLE;
grant SELECT                                                                 on BLK_CODES       to START1;
grant SELECT                                                                 on BLK_CODES       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BLK_CODES       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on BLK_CODES       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BLK_CODES.sql =========*** End *** ===
PROMPT ===================================================================================== 
