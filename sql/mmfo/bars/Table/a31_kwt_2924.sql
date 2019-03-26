

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/A31_KWT_2924.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to A31_KWT_2924 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''A31_KWT_2924'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''A31_KWT_2924'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table A31_KWT_2924 ***
begin 
  execute immediate '
  CREATE TABLE BARS.A31_KWT_2924 
   (	ACC NUMBER, 
	BRANCH VARCHAR2(30), 
	NLS VARCHAR2(14), 
	KV NUMBER(*,0), 
	OB22 CHAR(2), 
	DAOS DATE, 
	DAPP DATE, 
	DATVZ DATE, 
	DAT_KWT DATE, 
	IXD NUMBER, 
	IXK NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to A31_KWT_2924 ***
 exec bpa.alter_policies('A31_KWT_2924');


COMMENT ON TABLE BARS.A31_KWT_2924 IS '';
COMMENT ON COLUMN BARS.A31_KWT_2924.ACC IS '';
COMMENT ON COLUMN BARS.A31_KWT_2924.BRANCH IS '';
COMMENT ON COLUMN BARS.A31_KWT_2924.NLS IS '';
COMMENT ON COLUMN BARS.A31_KWT_2924.KV IS '';
COMMENT ON COLUMN BARS.A31_KWT_2924.OB22 IS '';
COMMENT ON COLUMN BARS.A31_KWT_2924.DAOS IS '';
COMMENT ON COLUMN BARS.A31_KWT_2924.DAPP IS '';
COMMENT ON COLUMN BARS.A31_KWT_2924.DATVZ IS '';
COMMENT ON COLUMN BARS.A31_KWT_2924.DAT_KWT IS '';
COMMENT ON COLUMN BARS.A31_KWT_2924.IXD IS '';
COMMENT ON COLUMN BARS.A31_KWT_2924.IXK IS '';



PROMPT *** Create  grants  A31_KWT_2924 ***
grant SELECT                                                                 on A31_KWT_2924    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/A31_KWT_2924.sql =========*** End *** 
PROMPT ===================================================================================== 