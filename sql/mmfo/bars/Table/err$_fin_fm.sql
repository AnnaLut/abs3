

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_FIN_FM.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_FIN_FM ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_FIN_FM ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_FIN_FM 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	OKPO VARCHAR2(4000), 
	FDAT VARCHAR2(4000), 
	FM VARCHAR2(4000), 
	DATE_F1 VARCHAR2(4000), 
	DATE_F2 VARCHAR2(4000), 
	VED VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_FIN_FM ***
 exec bpa.alter_policies('ERR$_FIN_FM');


COMMENT ON TABLE BARS.ERR$_FIN_FM IS 'DML Error Logging table for "FIN_FM"';
COMMENT ON COLUMN BARS.ERR$_FIN_FM.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_FM.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_FM.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_FM.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_FM.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_FM.OKPO IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_FM.FDAT IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_FM.FM IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_FM.DATE_F1 IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_FM.DATE_F2 IS '';
COMMENT ON COLUMN BARS.ERR$_FIN_FM.VED IS '';



PROMPT *** Create  grants  ERR$_FIN_FM ***
grant SELECT                                                                 on ERR$_FIN_FM     to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_FIN_FM     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_FIN_FM.sql =========*** End *** =
PROMPT ===================================================================================== 
