

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_OB40.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_OB40 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_OB40'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_OB40'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_OB40'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_OB40 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_OB40 
   (	OB40 CHAR(2), 
	NAZVA VARCHAR2(100), 
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




PROMPT *** ALTER_POLICIES to SB_OB40 ***
 exec bpa.alter_policies('SB_OB40');


COMMENT ON TABLE BARS.SB_OB40 IS '';
COMMENT ON COLUMN BARS.SB_OB40.OB40 IS '';
COMMENT ON COLUMN BARS.SB_OB40.NAZVA IS '';
COMMENT ON COLUMN BARS.SB_OB40.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_OB40.D_CLOSE IS '';



PROMPT *** Create  grants  SB_OB40 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_OB40         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SB_OB40         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_OB40         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_OB40.sql =========*** End *** =====
PROMPT ===================================================================================== 
