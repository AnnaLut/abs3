

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SALDOH.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SALDOH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SALDOH'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SALDOH'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SALDOH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SALDOH ***
begin 
  execute immediate '
  CREATE TABLE BARS.SALDOH 
   (	ACC NUMBER, 
	DAT DATE, 
	DOS NUMBER(24,0), 
	KOS NUMBER(24,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SALDOH ***
 exec bpa.alter_policies('SALDOH');


COMMENT ON TABLE BARS.SALDOH IS '';
COMMENT ON COLUMN BARS.SALDOH.ACC IS '';
COMMENT ON COLUMN BARS.SALDOH.DAT IS '';
COMMENT ON COLUMN BARS.SALDOH.DOS IS '';
COMMENT ON COLUMN BARS.SALDOH.KOS IS '';



PROMPT *** Create  grants  SALDOH ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SALDOH          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SALDOH          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SALDOH.sql =========*** End *** ======
PROMPT ===================================================================================== 
