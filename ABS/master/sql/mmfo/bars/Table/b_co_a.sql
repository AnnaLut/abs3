

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/B_CO_A.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to B_CO_A ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''B_CO_A'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''B_CO_A'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''B_CO_A'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table B_CO_A ***
begin 
  execute immediate '
  CREATE TABLE BARS.B_CO_A 
   (	NAME_SP VARCHAR2(90), 
	C_OTV CHAR(1), 
	KSP_1U CHAR(2), 
	KSP_2U CHAR(2), 
	PRZ CHAR(1), 
	KSP_3U CHAR(1), 
	KSP_4U CHAR(1), 
	KODE_SP CHAR(8)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to B_CO_A ***
 exec bpa.alter_policies('B_CO_A');


COMMENT ON TABLE BARS.B_CO_A IS '';
COMMENT ON COLUMN BARS.B_CO_A.NAME_SP IS '';
COMMENT ON COLUMN BARS.B_CO_A.C_OTV IS '';
COMMENT ON COLUMN BARS.B_CO_A.KSP_1U IS '';
COMMENT ON COLUMN BARS.B_CO_A.KSP_2U IS '';
COMMENT ON COLUMN BARS.B_CO_A.PRZ IS '';
COMMENT ON COLUMN BARS.B_CO_A.KSP_3U IS '';
COMMENT ON COLUMN BARS.B_CO_A.KSP_4U IS '';
COMMENT ON COLUMN BARS.B_CO_A.KODE_SP IS '';



PROMPT *** Create  grants  B_CO_A ***
grant DELETE,INSERT,SELECT,UPDATE                                            on B_CO_A          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on B_CO_A          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on B_CO_A          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/B_CO_A.sql =========*** End *** ======
PROMPT ===================================================================================== 
