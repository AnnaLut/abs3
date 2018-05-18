

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OVR_CHKO_DET.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OVR_CHKO_DET ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OVR_CHKO_DET'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OVR_CHKO_DET'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OVR_CHKO_DET ***
begin 
  execute immediate '
  CREATE TABLE BARS.OVR_CHKO_DET 
   (	REF NUMBER, 
	ACC NUMBER, 
	DATM DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OVR_CHKO_DET ***
 exec bpa.alter_policies('OVR_CHKO_DET');


COMMENT ON TABLE BARS.OVR_CHKO_DET IS ' Детальные ЧКО';
COMMENT ON COLUMN BARS.OVR_CHKO_DET.REF IS '';
COMMENT ON COLUMN BARS.OVR_CHKO_DET.ACC IS '';
COMMENT ON COLUMN BARS.OVR_CHKO_DET.DATM IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OVR_CHKO_DET.sql =========*** End *** 
PROMPT ===================================================================================== 
