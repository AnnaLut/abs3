

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PO_ZMIST.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PO_ZMIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PO_ZMIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PO_ZMIST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PO_ZMIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PO_ZMIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.PO_ZMIST 
   (	ID NUMBER, 
	TXT VARCHAR2(160)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PO_ZMIST ***
 exec bpa.alter_policies('PO_ZMIST');


COMMENT ON TABLE BARS.PO_ZMIST IS '';
COMMENT ON COLUMN BARS.PO_ZMIST.ID IS '';
COMMENT ON COLUMN BARS.PO_ZMIST.TXT IS '';




PROMPT *** Create  constraint XPK_PO_ZMIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.PO_ZMIST ADD CONSTRAINT XPK_PO_ZMIST PRIMARY KEY (TXT, ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010032 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PO_ZMIST MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_PO_ZMIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_PO_ZMIST ON BARS.PO_ZMIST (TXT, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PO_ZMIST ***
grant SELECT                                                                 on PO_ZMIST        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PO_ZMIST        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PO_ZMIST        to START1;
grant SELECT                                                                 on PO_ZMIST        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PO_ZMIST.sql =========*** End *** ====
PROMPT ===================================================================================== 
