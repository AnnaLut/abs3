

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_K042.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_K042 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_K042'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_K042'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_K042'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_K042 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_K042 
   (	K020 CHAR(10), 
	NAME VARCHAR2(38), 
	PRIZ CHAR(1), 
	CC_K020 CHAR(10), 
	CC_NAME VARCHAR2(38)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SB_K042 ***
 exec bpa.alter_policies('SB_K042');


COMMENT ON TABLE BARS.SB_K042 IS '';
COMMENT ON COLUMN BARS.SB_K042.K020 IS '';
COMMENT ON COLUMN BARS.SB_K042.NAME IS '';
COMMENT ON COLUMN BARS.SB_K042.PRIZ IS '';
COMMENT ON COLUMN BARS.SB_K042.CC_K020 IS '';
COMMENT ON COLUMN BARS.SB_K042.CC_NAME IS '';



PROMPT *** Create  grants  SB_K042 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_K042         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_K042         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_K042.sql =========*** End *** =====
PROMPT ===================================================================================== 
