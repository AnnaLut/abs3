

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_PS856.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_PS856 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_PS856'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_PS856'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_PS856'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_PS856 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_PS856 
   (	P080 CHAR(4), 
	S080 CHAR(4), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	COD_ACT CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SB_PS856 ***
 exec bpa.alter_policies('SB_PS856');


COMMENT ON TABLE BARS.SB_PS856 IS '';
COMMENT ON COLUMN BARS.SB_PS856.P080 IS '';
COMMENT ON COLUMN BARS.SB_PS856.S080 IS '';
COMMENT ON COLUMN BARS.SB_PS856.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_PS856.D_CLOSE IS '';
COMMENT ON COLUMN BARS.SB_PS856.COD_ACT IS '';



PROMPT *** Create  grants  SB_PS856 ***
grant SELECT                                                                 on SB_PS856        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_PS856        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SB_PS856        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_PS856        to START1;
grant SELECT                                                                 on SB_PS856        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_PS856.sql =========*** End *** ====
PROMPT ===================================================================================== 
