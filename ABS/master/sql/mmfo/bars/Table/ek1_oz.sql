

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EK1_OZ.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EK1_OZ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EK1_OZ'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EK1_OZ'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EK1_OZ'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EK1_OZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.EK1_OZ 
   (	NBS VARCHAR2(4), 
	NAME VARCHAR2(40), 
	PAP NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EK1_OZ ***
 exec bpa.alter_policies('EK1_OZ');


COMMENT ON TABLE BARS.EK1_OZ IS '';
COMMENT ON COLUMN BARS.EK1_OZ.NBS IS '';
COMMENT ON COLUMN BARS.EK1_OZ.NAME IS '';
COMMENT ON COLUMN BARS.EK1_OZ.PAP IS '';




PROMPT *** Create  constraint XPK_EK1_OZ ***
begin   
 execute immediate '
  ALTER TABLE BARS.EK1_OZ ADD CONSTRAINT XPK_EK1_OZ PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008697 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EK1_OZ MODIFY (NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_EK1_OZ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_EK1_OZ ON BARS.EK1_OZ (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EK1_OZ ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on EK1_OZ          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EK1_OZ          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on EK1_OZ          to EK1_OZ;
grant FLASHBACK,SELECT                                                       on EK1_OZ          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EK1_OZ.sql =========*** End *** ======
PROMPT ===================================================================================== 
