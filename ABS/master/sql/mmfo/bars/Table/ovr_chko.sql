

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OVR_CHKO.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OVR_CHKO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OVR_CHKO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OVR_CHKO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OVR_CHKO ***
begin 
  execute immediate '
  CREATE TABLE BARS.OVR_CHKO 
   (	ACC NUMBER, 
	DATM DATE, 
	S NUMBER, 
	PR NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OVR_CHKO ***
 exec bpa.alter_policies('OVR_CHKO');


COMMENT ON TABLE BARS.OVR_CHKO IS 'Суммарные ЧКО';
COMMENT ON COLUMN BARS.OVR_CHKO.ACC IS 'счет 2600-участник';
COMMENT ON COLUMN BARS.OVR_CHKO.DATM IS 'Дата в мес';
COMMENT ON COLUMN BARS.OVR_CHKO.S IS 'Сумма';
COMMENT ON COLUMN BARS.OVR_CHKO.PR IS '№ группы. 0 -АБС';




PROMPT *** Create  constraint XPK_OVRCHKO ***
begin   
 execute immediate '
  ALTER TABLE BARS.OVR_CHKO ADD CONSTRAINT XPK_OVRCHKO PRIMARY KEY (ACC, DATM, PR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_OVRCHKO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_OVRCHKO ON BARS.OVR_CHKO (ACC, DATM, PR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OVR_CHKO ***
grant SELECT                                                                 on OVR_CHKO        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OVR_CHKO        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OVR_CHKO.sql =========*** End *** ====
PROMPT ===================================================================================== 
