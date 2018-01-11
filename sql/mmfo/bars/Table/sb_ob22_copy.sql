

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_OB22_COPY.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_OB22_COPY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_OB22_COPY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_OB22_COPY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_OB22_COPY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_OB22_COPY ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_OB22_COPY 
   (	R020 CHAR(4), 
	OB22 CHAR(2), 
	TXT VARCHAR2(254), 
	PRIZ CHAR(1), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	COD_ACT CHAR(1), 
	A010 CHAR(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SB_OB22_COPY ***
 exec bpa.alter_policies('SB_OB22_COPY');


COMMENT ON TABLE BARS.SB_OB22_COPY IS '';
COMMENT ON COLUMN BARS.SB_OB22_COPY.R020 IS '';
COMMENT ON COLUMN BARS.SB_OB22_COPY.OB22 IS '';
COMMENT ON COLUMN BARS.SB_OB22_COPY.TXT IS '';
COMMENT ON COLUMN BARS.SB_OB22_COPY.PRIZ IS '';
COMMENT ON COLUMN BARS.SB_OB22_COPY.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_OB22_COPY.D_CLOSE IS '';
COMMENT ON COLUMN BARS.SB_OB22_COPY.COD_ACT IS '';
COMMENT ON COLUMN BARS.SB_OB22_COPY.A010 IS '';



PROMPT *** Create  grants  SB_OB22_COPY ***
grant SELECT                                                                 on SB_OB22_COPY    to BARSREADER_ROLE;
grant SELECT                                                                 on SB_OB22_COPY    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SB_OB22_COPY    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_OB22_COPY.sql =========*** End *** 
PROMPT ===================================================================================== 
