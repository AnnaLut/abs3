

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VPS_NAZN_MASK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VPS_NAZN_MASK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VPS_NAZN_MASK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''VPS_NAZN_MASK'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''VPS_NAZN_MASK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VPS_NAZN_MASK ***
begin 
  execute immediate '
  CREATE TABLE BARS.VPS_NAZN_MASK 
   (	N NUMBER(*,0), 
	NLS VARCHAR2(15), 
	MASKA VARCHAR2(200), 
	OKPO VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VPS_NAZN_MASK ***
 exec bpa.alter_policies('VPS_NAZN_MASK');


COMMENT ON TABLE BARS.VPS_NAZN_MASK IS '';
COMMENT ON COLUMN BARS.VPS_NAZN_MASK.N IS '';
COMMENT ON COLUMN BARS.VPS_NAZN_MASK.NLS IS '';
COMMENT ON COLUMN BARS.VPS_NAZN_MASK.MASKA IS '';
COMMENT ON COLUMN BARS.VPS_NAZN_MASK.OKPO IS '';




PROMPT *** Create  constraint XPK_VPS_NAZN_MASK ***
begin   
 execute immediate '
  ALTER TABLE BARS.VPS_NAZN_MASK ADD CONSTRAINT XPK_VPS_NAZN_MASK PRIMARY KEY (NLS, N)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_VPS_NAZN_MASK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_VPS_NAZN_MASK ON BARS.VPS_NAZN_MASK (NLS, N) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VPS_NAZN_MASK ***
grant SELECT                                                                 on VPS_NAZN_MASK   to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VPS_NAZN_MASK   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VPS_NAZN_MASK   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on VPS_NAZN_MASK   to RCH_1;
grant DELETE,INSERT,SELECT,UPDATE                                            on VPS_NAZN_MASK   to START1;
grant SELECT                                                                 on VPS_NAZN_MASK   to UPLD;
grant FLASHBACK,SELECT                                                       on VPS_NAZN_MASK   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VPS_NAZN_MASK.sql =========*** End ***
PROMPT ===================================================================================== 
