

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBS_KRD_POGP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBS_KRD_POGP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBS_KRD_POGP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''NBS_KRD_POGP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NBS_KRD_POGP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBS_KRD_POGP ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBS_KRD_POGP 
   (	NBS CHAR(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBS_KRD_POGP ***
 exec bpa.alter_policies('NBS_KRD_POGP');


COMMENT ON TABLE BARS.NBS_KRD_POGP IS '';
COMMENT ON COLUMN BARS.NBS_KRD_POGP.NBS IS '';



PROMPT *** Create  grants  NBS_KRD_POGP ***
grant SELECT                                                                 on NBS_KRD_POGP    to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NBS_KRD_POGP    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBS_KRD_POGP    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on NBS_KRD_POGP    to SALGL;
grant SELECT                                                                 on NBS_KRD_POGP    to UPLD;
grant FLASHBACK,SELECT                                                       on NBS_KRD_POGP    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBS_KRD_POGP.sql =========*** End *** 
PROMPT ===================================================================================== 
