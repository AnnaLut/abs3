

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SV_VOICE.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SV_VOICE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SV_VOICE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SV_VOICE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SV_VOICE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SV_VOICE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SV_VOICE 
   (	ID NUMBER(10,0), 
	VIDSOTOK NUMBER(7,4), 
	VOICE NUMBER(16,0), 
	DOC_NUM VARCHAR2(100), 
	DOC_DATE DATE, 
	OWNER_ID_TO NUMBER, 
	OWNER_ID_FROM NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SV_VOICE ***
 exec bpa.alter_policies('SV_VOICE');


COMMENT ON TABLE BARS.SV_VOICE IS 'Інформація про набуття права голосу';
COMMENT ON COLUMN BARS.SV_VOICE.ID IS 'Ид.';
COMMENT ON COLUMN BARS.SV_VOICE.VIDSOTOK IS 'Відсотки статутного капіталу банку';
COMMENT ON COLUMN BARS.SV_VOICE.VOICE IS 'Кількість голосів';
COMMENT ON COLUMN BARS.SV_VOICE.DOC_NUM IS 'Номер доручення';
COMMENT ON COLUMN BARS.SV_VOICE.DOC_DATE IS 'Дата доручення';
COMMENT ON COLUMN BARS.SV_VOICE.OWNER_ID_TO IS 'Ид. особи, якій передані голоси';
COMMENT ON COLUMN BARS.SV_VOICE.OWNER_ID_FROM IS 'Ид. особи, яка передала голоси';




PROMPT *** Create  constraint PK_SVVOICE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_VOICE ADD CONSTRAINT PK_SVVOICE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVVOICE_DOC_DATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_VOICE ADD CONSTRAINT CC_SVVOICE_DOC_DATE_NN CHECK (DOC_DATE IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVVOICE_DOC_NUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_VOICE ADD CONSTRAINT CC_SVVOICE_DOC_NUM_NN CHECK (DOC_NUM IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVVOICE_OWNER_ID_FROM ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_VOICE ADD CONSTRAINT CC_SVVOICE_OWNER_ID_FROM CHECK (OWNER_ID_FROM IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVVOICE_OWNER_ID_TO ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_VOICE ADD CONSTRAINT CC_SVVOICE_OWNER_ID_TO CHECK (OWNER_ID_TO IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005736 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_VOICE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SVVOICE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SVVOICE ON BARS.SV_VOICE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SV_VOICE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SV_VOICE        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SV_VOICE        to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SV_VOICE.sql =========*** End *** ====
PROMPT ===================================================================================== 
