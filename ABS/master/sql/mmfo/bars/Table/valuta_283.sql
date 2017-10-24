

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VALUTA_283.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VALUTA_283 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VALUTA_283'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''VALUTA_283'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''VALUTA_283'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VALUTA_283 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.VALUTA_283 
   (	KV NUMBER, 
	LCV VARCHAR2(10), 
	NAME VARCHAR2(160), 
	BRANCH VARCHAR2(30), 
	NAMEB VARCHAR2(160), 
	KUPL_VAL NUMBER, 
	ZATR_GRN NUMBER, 
	PROD_VAL NUMBER, 
	VYRU_GRN NUMBER, 
	KURS_KUPL VARCHAR2(30), 
	KURS_PROD VARCHAR2(30)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VALUTA_283 ***
 exec bpa.alter_policies('VALUTA_283');


COMMENT ON TABLE BARS.VALUTA_283 IS '';
COMMENT ON COLUMN BARS.VALUTA_283.KV IS '';
COMMENT ON COLUMN BARS.VALUTA_283.LCV IS '';
COMMENT ON COLUMN BARS.VALUTA_283.NAME IS '';
COMMENT ON COLUMN BARS.VALUTA_283.BRANCH IS '';
COMMENT ON COLUMN BARS.VALUTA_283.NAMEB IS '';
COMMENT ON COLUMN BARS.VALUTA_283.KUPL_VAL IS '';
COMMENT ON COLUMN BARS.VALUTA_283.ZATR_GRN IS '';
COMMENT ON COLUMN BARS.VALUTA_283.PROD_VAL IS '';
COMMENT ON COLUMN BARS.VALUTA_283.VYRU_GRN IS '';
COMMENT ON COLUMN BARS.VALUTA_283.KURS_KUPL IS '';
COMMENT ON COLUMN BARS.VALUTA_283.KURS_PROD IS '';



PROMPT *** Create  grants  VALUTA_283 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on VALUTA_283      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on VALUTA_283      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VALUTA_283.sql =========*** End *** ==
PROMPT ===================================================================================== 
