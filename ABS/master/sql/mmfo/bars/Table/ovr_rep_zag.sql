

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OVR_REP_ZAG.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OVR_REP_ZAG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OVR_REP_ZAG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OVR_REP_ZAG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OVR_REP_ZAG ***
begin 
  execute immediate '
  CREATE TABLE BARS.OVR_REP_ZAG 
   (	ACC NUMBER, 
	NPP NUMBER(*,0), 
	TXT VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OVR_REP_ZAG ***
 exec bpa.alter_policies('OVR_REP_ZAG');


COMMENT ON TABLE BARS.OVR_REP_ZAG IS 'Шаблон заголовків повідомлення кл про зміну ГЛО';
COMMENT ON COLUMN BARS.OVR_REP_ZAG.NPP IS '№ п/п';
COMMENT ON COLUMN BARS.OVR_REP_ZAG.TXT IS 'Текст';
COMMENT ON COLUMN BARS.OVR_REP_ZAG.ACC IS 'счет 2600-участник';




PROMPT *** Create  constraint XPK_OVRREPZAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.OVR_REP_ZAG ADD CONSTRAINT XPK_OVRREPZAG PRIMARY KEY (ACC, NPP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_OVRREPZAG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_OVRREPZAG ON BARS.OVR_REP_ZAG (ACC, NPP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OVR_REP_ZAG ***
grant SELECT                                                                 on OVR_REP_ZAG     to BARSREADER_ROLE;
grant SELECT                                                                 on OVR_REP_ZAG     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OVR_REP_ZAG     to START1;
grant SELECT                                                                 on OVR_REP_ZAG     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OVR_REP_ZAG.sql =========*** End *** =
PROMPT ===================================================================================== 
