

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SW_950D.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SW_950D ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SW_950D ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SW_950D 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	SWREF VARCHAR2(4000), 
	N VARCHAR2(4000), 
	FUND VARCHAR2(4000), 
	S VARCHAR2(4000), 
	THEIR_REF VARCHAR2(4000), 
	DETAIL VARCHAR2(4000), 
	ADD_INFO VARCHAR2(4000), 
	CONTRA_ACC VARCHAR2(4000), 
	CHECKED_IND VARCHAR2(4000), 
	OUR_REF VARCHAR2(4000), 
	MT VARCHAR2(4000), 
	SWTT VARCHAR2(4000), 
	VDATE VARCHAR2(4000), 
	EDATE VARCHAR2(4000), 
	THEIR2_REF VARCHAR2(4000), 
	SRC_SWREF VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	STMT_DK VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SW_950D ***
 exec bpa.alter_policies('ERR$_SW_950D');


COMMENT ON TABLE BARS.ERR$_SW_950D IS 'DML Error Logging table for "SW_950D"';
COMMENT ON COLUMN BARS.ERR$_SW_950D.DETAIL IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950D.ADD_INFO IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950D.CONTRA_ACC IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950D.CHECKED_IND IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950D.OUR_REF IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950D.MT IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950D.SWTT IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950D.VDATE IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950D.EDATE IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950D.THEIR2_REF IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950D.SRC_SWREF IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950D.KF IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950D.STMT_DK IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950D.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950D.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950D.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950D.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950D.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950D.SWREF IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950D.N IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950D.FUND IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950D.S IS '';
COMMENT ON COLUMN BARS.ERR$_SW_950D.THEIR_REF IS '';



PROMPT *** Create  grants  ERR$_SW_950D ***
grant SELECT                                                                 on ERR$_SW_950D    to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_SW_950D    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SW_950D.sql =========*** End *** 
PROMPT ===================================================================================== 
