

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INT_RATN_MB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INT_RATN_MB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INT_RATN_MB'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''INT_RATN_MB'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INT_RATN_MB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INT_RATN_MB ***
begin 
  execute immediate '
  CREATE TABLE BARS.INT_RATN_MB 
   (	FDAT DATE, 
	KV NUMBER(*,0), 
	TERM NUMBER(*,0), 
	IR NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INT_RATN_MB ***
 exec bpa.alter_policies('INT_RATN_MB');


COMMENT ON TABLE BARS.INT_RATN_MB IS 'Процентні ставки на ресурси на М/Б ринку';
COMMENT ON COLUMN BARS.INT_RATN_MB.FDAT IS 'Дата~встановлення~(початку дії)';
COMMENT ON COLUMN BARS.INT_RATN_MB.KV IS 'Код~вал~ресурсу';
COMMENT ON COLUMN BARS.INT_RATN_MB.TERM IS 'Термін~розміщення~в днях';
COMMENT ON COLUMN BARS.INT_RATN_MB.IR IS 'Значення~річної~% ставки';




PROMPT *** Create  constraint PK_INTRATNMB ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN_MB ADD CONSTRAINT PK_INTRATNMB PRIMARY KEY (FDAT, KV, TERM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INTRATNMB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INTRATNMB ON BARS.INT_RATN_MB (FDAT, KV, TERM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INT_RATN_MB ***
grant SELECT                                                                 on INT_RATN_MB     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_RATN_MB     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INT_RATN_MB     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_RATN_MB     to START1;
grant SELECT                                                                 on INT_RATN_MB     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INT_RATN_MB.sql =========*** End *** =
PROMPT ===================================================================================== 
