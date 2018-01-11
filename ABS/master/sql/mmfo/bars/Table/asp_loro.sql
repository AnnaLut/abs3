

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ASP_LORO.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ASP_LORO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ASP_LORO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ASP_LORO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ASP_LORO ***
begin 
  execute immediate '
  CREATE TABLE BARS.ASP_LORO 
   (	OKPO VARCHAR2(14), 
	NAME VARCHAR2(38), 
	STAT CHAR(1), 
	MFO VARCHAR2(12)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ASP_LORO ***
 exec bpa.alter_policies('ASP_LORO');


COMMENT ON TABLE BARS.ASP_LORO IS 'Клиенты ЛОРО-банков (деклар. в 1-ПБ)';
COMMENT ON COLUMN BARS.ASP_LORO.OKPO IS 'ОКПО';
COMMENT ON COLUMN BARS.ASP_LORO.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.ASP_LORO.STAT IS 'Статус (U,S,F)';
COMMENT ON COLUMN BARS.ASP_LORO.MFO IS 'Код ЛОРО-банка';




PROMPT *** Create  constraint SYS_C00132249 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASP_LORO MODIFY (OKPO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint ASP_LORO_OKPO ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASP_LORO ADD CONSTRAINT ASP_LORO_OKPO PRIMARY KEY (OKPO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index ASP_LORO_OKPO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.ASP_LORO_OKPO ON BARS.ASP_LORO (OKPO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ASP_LORO ***
grant SELECT                                                                 on ASP_LORO        to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on ASP_LORO        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ASP_LORO        to RPBN002;
grant SELECT                                                                 on ASP_LORO        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ASP_LORO.sql =========*** End *** ====
PROMPT ===================================================================================== 
