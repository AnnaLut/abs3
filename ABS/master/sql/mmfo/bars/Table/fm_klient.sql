

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FM_KLIENT.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FM_KLIENT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FM_KLIENT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FM_KLIENT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
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
	DAT DATE, 
	REL_RNK NUMBER, 
	REL_INTEXT NUMBER(1,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'', ''user_mfo'')
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
COMMENT ON COLUMN BARS.FM_KLIENT.REL_RNK IS '';
COMMENT ON COLUMN BARS.FM_KLIENT.REL_INTEXT IS '';
COMMENT ON COLUMN BARS.FM_KLIENT.KF IS '';




PROMPT *** Create  constraint SYS_C00119411 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_KLIENT MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UI_FM_KLIENT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UI_FM_KLIENT ON BARS.FM_KLIENT (RNK, KOD, CASE  WHEN REL_RNK IS NOT NULL THEN REL_RNK END , CASE  WHEN REL_INTEXT IS NOT NULL THEN REL_INTEXT END ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FM_KLIENT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on FM_KLIENT       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FM_KLIENT       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FM_KLIENT       to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FM_KLIENT.sql =========*** End *** ===
PROMPT ===================================================================================== 
