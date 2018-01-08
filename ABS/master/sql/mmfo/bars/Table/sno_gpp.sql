

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SNO_GPP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SNO_GPP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SNO_GPP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SNO_GPP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SNO_GPP ***
begin 
  execute immediate '
  CREATE TABLE BARS.SNO_GPP 
   (	ND NUMBER, 
	FDAT DATE, 
	SUMP1 NUMBER, 
	ACC NUMBER, 
	DAT31 DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SNO_GPP ***
 exec bpa.alter_policies('SNO_GPP');


COMMENT ON TABLE BARS.SNO_GPP IS '';
COMMENT ON COLUMN BARS.SNO_GPP.ND IS '';
COMMENT ON COLUMN BARS.SNO_GPP.FDAT IS '';
COMMENT ON COLUMN BARS.SNO_GPP.SUMP1 IS '';
COMMENT ON COLUMN BARS.SNO_GPP.ACC IS '';
COMMENT ON COLUMN BARS.SNO_GPP.DAT31 IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SNO_GPP.sql =========*** End *** =====
PROMPT ===================================================================================== 
