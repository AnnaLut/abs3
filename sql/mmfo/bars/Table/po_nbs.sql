

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PO_NBS.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PO_NBS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PO_NBS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PO_NBS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PO_NBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PO_NBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.PO_NBS 
   (	PO_DK NUMBER, 
	NBS_D VARCHAR2(4), 
	NBS_K VARCHAR2(4)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PO_NBS ***
 exec bpa.alter_policies('PO_NBS');


COMMENT ON TABLE BARS.PO_NBS IS '';
COMMENT ON COLUMN BARS.PO_NBS.PO_DK IS '';
COMMENT ON COLUMN BARS.PO_NBS.NBS_D IS '';
COMMENT ON COLUMN BARS.PO_NBS.NBS_K IS '';




PROMPT *** Create  constraint XPK_PO_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PO_NBS ADD CONSTRAINT XPK_PO_NBS PRIMARY KEY (NBS_D, NBS_K, PO_DK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_PO_NBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_PO_NBS ON BARS.PO_NBS (NBS_D, NBS_K, PO_DK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PO_NBS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PO_NBS          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PO_NBS          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PO_NBS.sql =========*** End *** ======
PROMPT ===================================================================================== 
