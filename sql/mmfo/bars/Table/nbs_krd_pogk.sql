

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBS_KRD_POGK.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBS_KRD_POGK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBS_KRD_POGK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''NBS_KRD_POGK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NBS_KRD_POGK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBS_KRD_POGK ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBS_KRD_POGK 
   (	NBS CHAR(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBS_KRD_POGK ***
 exec bpa.alter_policies('NBS_KRD_POGK');


COMMENT ON TABLE BARS.NBS_KRD_POGK IS '';
COMMENT ON COLUMN BARS.NBS_KRD_POGK.NBS IS '';



PROMPT *** Create  grants  NBS_KRD_POGK ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NBS_KRD_POGK    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBS_KRD_POGK    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on NBS_KRD_POGK    to SALGL;
grant FLASHBACK,SELECT                                                       on NBS_KRD_POGK    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBS_KRD_POGK.sql =========*** End *** 
PROMPT ===================================================================================== 
