

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_DEB04.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_DEB04 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_DEB04'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_DEB04'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_DEB04'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_DEB04 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_DEB04 
   (	DEB04 NUMBER(*,0), 
	NAME VARCHAR2(20), 
	RISK_RATE NUMBER(10,2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SB_DEB04 ***
 exec bpa.alter_policies('SB_DEB04');


COMMENT ON TABLE BARS.SB_DEB04 IS '';
COMMENT ON COLUMN BARS.SB_DEB04.DEB04 IS '';
COMMENT ON COLUMN BARS.SB_DEB04.NAME IS '';
COMMENT ON COLUMN BARS.SB_DEB04.RISK_RATE IS '';



PROMPT *** Create  grants  SB_DEB04 ***
grant SELECT                                                                 on SB_DEB04        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SB_DEB04        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SB_DEB04        to BARS_DM;
grant SELECT                                                                 on SB_DEB04        to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_DEB04        to VN_OT;
grant FLASHBACK,SELECT                                                       on SB_DEB04        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_DEB04.sql =========*** End *** ====
PROMPT ===================================================================================== 
