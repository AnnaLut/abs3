

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MBM_ACSK_REGIONS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MBM_ACSK_REGIONS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MBM_ACSK_REGIONS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MBM_ACSK_REGIONS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MBM_ACSK_REGIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.MBM_ACSK_REGIONS 
   (	ID NUMBER, 
	NAME VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MBM_ACSK_REGIONS ***
 exec bpa.alter_policies('MBM_ACSK_REGIONS');


COMMENT ON TABLE BARS.MBM_ACSK_REGIONS IS 'ƒÓ‚≥‰ÌËÍ Â„≥ÓÌ≥‚ ¿÷— ';
COMMENT ON COLUMN BARS.MBM_ACSK_REGIONS.ID IS '';
COMMENT ON COLUMN BARS.MBM_ACSK_REGIONS.NAME IS '';




PROMPT *** Create  constraint SYS_C00111422 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_ACSK_REGIONS ADD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C00111422 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C00111422 ON BARS.MBM_ACSK_REGIONS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MBM_ACSK_REGIONS ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on MBM_ACSK_REGIONS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MBM_ACSK_REGIONS.sql =========*** End 
PROMPT ===================================================================================== 
