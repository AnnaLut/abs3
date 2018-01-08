

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_OP_RULES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_OP_RULES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_OP_RULES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_OP_RULES 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	TT VARCHAR2(4000), 
	TAG VARCHAR2(4000), 
	OPT VARCHAR2(4000), 
	USED4INPUT VARCHAR2(4000), 
	ORD VARCHAR2(4000), 
	VAL VARCHAR2(4000), 
	NOMODIFY VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_OP_RULES ***
 exec bpa.alter_policies('ERR$_OP_RULES');


COMMENT ON TABLE BARS.ERR$_OP_RULES IS 'DML Error Logging table for "OP_RULES"';
COMMENT ON COLUMN BARS.ERR$_OP_RULES.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_OP_RULES.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OP_RULES.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_OP_RULES.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_OP_RULES.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_OP_RULES.TT IS '';
COMMENT ON COLUMN BARS.ERR$_OP_RULES.TAG IS '';
COMMENT ON COLUMN BARS.ERR$_OP_RULES.OPT IS '';
COMMENT ON COLUMN BARS.ERR$_OP_RULES.USED4INPUT IS '';
COMMENT ON COLUMN BARS.ERR$_OP_RULES.ORD IS '';
COMMENT ON COLUMN BARS.ERR$_OP_RULES.VAL IS '';
COMMENT ON COLUMN BARS.ERR$_OP_RULES.NOMODIFY IS '';



PROMPT *** Create  grants  ERR$_OP_RULES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ERR$_OP_RULES   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ERR$_OP_RULES   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ERR$_OP_RULES   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_OP_RULES.sql =========*** End ***
PROMPT ===================================================================================== 
