

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VPS_MFO.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VPS_MFO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VPS_MFO'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''VPS_MFO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''VPS_MFO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VPS_MFO ***
begin 
  execute immediate '
  CREATE TABLE BARS.VPS_MFO 
   (	MFO VARCHAR2(12)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VPS_MFO ***
 exec bpa.alter_policies('VPS_MFO');


COMMENT ON TABLE BARS.VPS_MFO IS '';
COMMENT ON COLUMN BARS.VPS_MFO.MFO IS '';




PROMPT *** Create  constraint XPK_VPS_MFO ***
begin   
 execute immediate '
  ALTER TABLE BARS.VPS_MFO ADD CONSTRAINT XPK_VPS_MFO PRIMARY KEY (MFO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009189 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VPS_MFO MODIFY (MFO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_VPS_MFO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_VPS_MFO ON BARS.VPS_MFO (MFO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VPS_MFO ***
grant DELETE,INSERT,SELECT,UPDATE                                            on VPS_MFO         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on VPS_MFO         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VPS_MFO.sql =========*** End *** =====
PROMPT ===================================================================================== 
