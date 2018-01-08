

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FM_STABLE_PARTNER_ARC.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FM_STABLE_PARTNER_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FM_STABLE_PARTNER_ARC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''FM_STABLE_PARTNER_ARC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FM_STABLE_PARTNER_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.FM_STABLE_PARTNER_ARC 
   (	DAT DATE, 
	RNK VARCHAR2(30), 
	PARTNER_LIST VARCHAR2(4000), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FM_STABLE_PARTNER_ARC ***
 exec bpa.alter_policies('FM_STABLE_PARTNER_ARC');


COMMENT ON TABLE BARS.FM_STABLE_PARTNER_ARC IS 'Архив основных контрагентов (ФМ отчеты)';
COMMENT ON COLUMN BARS.FM_STABLE_PARTNER_ARC.DAT IS '';
COMMENT ON COLUMN BARS.FM_STABLE_PARTNER_ARC.RNK IS 'РНК (для клиентов с окпо 00000) или ОКПО';
COMMENT ON COLUMN BARS.FM_STABLE_PARTNER_ARC.PARTNER_LIST IS 'список постоянных контрагентов';
COMMENT ON COLUMN BARS.FM_STABLE_PARTNER_ARC.KF IS '';




PROMPT *** Create  index I_FM_STPARTNERARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.I_FM_STPARTNERARC ON BARS.FM_STABLE_PARTNER_ARC (DAT, RNK, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FM_STABLE_PARTNER_ARC ***
grant SELECT                                                                 on FM_STABLE_PARTNER_ARC to BARSREADER_ROLE;
grant SELECT                                                                 on FM_STABLE_PARTNER_ARC to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FM_STABLE_PARTNER_ARC to BARS_DM;
grant SELECT                                                                 on FM_STABLE_PARTNER_ARC to START1;
grant SELECT                                                                 on FM_STABLE_PARTNER_ARC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FM_STABLE_PARTNER_ARC.sql =========***
PROMPT ===================================================================================== 
