

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_OB41.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_OB41 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_OB41'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_OB41'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_OB41'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_OB41 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_OB41 
   (	OB41 CHAR(4), 
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




PROMPT *** ALTER_POLICIES to SB_OB41 ***
 exec bpa.alter_policies('SB_OB41');


COMMENT ON TABLE BARS.SB_OB41 IS '';
COMMENT ON COLUMN BARS.SB_OB41.OB41 IS '';
COMMENT ON COLUMN BARS.SB_OB41.NAZVA IS '';
COMMENT ON COLUMN BARS.SB_OB41.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_OB41.D_CLOSE IS '';



PROMPT *** Create  grants  SB_OB41 ***
grant SELECT                                                                 on SB_OB41         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_OB41         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SB_OB41         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_OB41         to START1;
grant SELECT                                                                 on SB_OB41         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_OB41.sql =========*** End *** =====
PROMPT ===================================================================================== 
