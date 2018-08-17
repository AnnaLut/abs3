

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SK_ASVO_FDPI.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SK_ASVO_FDPI ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SK_ASVO_FDPI'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SK_ASVO_FDPI'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SK_ASVO_FDPI'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/


PROMPT *** Create  table SK_ASVO_FDPI ***
begin 
  execute immediate '
    create table BARS.SK_ASVO_FDPI
    (
      branch   VARCHAR2(30),
      acc_card VARCHAR2(10),
      mark     VARCHAR2(1),
      datprc   DATE,
      prc      NUMBER(6,2),
      num_load   NUMBER(38,0),
      KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
    )
    SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to SK_ASVO_FDPI ***
 exec bpa.alter_policies('SK_ASVO_FDPI');

COMMENT ON COLUMN BARS.SK_ASVO_FDPI.NUM_LOAD IS 'Номер відповідного завантаження';
 
PROMPT *** Create  index ASVO_FDPI_LOAD ***
begin   
 execute immediate '
  CREATE INDEX BARS.ASVO_FDPI_LOAD ON BARS.SK_ASVO_FDPI (NUM_LOAD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/  


PROMPT *** Create  grants  SK_ASVO_FDPI ***

grant DELETE,INSERT,SELECT,UPDATE                                            on SK_ASVO_FDPI       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SK_ASVO_FDPI       to BARSR;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SK_ASVO_FDPI.sql =========*** End *** ===
PROMPT ===================================================================================== 
