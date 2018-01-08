

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ANI_DEL2.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ANI_DEL2 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ANI_DEL2'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ANI_DEL2'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ANI_DEL2'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ANI_DEL2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ANI_DEL2 
   (	KV NUMBER(3,0), 
	NLS VARCHAR2(15), 
	NMS VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ANI_DEL2 ***
 exec bpa.alter_policies('ANI_DEL2');


COMMENT ON TABLE BARS.ANI_DEL2 IS '';
COMMENT ON COLUMN BARS.ANI_DEL2.KV IS '';
COMMENT ON COLUMN BARS.ANI_DEL2.NLS IS '';
COMMENT ON COLUMN BARS.ANI_DEL2.NMS IS '';




PROMPT *** Create  constraint SYS_C005733 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANI_DEL2 MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005734 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANI_DEL2 MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005735 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANI_DEL2 MODIFY (NMS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ANI_DEL2 ***
grant SELECT                                                                 on ANI_DEL2        to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on ANI_DEL2        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ANI_DEL2        to BARS_DM;
grant SELECT,UPDATE                                                          on ANI_DEL2        to START1;
grant SELECT                                                                 on ANI_DEL2        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ANI_DEL2.sql =========*** End *** ====
PROMPT ===================================================================================== 
