

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_VABANK_ODB.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_VABANK_ODB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_VABANK_ODB'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_VABANK_ODB'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_VABANK_ODB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_VABANK_ODB ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_VABANK_ODB 
   (	KV NUMBER(*,0), 
	NLS_BARS VARCHAR2(15), 
	NLS_VABANK VARCHAR2(15)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_VABANK_ODB ***
 exec bpa.alter_policies('DPT_VABANK_ODB');


COMMENT ON TABLE BARS.DPT_VABANK_ODB IS '';
COMMENT ON COLUMN BARS.DPT_VABANK_ODB.KV IS '';
COMMENT ON COLUMN BARS.DPT_VABANK_ODB.NLS_BARS IS '';
COMMENT ON COLUMN BARS.DPT_VABANK_ODB.NLS_VABANK IS '';



PROMPT *** Create  grants  DPT_VABANK_ODB ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_VABANK_ODB  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_VABANK_ODB  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VABANK_ODB  to VKLAD;
grant FLASHBACK,SELECT                                                       on DPT_VABANK_ODB  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_VABANK_ODB.sql =========*** End **
PROMPT ===================================================================================== 
