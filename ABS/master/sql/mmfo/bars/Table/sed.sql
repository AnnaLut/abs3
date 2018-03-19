

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SED.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SED ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SED'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SED'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SED'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SED ***
begin 
  execute immediate '
  CREATE TABLE BARS.SED 
   (	SED CHAR(4), 
	NAME VARCHAR2(96), 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SED ***
 exec bpa.alter_policies('SED');


COMMENT ON TABLE BARS.SED IS 'Справочник отраслей экономики';
COMMENT ON COLUMN BARS.SED.SED IS 'Код отрасли экономики';
COMMENT ON COLUMN BARS.SED.NAME IS 'Наименование отрасли экономики';
COMMENT ON COLUMN BARS.SED.D_CLOSE IS 'Дата отмены норматива';




PROMPT *** Create  constraint PK_SED ***
begin   
 execute immediate '
  ALTER TABLE BARS.SED ADD CONSTRAINT PK_SED PRIMARY KEY (SED)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SED_DCLOSE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SED ADD CONSTRAINT CC_SED_DCLOSE CHECK ( d_close = trunc(d_close)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007991 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SED MODIFY (SED NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SED_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SED MODIFY (NAME CONSTRAINT CC_SED_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SED ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SED ON BARS.SED (SED) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SED ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SED             to ABS_ADMIN;
grant SELECT                                                                 on SED             to BARSREADER_ROLE;
grant SELECT                                                                 on SED             to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SED             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SED             to BARS_DM;
grant SELECT                                                                 on SED             to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on SED             to SED;
grant SELECT                                                                 on SED             to START1;
grant SELECT                                                                 on SED             to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SED             to WR_ALL_RIGHTS;
grant SELECT                                                                 on SED             to WR_CUSTREG;
grant FLASHBACK,SELECT                                                       on SED             to WR_REFREAD;
grant SELECT                                                                 on SED             to BARS_INTGR;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SED.sql =========*** End *** =========
PROMPT ===================================================================================== 
