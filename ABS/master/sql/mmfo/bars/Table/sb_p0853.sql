

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_P0853.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_P0853 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_P0853'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_P0853'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_P0853'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_P0853 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_P0853 
   (	R020 CHAR(4), 
	P080 CHAR(4), 
	R020_FA CHAR(4), 
	OB22 CHAR(2), 
	TXT VARCHAR2(254), 
	AP CHAR(1), 
	PRIZN_VIDP CHAR(1), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	COD_ACT CHAR(1), 
	GR_FA CHAR(4), 
	GR_IN CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SB_P0853 ***
 exec bpa.alter_policies('SB_P0853');


COMMENT ON TABLE BARS.SB_P0853 IS '';
COMMENT ON COLUMN BARS.SB_P0853.R020 IS '';
COMMENT ON COLUMN BARS.SB_P0853.P080 IS '';
COMMENT ON COLUMN BARS.SB_P0853.R020_FA IS '';
COMMENT ON COLUMN BARS.SB_P0853.OB22 IS '';
COMMENT ON COLUMN BARS.SB_P0853.TXT IS '';
COMMENT ON COLUMN BARS.SB_P0853.AP IS '';
COMMENT ON COLUMN BARS.SB_P0853.PRIZN_VIDP IS '';
COMMENT ON COLUMN BARS.SB_P0853.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_P0853.D_CLOSE IS '';
COMMENT ON COLUMN BARS.SB_P0853.COD_ACT IS '';
COMMENT ON COLUMN BARS.SB_P0853.GR_FA IS '';
COMMENT ON COLUMN BARS.SB_P0853.GR_IN IS '';




PROMPT *** Create  constraint CC_SB_P0853 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SB_P0853 ADD CONSTRAINT CC_SB_P0853 CHECK ((ASCII(substr(ob22,1,1)) between 48 and 57
               or ASCII(substr(ob22,1,1)) between 65 and 90 )
              and ASCII(substr(ob22,2,1)) between 48 and 57
             ) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SB_P0853 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_P0853        to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SB_P0853        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SB_P0853        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_P0853        to NALOG;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_P0853        to SB_P0853;
grant SELECT                                                                 on SB_P0853        to START1;
grant FLASHBACK,SELECT                                                       on SB_P0853        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_P0853.sql =========*** End *** ====
PROMPT ===================================================================================== 
