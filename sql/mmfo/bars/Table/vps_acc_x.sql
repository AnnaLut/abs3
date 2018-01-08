

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VPS_ACC_X.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VPS_ACC_X ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VPS_ACC_X'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''VPS_ACC_X'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''VPS_ACC_X'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VPS_ACC_X ***
begin 
  execute immediate '
  CREATE TABLE BARS.VPS_ACC_X 
   (	MFO VARCHAR2(12), 
	NLS VARCHAR2(15)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VPS_ACC_X ***
 exec bpa.alter_policies('VPS_ACC_X');


COMMENT ON TABLE BARS.VPS_ACC_X IS '';
COMMENT ON COLUMN BARS.VPS_ACC_X.MFO IS '';
COMMENT ON COLUMN BARS.VPS_ACC_X.NLS IS '';




PROMPT *** Create  constraint SYS_C007386 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VPS_ACC_X MODIFY (MFO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007387 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VPS_ACC_X MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VPS_ACC_X ***
grant DELETE,INSERT,SELECT,UPDATE                                            on VPS_ACC_X       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on VPS_ACC_X       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VPS_ACC_X.sql =========*** End *** ===
PROMPT ===================================================================================== 
