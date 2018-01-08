

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DK.sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DK'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DK ***
begin 
  execute immediate '
  CREATE TABLE BARS.DK 
   (	DK NUMBER(1,0), 
	NAME VARCHAR2(35), 
	MNEMONIK CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DK ***
 exec bpa.alter_policies('DK');


COMMENT ON TABLE BARS.DK IS 'Виды межбанковских документов';
COMMENT ON COLUMN BARS.DK.DK IS 'Признак дебета-кредита';
COMMENT ON COLUMN BARS.DK.NAME IS 'Описание';
COMMENT ON COLUMN BARS.DK.MNEMONIK IS 'Мнемоническое обозначение';




PROMPT *** Create  constraint PK_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.DK ADD CONSTRAINT PK_DK PRIMARY KEY (DK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DK_DK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DK MODIFY (DK CONSTRAINT CC_DK_DK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DK_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DK MODIFY (NAME CONSTRAINT CC_DK_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DK_MNEMONIK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DK MODIFY (MNEMONIK CONSTRAINT CC_DK_MNEMONIK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DK ON BARS.DK (DK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DK              to ABS_ADMIN;
grant SELECT                                                                 on DK              to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DK              to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DK              to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DK              to DK;
grant SELECT                                                                 on DK              to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DK              to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DK              to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DK.sql =========*** End *** ==========
PROMPT ===================================================================================== 
