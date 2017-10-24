

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SK.sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SK'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SK ***
begin 
  execute immediate '
  CREATE TABLE BARS.SK 
   (	SK NUMBER(2,0), 
	NAME VARCHAR2(105), 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SK ***
 exec bpa.alter_policies('SK');


COMMENT ON TABLE BARS.SK IS 'Символа касс-плана';
COMMENT ON COLUMN BARS.SK.SK IS 'Символа касс-плана';
COMMENT ON COLUMN BARS.SK.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.SK.D_CLOSE IS 'Дата исключения символа';




PROMPT *** Create  constraint PK_SK ***
begin   
 execute immediate '
  ALTER TABLE BARS.SK ADD CONSTRAINT PK_SK PRIMARY KEY (SK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SK_SK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SK MODIFY (SK CONSTRAINT CC_SK_SK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SK_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SK MODIFY (NAME CONSTRAINT CC_SK_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SK ON BARS.SK (SK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SK              to ABS_ADMIN;
grant SELECT                                                                 on SK              to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SK              to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SK              to BARS_DM;
grant SELECT                                                                 on SK              to RPBN002;
grant DELETE,INSERT,SELECT,UPDATE                                            on SK              to SK;
grant DELETE,INSERT,SELECT,UPDATE                                            on SK              to START1;
grant SELECT                                                                 on SK              to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SK              to WR_ALL_RIGHTS;
grant SELECT                                                                 on SK              to WR_DOCHAND;
grant SELECT                                                                 on SK              to WR_DOC_INPUT;
grant SELECT                                                                 on SK              to WR_KP;
grant FLASHBACK,SELECT                                                       on SK              to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SK.sql =========*** End *** ==========
PROMPT ===================================================================================== 
