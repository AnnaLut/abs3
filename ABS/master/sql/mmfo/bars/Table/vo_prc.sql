

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VO_PRC.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VO_PRC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VO_PRC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''VO_PRC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''VO_PRC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VO_PRC ***
begin 
  execute immediate '
  CREATE TABLE BARS.VO_PRC 
   (	TVBV CHAR(5), 
	KODBAR CHAR(3), 
	KODASVO CHAR(3), 
	SHKALA NUMBER(8,2), 
	DATPRC DATE, 
	PERCN NUMBER(6,2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VO_PRC ***
 exec bpa.alter_policies('VO_PRC');


COMMENT ON TABLE BARS.VO_PRC IS '';
COMMENT ON COLUMN BARS.VO_PRC.TVBV IS '';
COMMENT ON COLUMN BARS.VO_PRC.KODBAR IS '';
COMMENT ON COLUMN BARS.VO_PRC.KODASVO IS '';
COMMENT ON COLUMN BARS.VO_PRC.SHKALA IS '';
COMMENT ON COLUMN BARS.VO_PRC.DATPRC IS '';
COMMENT ON COLUMN BARS.VO_PRC.PERCN IS '';



PROMPT *** Create  grants  VO_PRC ***
grant SELECT                                                                 on VO_PRC          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VO_PRC          to BARS_DM;
grant SELECT                                                                 on VO_PRC          to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on VO_PRC          to VO_PRC;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VO_PRC          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VO_PRC.sql =========*** End *** ======
PROMPT ===================================================================================== 
