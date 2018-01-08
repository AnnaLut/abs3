

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCM_QUEUE_YEARBALS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCM_QUEUE_YEARBALS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCM_QUEUE_YEARBALS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACCM_QUEUE_YEARBALS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACCM_QUEUE_YEARBALS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCM_QUEUE_YEARBALS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCM_QUEUE_YEARBALS 
   (	FDAT DATE, 
	 CONSTRAINT PK_ACCMQUEYBALS PRIMARY KEY (FDAT) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYNI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCM_QUEUE_YEARBALS ***
 exec bpa.alter_policies('ACCM_QUEUE_YEARBALS');


COMMENT ON TABLE BARS.ACCM_QUEUE_YEARBALS IS '';
COMMENT ON COLUMN BARS.ACCM_QUEUE_YEARBALS.FDAT IS '';




PROMPT *** Create  constraint CC_ACCMQUEYBALS_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_QUEUE_YEARBALS MODIFY (FDAT CONSTRAINT CC_ACCMQUEYBALS_FDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACCMQUEYBALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_QUEUE_YEARBALS ADD CONSTRAINT PK_ACCMQUEYBALS PRIMARY KEY (FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCMQUEYBALS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCMQUEYBALS ON BARS.ACCM_QUEUE_YEARBALS (FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCM_QUEUE_YEARBALS ***
grant SELECT                                                                 on ACCM_QUEUE_YEARBALS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCM_QUEUE_YEARBALS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCM_QUEUE_YEARBALS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCM_QUEUE_YEARBALS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCM_QUEUE_YEARBALS.sql =========*** E
PROMPT ===================================================================================== 
