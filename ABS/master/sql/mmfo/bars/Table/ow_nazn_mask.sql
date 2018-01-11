

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_NAZN_MASK.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_NAZN_MASK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_NAZN_MASK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OW_NAZN_MASK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OW_NAZN_MASK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_NAZN_MASK ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_NAZN_MASK 
   (	MASKID VARCHAR2(30), 
	NAZN VARCHAR2(160)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_NAZN_MASK ***
 exec bpa.alter_policies('OW_NAZN_MASK');


COMMENT ON TABLE BARS.OW_NAZN_MASK IS 'OpenWay. Описание масок назначений плажей';
COMMENT ON COLUMN BARS.OW_NAZN_MASK.MASKID IS 'Маска назначения платежа (SynthCode)';
COMMENT ON COLUMN BARS.OW_NAZN_MASK.NAZN IS 'Назначение платежа';




PROMPT *** Create  constraint PK_OWNAZNMASK ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_NAZN_MASK ADD CONSTRAINT PK_OWNAZNMASK PRIMARY KEY (MASKID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWNAZNMASK_MASKID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_NAZN_MASK MODIFY (MASKID CONSTRAINT CC_OWNAZNMASK_MASKID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWNAZNMASK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWNAZNMASK ON BARS.OW_NAZN_MASK (MASKID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_NAZN_MASK ***
grant SELECT                                                                 on OW_NAZN_MASK    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_NAZN_MASK    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OW_NAZN_MASK    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_NAZN_MASK    to OW;
grant SELECT                                                                 on OW_NAZN_MASK    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_NAZN_MASK.sql =========*** End *** 
PROMPT ===================================================================================== 
