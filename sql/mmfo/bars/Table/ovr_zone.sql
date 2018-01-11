

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OVR_ZONE.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OVR_ZONE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OVR_ZONE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OVR_ZONE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OVR_ZONE ***
begin 
  execute immediate '
  CREATE TABLE BARS.OVR_ZONE 
   (	ID NUMBER, 
	NAME VARCHAR2(30), 
	COUNTD NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OVR_ZONE ***
 exec bpa.alter_policies('OVR_ZONE');


COMMENT ON TABLE BARS.OVR_ZONE IS 'Причини, що зумовлюють призупинення надання Оверд';
COMMENT ON COLUMN BARS.OVR_ZONE.ID IS 'Код причини';
COMMENT ON COLUMN BARS.OVR_ZONE.NAME IS 'Опис причини';
COMMENT ON COLUMN BARS.OVR_ZONE.COUNTD IS 'Кількість днів до відтемування';




PROMPT *** Create  constraint XPK_OVRZONE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OVR_ZONE ADD CONSTRAINT XPK_OVRZONE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_OVRZONE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_OVRZONE ON BARS.OVR_ZONE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OVR_ZONE ***
grant SELECT                                                                 on OVR_ZONE        to BARSREADER_ROLE;
grant SELECT                                                                 on OVR_ZONE        to START1;
grant SELECT                                                                 on OVR_ZONE        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OVR_ZONE.sql =========*** End *** ====
PROMPT ===================================================================================== 
