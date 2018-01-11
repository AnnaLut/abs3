

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PAP.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PAP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PAP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PAP'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PAP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PAP ***
begin 
  execute immediate '
  CREATE TABLE BARS.PAP 
   (	PAP NUMBER(1,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PAP ***
 exec bpa.alter_policies('PAP');


COMMENT ON TABLE BARS.PAP IS 'Признак счета - Актив/Пассив/Акт-Пас';
COMMENT ON COLUMN BARS.PAP.PAP IS 'Признак';
COMMENT ON COLUMN BARS.PAP.NAME IS 'Наименование';




PROMPT *** Create  constraint CC_PAP_PAP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PAP MODIFY (PAP CONSTRAINT CC_PAP_PAP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PAP_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PAP MODIFY (NAME CONSTRAINT CC_PAP_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PAP ***
begin   
 execute immediate '
  ALTER TABLE BARS.PAP ADD CONSTRAINT PK_PAP PRIMARY KEY (PAP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PAP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PAP ON BARS.PAP (PAP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PAP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PAP             to ABS_ADMIN;
grant SELECT                                                                 on PAP             to BARSREADER_ROLE;
grant SELECT                                                                 on PAP             to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PAP             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PAP             to BARS_DM;
grant SELECT                                                                 on PAP             to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on PAP             to PAP;
grant SELECT                                                                 on PAP             to START1;
grant SELECT                                                                 on PAP             to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PAP             to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on PAP             to WR_REFREAD;
grant SELECT                                                                 on PAP             to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PAP.sql =========*** End *** =========
PROMPT ===================================================================================== 
