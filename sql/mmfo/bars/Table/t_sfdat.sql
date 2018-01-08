

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/T_SFDAT.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to T_SFDAT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''T_SFDAT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''T_SFDAT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table T_SFDAT ***
begin 
  execute immediate '
  CREATE TABLE BARS.T_SFDAT 
   (	ISP NUMBER(*,0), 
	B DATE, 
	E DATE, 
	Z DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to T_SFDAT ***
 exec bpa.alter_policies('T_SFDAT');


COMMENT ON TABLE BARS.T_SFDAT IS '';
COMMENT ON COLUMN BARS.T_SFDAT.ISP IS '';
COMMENT ON COLUMN BARS.T_SFDAT.B IS '';
COMMENT ON COLUMN BARS.T_SFDAT.E IS '';
COMMENT ON COLUMN BARS.T_SFDAT.Z IS '';



PROMPT *** Create  grants  T_SFDAT ***
grant SELECT                                                                 on T_SFDAT         to BARSREADER_ROLE;
grant SELECT                                                                 on T_SFDAT         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/T_SFDAT.sql =========*** End *** =====
PROMPT ===================================================================================== 
