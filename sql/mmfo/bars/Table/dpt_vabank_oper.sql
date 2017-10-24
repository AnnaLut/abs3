

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_VABANK_OPER.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_VABANK_OPER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_VABANK_OPER'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_VABANK_OPER'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_VABANK_OPER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_VABANK_OPER ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_VABANK_OPER 
   (	REF NUMBER(*,0), 
	FDAT DATE, 
	VOB NUMBER(*,0), 
	KV NUMBER(*,0), 
	S NUMBER, 
	NLSD VARCHAR2(15), 
	NLSK VARCHAR2(15), 
	SK NUMBER(*,0), 
	NAZN VARCHAR2(160)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_VABANK_OPER ***
 exec bpa.alter_policies('DPT_VABANK_OPER');


COMMENT ON TABLE BARS.DPT_VABANK_OPER IS '';
COMMENT ON COLUMN BARS.DPT_VABANK_OPER.REF IS '';
COMMENT ON COLUMN BARS.DPT_VABANK_OPER.FDAT IS '';
COMMENT ON COLUMN BARS.DPT_VABANK_OPER.VOB IS '';
COMMENT ON COLUMN BARS.DPT_VABANK_OPER.KV IS '';
COMMENT ON COLUMN BARS.DPT_VABANK_OPER.S IS '';
COMMENT ON COLUMN BARS.DPT_VABANK_OPER.NLSD IS '';
COMMENT ON COLUMN BARS.DPT_VABANK_OPER.NLSK IS '';
COMMENT ON COLUMN BARS.DPT_VABANK_OPER.SK IS '';
COMMENT ON COLUMN BARS.DPT_VABANK_OPER.NAZN IS '';



PROMPT *** Create  grants  DPT_VABANK_OPER ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VABANK_OPER to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_VABANK_OPER to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VABANK_OPER to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_VABANK_OPER.sql =========*** End *
PROMPT ===================================================================================== 
