

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAG_KA.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAG_KA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAG_KA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ZAG_KA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ZAG_KA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAG_KA ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAG_KA 
   (	REF NUMBER(*,0), 
	KV NUMBER(*,0), 
	FN CHAR(12), 
	DAT DATE, 
	N NUMBER(*,0), 
	SDE NUMBER(24,0), 
	SKR NUMBER(24,0), 
	DATK DATE, 
	DAT_2 DATE, 
	K_ER NUMBER(*,0), 
	OTM NUMBER(*,0), 
	SIGN RAW(128), 
	SIGN_KEY CHAR(6)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAG_KA ***
 exec bpa.alter_policies('ZAG_KA');


COMMENT ON TABLE BARS.ZAG_KA IS '';
COMMENT ON COLUMN BARS.ZAG_KA.REF IS '';
COMMENT ON COLUMN BARS.ZAG_KA.KV IS '';
COMMENT ON COLUMN BARS.ZAG_KA.FN IS '';
COMMENT ON COLUMN BARS.ZAG_KA.DAT IS '';
COMMENT ON COLUMN BARS.ZAG_KA.N IS '';
COMMENT ON COLUMN BARS.ZAG_KA.SDE IS '';
COMMENT ON COLUMN BARS.ZAG_KA.SKR IS '';
COMMENT ON COLUMN BARS.ZAG_KA.DATK IS '';
COMMENT ON COLUMN BARS.ZAG_KA.DAT_2 IS '';
COMMENT ON COLUMN BARS.ZAG_KA.K_ER IS '';
COMMENT ON COLUMN BARS.ZAG_KA.OTM IS '';
COMMENT ON COLUMN BARS.ZAG_KA.SIGN IS '';
COMMENT ON COLUMN BARS.ZAG_KA.SIGN_KEY IS '';



PROMPT *** Create  grants  ZAG_KA ***
grant SELECT                                                                 on ZAG_KA          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAG_KA          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAG_KA          to START1;
grant SELECT                                                                 on ZAG_KA          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAG_KA.sql =========*** End *** ======
PROMPT ===================================================================================== 
