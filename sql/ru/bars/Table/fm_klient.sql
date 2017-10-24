

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FM_KLIENT.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FM_KLIENT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FM_KLIENT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FM_KLIENT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FM_KLIENT ***
begin 
  execute immediate '
  CREATE TABLE BARS.FM_KLIENT 
   (	RNK NUMBER(22,0), 
	KOD NUMBER(22,0), 
	DAT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FM_KLIENT ***
 exec bpa.alter_policies('FM_KLIENT');


COMMENT ON TABLE BARS.FM_KLIENT IS 'ФМ. Підозрілі клієнти';
COMMENT ON COLUMN BARS.FM_KLIENT.RNK IS 'РНК';
COMMENT ON COLUMN BARS.FM_KLIENT.KOD IS '№ особи з Переліку осіб';
COMMENT ON COLUMN BARS.FM_KLIENT.DAT IS 'Дата звірки';




PROMPT *** Create  constraint PK_FMKLIENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_KLIENT ADD CONSTRAINT PK_FMKLIENT PRIMARY KEY (RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FMKLIENT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FMKLIENT ON BARS.FM_KLIENT (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FM_KLIENT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on FM_KLIENT       to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FM_KLIENT.sql =========*** End *** ===
PROMPT ===================================================================================== 
