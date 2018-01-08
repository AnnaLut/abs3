

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_2H_ANKETA_DET.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_2H_ANKETA_DET ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_2H_ANKETA_DET'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_2H_ANKETA_DET'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_2H_ANKETA_DET'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_2H_ANKETA_DET ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_2H_ANKETA_DET 
   (	CODE_QUEST VARCHAR2(3), 
	CODE_ANSW VARCHAR2(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_2H_ANKETA_DET ***
 exec bpa.alter_policies('OTCN_2H_ANKETA_DET');


COMMENT ON TABLE BARS.OTCN_2H_ANKETA_DET IS '';
COMMENT ON COLUMN BARS.OTCN_2H_ANKETA_DET.CODE_QUEST IS 'Код запитання';
COMMENT ON COLUMN BARS.OTCN_2H_ANKETA_DET.CODE_ANSW IS 'Код відповіді';




PROMPT *** Create  constraint SYS_C0012794 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_2H_ANKETA_DET ADD PRIMARY KEY (CODE_QUEST, CODE_ANSW)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007432 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_2H_ANKETA_DET MODIFY (CODE_QUEST NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007433 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_2H_ANKETA_DET MODIFY (CODE_ANSW NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0012794 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0012794 ON BARS.OTCN_2H_ANKETA_DET (CODE_QUEST, CODE_ANSW) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_2H_ANKETA_DET ***
grant SELECT                                                                 on OTCN_2H_ANKETA_DET to BARSREADER_ROLE;
grant SELECT                                                                 on OTCN_2H_ANKETA_DET to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OTCN_2H_ANKETA_DET to BARS_DM;
grant SELECT                                                                 on OTCN_2H_ANKETA_DET to RPBN002;
grant SELECT                                                                 on OTCN_2H_ANKETA_DET to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_2H_ANKETA_DET.sql =========*** En
PROMPT ===================================================================================== 
