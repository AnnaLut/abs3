

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/T_DEL_10.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to T_DEL_10 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''T_DEL_10'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''T_DEL_10'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''T_DEL_10'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table T_DEL_10 ***
begin 
  execute immediate '
  CREATE TABLE BARS.T_DEL_10 
   (	TRANS_NO VARCHAR2(20), 
	DESCRIPTION VARCHAR2(255), 
	POSTDATE DATE, 
	EFFECTDATE DATE, 
	DOC_NO VARCHAR2(10), 
	DOCDATE DATE, 
	USER_ID NUMBER, 
	DR VARCHAR2(14), 
	CR VARCHAR2(14), 
	SYSVALUE NUMBER, 
	CCY NUMBER(*,0), 
	POSTVALUE NUMBER, 
	CO_ID VARCHAR2(6)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to T_DEL_10 ***
 exec bpa.alter_policies('T_DEL_10');


COMMENT ON TABLE BARS.T_DEL_10 IS '';
COMMENT ON COLUMN BARS.T_DEL_10.TRANS_NO IS '';
COMMENT ON COLUMN BARS.T_DEL_10.DESCRIPTION IS '';
COMMENT ON COLUMN BARS.T_DEL_10.POSTDATE IS '';
COMMENT ON COLUMN BARS.T_DEL_10.EFFECTDATE IS '';
COMMENT ON COLUMN BARS.T_DEL_10.DOC_NO IS '';
COMMENT ON COLUMN BARS.T_DEL_10.DOCDATE IS '';
COMMENT ON COLUMN BARS.T_DEL_10.USER_ID IS '';
COMMENT ON COLUMN BARS.T_DEL_10.DR IS '';
COMMENT ON COLUMN BARS.T_DEL_10.CR IS '';
COMMENT ON COLUMN BARS.T_DEL_10.SYSVALUE IS '';
COMMENT ON COLUMN BARS.T_DEL_10.CCY IS '';
COMMENT ON COLUMN BARS.T_DEL_10.POSTVALUE IS '';
COMMENT ON COLUMN BARS.T_DEL_10.CO_ID IS '';



PROMPT *** Create  grants  T_DEL_10 ***
grant SELECT                                                                 on T_DEL_10        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on T_DEL_10        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on T_DEL_10        to START1;
grant SELECT                                                                 on T_DEL_10        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/T_DEL_10.sql =========*** End *** ====
PROMPT ===================================================================================== 
