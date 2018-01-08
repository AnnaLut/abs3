

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPTLIST.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPTLIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPTLIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPTLIST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPTLIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPTLIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPTLIST 
   (	NCKS VARCHAR2(9), 
	DEPCODE VARCHAR2(9), 
	KNB VARCHAR2(9), 
	NAMEF VARCHAR2(9), 
	D_OPEN DATE, 
	D_CLOSE VARCHAR2(9)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPTLIST ***
 exec bpa.alter_policies('DPTLIST');


COMMENT ON TABLE BARS.DPTLIST IS '';
COMMENT ON COLUMN BARS.DPTLIST.NCKS IS '';
COMMENT ON COLUMN BARS.DPTLIST.DEPCODE IS '';
COMMENT ON COLUMN BARS.DPTLIST.KNB IS '';
COMMENT ON COLUMN BARS.DPTLIST.NAMEF IS '';
COMMENT ON COLUMN BARS.DPTLIST.D_OPEN IS '';
COMMENT ON COLUMN BARS.DPTLIST.D_CLOSE IS '';



PROMPT *** Create  grants  DPTLIST ***
grant SELECT                                                                 on DPTLIST         to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPTLIST         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPTLIST.sql =========*** End *** =====
PROMPT ===================================================================================== 
