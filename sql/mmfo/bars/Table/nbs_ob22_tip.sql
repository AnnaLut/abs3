

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBS_OB22_TIP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBS_OB22_TIP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBS_OB22_TIP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NBS_OB22_TIP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBS_OB22_TIP ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBS_OB22_TIP 
   (	NBS CHAR(4), 
	OB22 VARCHAR2(2), 
	TIP VARCHAR2(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBS_OB22_TIP ***
 exec bpa.alter_policies('NBS_OB22_TIP');


COMMENT ON TABLE BARS.NBS_OB22_TIP IS '';
COMMENT ON COLUMN BARS.NBS_OB22_TIP.NBS IS '';
COMMENT ON COLUMN BARS.NBS_OB22_TIP.OB22 IS '';
COMMENT ON COLUMN BARS.NBS_OB22_TIP.TIP IS '';




PROMPT *** Create  constraint XPK_NBS_OB22_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_OB22_TIP ADD CONSTRAINT XPK_NBS_OB22_TIP PRIMARY KEY (NBS, OB22)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_NBS_OB22_TIP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_NBS_OB22_TIP ON BARS.NBS_OB22_TIP (NBS, OB22) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_NBS_OB22_TIP ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_NBS_OB22_TIP ON BARS.NBS_OB22_TIP (TIP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBS_OB22_TIP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NBS_OB22_TIP    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on NBS_OB22_TIP    to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on NBS_OB22_TIP    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBS_OB22_TIP.sql =========*** End *** 
PROMPT ===================================================================================== 
