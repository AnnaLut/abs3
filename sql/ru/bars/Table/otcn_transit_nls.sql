

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_TRANSIT_NLS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_TRANSIT_NLS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_TRANSIT_NLS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_TRANSIT_NLS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_TRANSIT_NLS ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_TRANSIT_NLS 
   (	NLS VARCHAR2(15), 
	T_SYSTEM VARCHAR2(30)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_TRANSIT_NLS ***
 exec bpa.alter_policies('OTCN_TRANSIT_NLS');


COMMENT ON TABLE BARS.OTCN_TRANSIT_NLS IS '';
COMMENT ON COLUMN BARS.OTCN_TRANSIT_NLS.NLS IS '';
COMMENT ON COLUMN BARS.OTCN_TRANSIT_NLS.T_SYSTEM IS '';



PROMPT *** Create  grants  OTCN_TRANSIT_NLS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_TRANSIT_NLS to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_TRANSIT_NLS.sql =========*** End 
PROMPT ===================================================================================== 
