

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MBM_PARAMETERS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MBM_PARAMETERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MBM_PARAMETERS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MBM_PARAMETERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MBM_PARAMETERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.MBM_PARAMETERS 
   (	PARAMETER_NAME VARCHAR2(256), 
	PARAMETER_VALUE VARCHAR2(256), 
	DESCRIPTION VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MBM_PARAMETERS ***
 exec bpa.alter_policies('MBM_PARAMETERS');


COMMENT ON TABLE BARS.MBM_PARAMETERS IS 'Module parameters';
COMMENT ON COLUMN BARS.MBM_PARAMETERS.PARAMETER_NAME IS 'Parameter name';
COMMENT ON COLUMN BARS.MBM_PARAMETERS.PARAMETER_VALUE IS 'Parameter value';
COMMENT ON COLUMN BARS.MBM_PARAMETERS.DESCRIPTION IS 'Parameter description';




PROMPT *** Create  constraint SYS_C00111403 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_PARAMETERS ADD PRIMARY KEY (PARAMETER_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C00111403 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C00111403 ON BARS.MBM_PARAMETERS (PARAMETER_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MBM_PARAMETERS ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on MBM_PARAMETERS  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MBM_PARAMETERS.sql =========*** End **
PROMPT ===================================================================================== 
