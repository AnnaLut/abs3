

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_SEC.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_SEC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_SEC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_SEC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CC_SEC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_SEC ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_SEC 
   (	OKPO VARCHAR2(14), 
	NOTESEC VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_SEC ***
 exec bpa.alter_policies('CC_SEC');


COMMENT ON TABLE BARS.CC_SEC IS 'Список небажаних клiєнтiв';
COMMENT ON COLUMN BARS.CC_SEC.OKPO IS 'Iд.Код клiєнта';
COMMENT ON COLUMN BARS.CC_SEC.NOTESEC IS 'Примiтки служби безопеки';




PROMPT *** Create  constraint PK_CC_SEC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SEC ADD CONSTRAINT PK_CC_SEC PRIMARY KEY (OKPO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CC_SEC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CC_SEC ON BARS.CC_SEC (OKPO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_SEC ***
grant SELECT                                                                 on CC_SEC          to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_SEC          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_SEC          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_SEC          to RCC_DEAL;
grant SELECT                                                                 on CC_SEC          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_SEC          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CC_SEC          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_SEC.sql =========*** End *** ======
PROMPT ===================================================================================== 
