

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_R041.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_R041 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_R041'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_R041'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_R041'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_R041 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_R041 
   (	T020 CHAR(1), 
	R020 CHAR(4), 
	OB22 CHAR(2), 
	OB41 CHAR(4), 
	D_OPEN DATE, 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SB_R041 ***
 exec bpa.alter_policies('SB_R041');


COMMENT ON TABLE BARS.SB_R041 IS '';
COMMENT ON COLUMN BARS.SB_R041.T020 IS '';
COMMENT ON COLUMN BARS.SB_R041.R020 IS '';
COMMENT ON COLUMN BARS.SB_R041.OB22 IS '';
COMMENT ON COLUMN BARS.SB_R041.OB41 IS '';
COMMENT ON COLUMN BARS.SB_R041.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_R041.D_CLOSE IS '';



PROMPT *** Create  grants  SB_R041 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_R041         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SB_R041         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_R041         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_R041.sql =========*** End *** =====
PROMPT ===================================================================================== 
