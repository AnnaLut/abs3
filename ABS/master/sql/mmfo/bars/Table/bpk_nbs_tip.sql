

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BPK_NBS_TIP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BPK_NBS_TIP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BPK_NBS_TIP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BPK_NBS_TIP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BPK_NBS_TIP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BPK_NBS_TIP ***
begin 
  execute immediate '
  CREATE TABLE BARS.BPK_NBS_TIP 
   (	NBS CHAR(4), 
	TIP CHAR(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BPK_NBS_TIP ***
 exec bpa.alter_policies('BPK_NBS_TIP');


COMMENT ON TABLE BARS.BPK_NBS_TIP IS 'Таблица соответствия бал.счета и типа счета для БПК';
COMMENT ON COLUMN BARS.BPK_NBS_TIP.NBS IS 'Бал.счет';
COMMENT ON COLUMN BARS.BPK_NBS_TIP.TIP IS 'Тип счета';




PROMPT *** Create  constraint PK_BPKNBSTIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_NBS_TIP ADD CONSTRAINT PK_BPKNBSTIP PRIMARY KEY (NBS, TIP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BPKNBSTIP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BPKNBSTIP ON BARS.BPK_NBS_TIP (NBS, TIP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BPK_NBS_TIP ***
grant SELECT                                                                 on BPK_NBS_TIP     to BARSREADER_ROLE;
grant SELECT                                                                 on BPK_NBS_TIP     to BARS_DM;
grant SELECT                                                                 on BPK_NBS_TIP     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BPK_NBS_TIP.sql =========*** End *** =
PROMPT ===================================================================================== 
