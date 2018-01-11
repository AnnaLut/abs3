

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/V_BANKS_REPORT91.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to V_BANKS_REPORT91 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''V_BANKS_REPORT91'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''V_BANKS_REPORT91'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''V_BANKS_REPORT91'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table V_BANKS_REPORT91 ***
begin 
  execute immediate '
  CREATE TABLE BARS.V_BANKS_REPORT91 
   (	NBUC NUMBER(38,0), 
	KODF VARCHAR2(2), 
	DATF DATE, 
	KODP VARCHAR2(35), 
	ZNAP VARCHAR2(70), 
	ERR_MSG VARCHAR2(1000), 
	FL_MOD NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to V_BANKS_REPORT91 ***
 exec bpa.alter_policies('V_BANKS_REPORT91');


COMMENT ON TABLE BARS.V_BANKS_REPORT91 IS '';
COMMENT ON COLUMN BARS.V_BANKS_REPORT91.NBUC IS '';
COMMENT ON COLUMN BARS.V_BANKS_REPORT91.KODF IS '';
COMMENT ON COLUMN BARS.V_BANKS_REPORT91.DATF IS '';
COMMENT ON COLUMN BARS.V_BANKS_REPORT91.KODP IS '';
COMMENT ON COLUMN BARS.V_BANKS_REPORT91.ZNAP IS '';
COMMENT ON COLUMN BARS.V_BANKS_REPORT91.ERR_MSG IS '';
COMMENT ON COLUMN BARS.V_BANKS_REPORT91.FL_MOD IS '';



PROMPT *** Create  grants  V_BANKS_REPORT91 ***
grant SELECT                                                                 on V_BANKS_REPORT91 to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_BANKS_REPORT91 to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_BANKS_REPORT91 to START1;
grant SELECT                                                                 on V_BANKS_REPORT91 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/V_BANKS_REPORT91.sql =========*** End 
PROMPT ===================================================================================== 
