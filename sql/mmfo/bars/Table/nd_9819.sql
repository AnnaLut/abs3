

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ND_9819.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ND_9819 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ND_9819'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ND_9819'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ND_9819'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ND_9819 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ND_9819 
   (	ND NUMBER(*,0), 
	K_02 NUMBER(*,0), 
	K_03 NUMBER(*,0), 
	K_79 NUMBER(*,0), 
	K_83 NUMBER(*,0), 
	PRIM VARCHAR2(20), 
	BRANCH VARCHAR2(30) DEFAULT SYS_CONTEXT (''bars_context'', ''user_branch''), 
	K_I3 NUMBER(*,0), 
	K_B8 NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ND_9819 ***
 exec bpa.alter_policies('ND_9819');


COMMENT ON TABLE BARS.ND_9819 IS '';
COMMENT ON COLUMN BARS.ND_9819.ND IS '';
COMMENT ON COLUMN BARS.ND_9819.K_02 IS '';
COMMENT ON COLUMN BARS.ND_9819.K_03 IS '';
COMMENT ON COLUMN BARS.ND_9819.K_79 IS '';
COMMENT ON COLUMN BARS.ND_9819.K_83 IS '';
COMMENT ON COLUMN BARS.ND_9819.PRIM IS '';
COMMENT ON COLUMN BARS.ND_9819.BRANCH IS 'Бранч сховища';
COMMENT ON COLUMN BARS.ND_9819.K_I3 IS '';
COMMENT ON COLUMN BARS.ND_9819.K_B8 IS '';



PROMPT *** Create  grants  ND_9819 ***
grant SELECT                                                                 on ND_9819         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ND_9819         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ND_9819         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ND_9819         to START1;
grant SELECT                                                                 on ND_9819         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ND_9819.sql =========*** End *** =====
PROMPT ===================================================================================== 
