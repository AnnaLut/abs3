

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DOP_F42.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DOP_F42 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DOP_F42'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DOP_F42'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DOP_F42'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DOP_F42 ***
begin 
  execute immediate '
  CREATE TABLE BARS.DOP_F42 
   (	RNK NUMBER, 
	NMK VARCHAR2(70), 
	NLS VARCHAR2(15), 
	KV NUMBER, 
	NMS VARCHAR2(70), 
	SUMA NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DOP_F42 ***
 exec bpa.alter_policies('DOP_F42');


COMMENT ON TABLE BARS.DOP_F42 IS '';
COMMENT ON COLUMN BARS.DOP_F42.RNK IS '';
COMMENT ON COLUMN BARS.DOP_F42.NMK IS '';
COMMENT ON COLUMN BARS.DOP_F42.NLS IS '';
COMMENT ON COLUMN BARS.DOP_F42.KV IS '';
COMMENT ON COLUMN BARS.DOP_F42.NMS IS '';
COMMENT ON COLUMN BARS.DOP_F42.SUMA IS '';




PROMPT *** Create  constraint SYS_C007379 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOP_F42 MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007380 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOP_F42 MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007381 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOP_F42 MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DOP_F42 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DOP_F42         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DOP_F42         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DOP_F42         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DOP_F42.sql =========*** End *** =====
PROMPT ===================================================================================== 
