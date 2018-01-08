

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FM_PARTNER_ARC.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FM_PARTNER_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FM_PARTNER_ARC'', ''CENTER'' , ''C'', ''C'', ''C'', null);
               bpa.alter_policy_info(''FM_PARTNER_ARC'', ''FILIAL'' , ''F'', ''F'', ''F'', null);
               bpa.alter_policy_info(''FM_PARTNER_ARC'', ''WHOLE'' , ''C'', ''C'', ''C'', null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FM_PARTNER_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.FM_PARTNER_ARC 
   (	DAT DATE, 
	OKPO VARCHAR2(10), 
	PARTNER_LIST VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FM_PARTNER_ARC ***
 exec bpa.alter_policies('FM_PARTNER_ARC');


COMMENT ON TABLE BARS.FM_PARTNER_ARC IS 'Архив постоянных контрагентов по клиентам за квартал (для ФМ)';
COMMENT ON COLUMN BARS.FM_PARTNER_ARC.DAT IS 'Отчетная дата (первая дата квартала)';
COMMENT ON COLUMN BARS.FM_PARTNER_ARC.OKPO IS 'ОКПО клиента';
COMMENT ON COLUMN BARS.FM_PARTNER_ARC.PARTNER_LIST IS 'Список контагентов';




PROMPT *** Create  constraint PK_FMPARTNERARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_PARTNER_ARC ADD CONSTRAINT PK_FMPARTNERARC PRIMARY KEY (DAT, OKPO, PARTNER_LIST)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 166 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FMPARTNERARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FMPARTNERARC ON BARS.FM_PARTNER_ARC (DAT, OKPO, PARTNER_LIST) 
  PCTFREE 10 INITRANS 2 MAXTRANS 166 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FM_PARTNER_ARC ***
grant SELECT                                                                 on FM_PARTNER_ARC  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FM_PARTNER_ARC  to BARS_DM;
grant SELECT                                                                 on FM_PARTNER_ARC  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FM_PARTNER_ARC.sql =========*** End **
PROMPT ===================================================================================== 
