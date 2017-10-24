

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_DEC_2011.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_DEC_2011 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_DEC_2011'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_DEC_2011'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_DEC_2011'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_DEC_2011 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_DEC_2011 
   (	DK NUMBER(*,0), 
	NBS_A CHAR(4), 
	OB22_A CHAR(2), 
	P080_A CHAR(4), 
	NBS_B CHAR(4), 
	OB22_B CHAR(2), 
	P080_B CHAR(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SB_DEC_2011 ***
 exec bpa.alter_policies('SB_DEC_2011');


COMMENT ON TABLE BARS.SB_DEC_2011 IS '';
COMMENT ON COLUMN BARS.SB_DEC_2011.DK IS '';
COMMENT ON COLUMN BARS.SB_DEC_2011.NBS_A IS '';
COMMENT ON COLUMN BARS.SB_DEC_2011.OB22_A IS '';
COMMENT ON COLUMN BARS.SB_DEC_2011.P080_A IS '';
COMMENT ON COLUMN BARS.SB_DEC_2011.NBS_B IS '';
COMMENT ON COLUMN BARS.SB_DEC_2011.OB22_B IS '';
COMMENT ON COLUMN BARS.SB_DEC_2011.P080_B IS '';



PROMPT *** Create  grants  SB_DEC_2011 ***
grant SELECT                                                                 on SB_DEC_2011     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SB_DEC_2011     to BARS_DM;
grant SELECT                                                                 on SB_DEC_2011     to NALOG;
grant SELECT                                                                 on SB_DEC_2011     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_DEC_2011.sql =========*** End *** =
PROMPT ===================================================================================== 
