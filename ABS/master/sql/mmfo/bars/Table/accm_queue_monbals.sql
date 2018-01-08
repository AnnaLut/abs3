

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCM_QUEUE_MONBALS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCM_QUEUE_MONBALS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCM_QUEUE_MONBALS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACCM_QUEUE_MONBALS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACCM_QUEUE_MONBALS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCM_QUEUE_MONBALS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCM_QUEUE_MONBALS 
   (	FDAT DATE, 
	 CONSTRAINT PK_ACCMQUEMBALS PRIMARY KEY (FDAT) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYNI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCM_QUEUE_MONBALS ***
 exec bpa.alter_policies('ACCM_QUEUE_MONBALS');


COMMENT ON TABLE BARS.ACCM_QUEUE_MONBALS IS 'Подсистема накопления. Очередь синхронизации накопительных балансов (за год)';
COMMENT ON COLUMN BARS.ACCM_QUEUE_MONBALS.FDAT IS 'Год';




PROMPT *** Create  constraint CC_ACCMQUEMBALS_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_QUEUE_MONBALS MODIFY (FDAT CONSTRAINT CC_ACCMQUEMBALS_FDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACCMQUEMBALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_QUEUE_MONBALS ADD CONSTRAINT PK_ACCMQUEMBALS PRIMARY KEY (FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCMQUEMBALS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCMQUEMBALS ON BARS.ACCM_QUEUE_MONBALS (FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCM_QUEUE_MONBALS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCM_QUEUE_MONBALS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCM_QUEUE_MONBALS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCM_QUEUE_MONBALS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCM_QUEUE_MONBALS.sql =========*** En
PROMPT ===================================================================================== 
