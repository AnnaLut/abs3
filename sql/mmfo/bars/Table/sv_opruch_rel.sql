

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SV_OPRUCH_REL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SV_OPRUCH_REL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SV_OPRUCH_REL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SV_OPRUCH_REL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SV_OPRUCH_REL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SV_OPRUCH_REL ***
begin 
  execute immediate '
  CREATE TABLE BARS.SV_OPRUCH_REL 
   (	ID NUMBER(10,0), 
	OWNER_ID_TO NUMBER(10,0), 
	OWNER_ID_FROM NUMBER(10,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SV_OPRUCH_REL ***
 exec bpa.alter_policies('SV_OPRUCH_REL');


COMMENT ON TABLE BARS.SV_OPRUCH_REL IS 'Взаємозв’язки між особами у разі опосеред. участі';
COMMENT ON COLUMN BARS.SV_OPRUCH_REL.ID IS 'Ид.';
COMMENT ON COLUMN BARS.SV_OPRUCH_REL.OWNER_ID_TO IS 'Особа якій передана частка ';
COMMENT ON COLUMN BARS.SV_OPRUCH_REL.OWNER_ID_FROM IS 'Особа яка передала частку ';




PROMPT *** Create  constraint CC_SVOPRUCHREL_IDFROM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_OPRUCH_REL ADD CONSTRAINT CC_SVOPRUCHREL_IDFROM_NN CHECK (OWNER_ID_FROM IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVOPRUCHREL_IDTO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_OPRUCH_REL ADD CONSTRAINT CC_SVOPRUCHREL_IDTO_NN CHECK (OWNER_ID_TO IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVOPRUCHREL_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_OPRUCH_REL ADD CONSTRAINT CC_SVOPRUCHREL_ID_NN CHECK (ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SV_OPRUCH_REL ***
grant SELECT                                                                 on SV_OPRUCH_REL   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SV_OPRUCH_REL   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SV_OPRUCH_REL   to RPBN002;
grant SELECT                                                                 on SV_OPRUCH_REL   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SV_OPRUCH_REL.sql =========*** End ***
PROMPT ===================================================================================== 
