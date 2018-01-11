

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_RECOVERED_ACCOUNTSW2.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_RECOVERED_ACCOUNTSW2 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_RECOVERED_ACCOUNTSW2'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_RECOVERED_ACCOUNTSW2'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_RECOVERED_ACCOUNTSW2'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_RECOVERED_ACCOUNTSW2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_RECOVERED_ACCOUNTSW2 
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




PROMPT *** ALTER_POLICIES to TMP_RECOVERED_ACCOUNTSW2 ***
 exec bpa.alter_policies('TMP_RECOVERED_ACCOUNTSW2');


COMMENT ON TABLE BARS.TMP_RECOVERED_ACCOUNTSW2 IS '';
COMMENT ON COLUMN BARS.TMP_RECOVERED_ACCOUNTSW2.ACC IS '';
COMMENT ON COLUMN BARS.TMP_RECOVERED_ACCOUNTSW2.TAG IS '';
COMMENT ON COLUMN BARS.TMP_RECOVERED_ACCOUNTSW2.VALUE IS '';



PROMPT *** Create  grants  TMP_RECOVERED_ACCOUNTSW2 ***
grant SELECT                                                                 on TMP_RECOVERED_ACCOUNTSW2 to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_RECOVERED_ACCOUNTSW2 to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_RECOVERED_ACCOUNTSW2 to START1;
grant SELECT                                                                 on TMP_RECOVERED_ACCOUNTSW2 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_RECOVERED_ACCOUNTSW2.sql =========
PROMPT ===================================================================================== 
