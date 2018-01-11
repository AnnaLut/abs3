

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_2H_ANKETA.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_2H_ANKETA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_2H_ANKETA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_2H_ANKETA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_2H_ANKETA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_2H_ANKETA ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_2H_ANKETA 
   (	DATF DATE, 
	CODE_QUEST VARCHAR2(3), 
	CODE_ANSW VARCHAR2(3), 
	COMM VARCHAR2(254)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_2H_ANKETA ***
 exec bpa.alter_policies('OTCN_2H_ANKETA');


COMMENT ON TABLE BARS.OTCN_2H_ANKETA IS '';
COMMENT ON COLUMN BARS.OTCN_2H_ANKETA.DATF IS 'Звітна дата';
COMMENT ON COLUMN BARS.OTCN_2H_ANKETA.CODE_QUEST IS 'Код запитання';
COMMENT ON COLUMN BARS.OTCN_2H_ANKETA.CODE_ANSW IS 'Код відповіді';
COMMENT ON COLUMN BARS.OTCN_2H_ANKETA.COMM IS 'Коментар';




PROMPT *** Create  constraint SYS_C0012659 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_2H_ANKETA ADD PRIMARY KEY (DATF, CODE_QUEST)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005474 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_2H_ANKETA MODIFY (DATF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005475 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_2H_ANKETA MODIFY (CODE_QUEST NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005476 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_2H_ANKETA MODIFY (CODE_ANSW NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0012659 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0012659 ON BARS.OTCN_2H_ANKETA (DATF, CODE_QUEST) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_2H_ANKETA ***
grant SELECT                                                                 on OTCN_2H_ANKETA  to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTCN_2H_ANKETA  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OTCN_2H_ANKETA  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_2H_ANKETA  to RPBN002;
grant SELECT                                                                 on OTCN_2H_ANKETA  to UPLD;
grant FLASHBACK,SELECT                                                       on OTCN_2H_ANKETA  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_2H_ANKETA.sql =========*** End **
PROMPT ===================================================================================== 
