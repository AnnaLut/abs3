

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PF_TT3800.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PF_TT3800 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PF_TT3800'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PF_TT3800'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PF_TT3800'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PF_TT3800 ***
begin 
  execute immediate '
  CREATE TABLE BARS.PF_TT3800 
   (	TT CHAR(3), 
	NAL NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PF_TT3800 ***
 exec bpa.alter_policies('PF_TT3800');


COMMENT ON TABLE BARS.PF_TT3800 IS 'Операции Выкупа валюты банком у ФЛ и ЮЛ  и требуют перечисления в Пенс.фонд';
COMMENT ON COLUMN BARS.PF_TT3800.TT IS 'Код операции';
COMMENT ON COLUMN BARS.PF_TT3800.NAL IS '';




PROMPT *** Create  constraint PK_PFTT3800 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PF_TT3800 ADD CONSTRAINT PK_PFTT3800 PRIMARY KEY (TT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFTT3800 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PFTT3800 ON BARS.PF_TT3800 (TT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PF_TT3800 ***
grant SELECT                                                                 on PF_TT3800       to BARSREADER_ROLE;
grant SELECT                                                                 on PF_TT3800       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PF_TT3800       to BARS_DM;
grant SELECT                                                                 on PF_TT3800       to START1;
grant SELECT                                                                 on PF_TT3800       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PF_TT3800.sql =========*** End *** ===
PROMPT ===================================================================================== 
