

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SB_FLTR.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SB_FLTR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_SB_FLTR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_SB_FLTR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_SB_FLTR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SB_FLTR ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_SB_FLTR 
   (	ITEMID1 NUMBER(*,0), 
	ITEMNAME1 VARCHAR2(20), 
	ITEMVALUE1 NUMBER, 
	ITEMID2 NUMBER(*,0), 
	ITEMNAME2 VARCHAR2(20), 
	ITEMVALUE2 NUMBER, 
	ITEMID3 NUMBER(*,0), 
	ITEMNAME3 VARCHAR2(20), 
	ITEMVALUE3 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SB_FLTR ***
 exec bpa.alter_policies('TMP_SB_FLTR');


COMMENT ON TABLE BARS.TMP_SB_FLTR IS '';
COMMENT ON COLUMN BARS.TMP_SB_FLTR.ITEMID1 IS '';
COMMENT ON COLUMN BARS.TMP_SB_FLTR.ITEMNAME1 IS '';
COMMENT ON COLUMN BARS.TMP_SB_FLTR.ITEMVALUE1 IS '';
COMMENT ON COLUMN BARS.TMP_SB_FLTR.ITEMID2 IS '';
COMMENT ON COLUMN BARS.TMP_SB_FLTR.ITEMNAME2 IS '';
COMMENT ON COLUMN BARS.TMP_SB_FLTR.ITEMVALUE2 IS '';
COMMENT ON COLUMN BARS.TMP_SB_FLTR.ITEMID3 IS '';
COMMENT ON COLUMN BARS.TMP_SB_FLTR.ITEMNAME3 IS '';
COMMENT ON COLUMN BARS.TMP_SB_FLTR.ITEMVALUE3 IS '';



PROMPT *** Create  grants  TMP_SB_FLTR ***
grant SELECT                                                                 on TMP_SB_FLTR     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_SB_FLTR     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_SB_FLTR     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_SB_FLTR     to START1;
grant SELECT                                                                 on TMP_SB_FLTR     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SB_FLTR.sql =========*** End *** =
PROMPT ===================================================================================== 
