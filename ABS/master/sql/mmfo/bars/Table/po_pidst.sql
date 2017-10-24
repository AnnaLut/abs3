

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PO_PIDST.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PO_PIDST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PO_PIDST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PO_PIDST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PO_PIDST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PO_PIDST ***
begin 
  execute immediate '
  CREATE TABLE BARS.PO_PIDST 
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




PROMPT *** ALTER_POLICIES to PO_PIDST ***
 exec bpa.alter_policies('PO_PIDST');


COMMENT ON TABLE BARS.PO_PIDST IS '';
COMMENT ON COLUMN BARS.PO_PIDST.ID IS '';
COMMENT ON COLUMN BARS.PO_PIDST.TXT IS '';




PROMPT *** Create  constraint XPK_PO_PIDST ***
begin   
 execute immediate '
  ALTER TABLE BARS.PO_PIDST ADD CONSTRAINT XPK_PO_PIDST PRIMARY KEY (TXT, ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006546 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PO_PIDST MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_PO_PIDST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_PO_PIDST ON BARS.PO_PIDST (TXT, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PO_PIDST ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PO_PIDST        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PO_PIDST        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PO_PIDST.sql =========*** End *** ====
PROMPT ===================================================================================== 
