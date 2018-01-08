

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_OPPOK.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_OPPOK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_OPPOK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_OPPOK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_OPPOK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_OPPOK ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_OPPOK 
   (	N_FILE VARCHAR2(2), 
	BEGIN NUMBER(2,0), 
	KOL NUMBER(2,0), 
	KL_FILE VARCHAR2(10), 
	IM_POL VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SB_OPPOK ***
 exec bpa.alter_policies('SB_OPPOK');


COMMENT ON TABLE BARS.SB_OPPOK IS '';
COMMENT ON COLUMN BARS.SB_OPPOK.N_FILE IS '';
COMMENT ON COLUMN BARS.SB_OPPOK.BEGIN IS '';
COMMENT ON COLUMN BARS.SB_OPPOK.KOL IS '';
COMMENT ON COLUMN BARS.SB_OPPOK.KL_FILE IS '';
COMMENT ON COLUMN BARS.SB_OPPOK.IM_POL IS '';



PROMPT *** Create  grants  SB_OPPOK ***
grant SELECT                                                                 on SB_OPPOK        to BARSREADER_ROLE;
grant SELECT                                                                 on SB_OPPOK        to BARS_DM;
grant SELECT                                                                 on SB_OPPOK        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_OPPOK.sql =========*** End *** ====
PROMPT ===================================================================================== 
