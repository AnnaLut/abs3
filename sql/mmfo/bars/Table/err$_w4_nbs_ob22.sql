

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_W4_NBS_OB22.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_W4_NBS_OB22 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_W4_NBS_OB22 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_W4_NBS_OB22 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	NBS VARCHAR2(4000), 
	OB22 VARCHAR2(4000), 
	OB_9129 VARCHAR2(4000), 
	OB_OVR VARCHAR2(4000), 
	OB_2207 VARCHAR2(4000), 
	OB_2208 VARCHAR2(4000), 
	OB_2209 VARCHAR2(4000), 
	OB_3570 VARCHAR2(4000), 
	OB_3579 VARCHAR2(4000), 
	TIP VARCHAR2(4000), 
	OB_2627 VARCHAR2(4000), 
	OB_2625X VARCHAR2(4000), 
	OB_2627X VARCHAR2(4000), 
	OB_2625D VARCHAR2(4000), 
	OB_2628 VARCHAR2(4000), 
	OB_6110 VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_W4_NBS_OB22 ***
 exec bpa.alter_policies('ERR$_W4_NBS_OB22');


COMMENT ON TABLE BARS.ERR$_W4_NBS_OB22 IS 'DML Error Logging table for "W4_NBS_OB22"';
COMMENT ON COLUMN BARS.ERR$_W4_NBS_OB22.OB_6110 IS '';
COMMENT ON COLUMN BARS.ERR$_W4_NBS_OB22.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_NBS_OB22.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_NBS_OB22.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_NBS_OB22.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_NBS_OB22.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_W4_NBS_OB22.NBS IS '';
COMMENT ON COLUMN BARS.ERR$_W4_NBS_OB22.OB22 IS '';
COMMENT ON COLUMN BARS.ERR$_W4_NBS_OB22.OB_9129 IS '';
COMMENT ON COLUMN BARS.ERR$_W4_NBS_OB22.OB_OVR IS '';
COMMENT ON COLUMN BARS.ERR$_W4_NBS_OB22.OB_2207 IS '';
COMMENT ON COLUMN BARS.ERR$_W4_NBS_OB22.OB_2208 IS '';
COMMENT ON COLUMN BARS.ERR$_W4_NBS_OB22.OB_2209 IS '';
COMMENT ON COLUMN BARS.ERR$_W4_NBS_OB22.OB_3570 IS '';
COMMENT ON COLUMN BARS.ERR$_W4_NBS_OB22.OB_3579 IS '';
COMMENT ON COLUMN BARS.ERR$_W4_NBS_OB22.TIP IS '';
COMMENT ON COLUMN BARS.ERR$_W4_NBS_OB22.OB_2627 IS '';
COMMENT ON COLUMN BARS.ERR$_W4_NBS_OB22.OB_2625X IS '';
COMMENT ON COLUMN BARS.ERR$_W4_NBS_OB22.OB_2627X IS '';
COMMENT ON COLUMN BARS.ERR$_W4_NBS_OB22.OB_2625D IS '';
COMMENT ON COLUMN BARS.ERR$_W4_NBS_OB22.OB_2628 IS '';



PROMPT *** Create  grants  ERR$_W4_NBS_OB22 ***
grant SELECT                                                                 on ERR$_W4_NBS_OB22 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_W4_NBS_OB22.sql =========*** End 
PROMPT ===================================================================================== 
