

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_RECOVERED_ACCOUNTSW.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_RECOVERED_ACCOUNTSW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_RECOVERED_ACCOUNTSW'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_RECOVERED_ACCOUNTSW'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_RECOVERED_ACCOUNTSW'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_RECOVERED_ACCOUNTSW ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_RECOVERED_ACCOUNTSW 
   (	ACC NUMBER, 
	TAG CHAR(5), 
	VALUE VARCHAR2(254)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_RECOVERED_ACCOUNTSW ***
 exec bpa.alter_policies('TMP_RECOVERED_ACCOUNTSW');


COMMENT ON TABLE BARS.TMP_RECOVERED_ACCOUNTSW IS '';
COMMENT ON COLUMN BARS.TMP_RECOVERED_ACCOUNTSW.ACC IS '';
COMMENT ON COLUMN BARS.TMP_RECOVERED_ACCOUNTSW.TAG IS '';
COMMENT ON COLUMN BARS.TMP_RECOVERED_ACCOUNTSW.VALUE IS '';



PROMPT *** Create  grants  TMP_RECOVERED_ACCOUNTSW ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_RECOVERED_ACCOUNTSW to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_RECOVERED_ACCOUNTSW to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_RECOVERED_ACCOUNTSW.sql =========*
PROMPT ===================================================================================== 
