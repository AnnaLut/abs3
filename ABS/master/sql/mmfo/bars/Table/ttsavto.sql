

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TTSAVTO.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TTSAVTO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TTSAVTO'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TTSAVTO'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TTSAVTO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TTSAVTO ***
begin 
  execute immediate '
  CREATE TABLE BARS.TTSAVTO 
   (	TT CHAR(3), 
	COMM VARCHAR2(20)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TTSAVTO ***
 exec bpa.alter_policies('TTSAVTO');


COMMENT ON TABLE BARS.TTSAVTO IS 'Коды авто-операций для свода ДТ проводок дня';
COMMENT ON COLUMN BARS.TTSAVTO.TT IS 'Код операции';
COMMENT ON COLUMN BARS.TTSAVTO.COMM IS 'Комментарий';




PROMPT *** Create  constraint PK_TTSAVTO ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTSAVTO ADD CONSTRAINT PK_TTSAVTO PRIMARY KEY (TT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008001 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTSAVTO MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TTSAVTO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TTSAVTO ON BARS.TTSAVTO (TT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TTSAVTO ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TTSAVTO         to ABS_ADMIN;
grant SELECT                                                                 on TTSAVTO         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TTSAVTO         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TTSAVTO         to BARS_DM;
grant SELECT                                                                 on TTSAVTO         to START1;
grant SELECT                                                                 on TTSAVTO         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TTSAVTO         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TTSAVTO.sql =========*** End *** =====
PROMPT ===================================================================================== 
