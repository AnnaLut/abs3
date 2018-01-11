

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAS_1.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAS_1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAS_1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ZAS_1'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ZAS_1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAS_1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAS_1 
   (	ND VARCHAR2(11), 
	VAL CHAR(7), 
	VID NUMBER(*,0), 
	NLS NUMBER(16,0), 
	NBS NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAS_1 ***
 exec bpa.alter_policies('ZAS_1');


COMMENT ON TABLE BARS.ZAS_1 IS '';
COMMENT ON COLUMN BARS.ZAS_1.ND IS '';
COMMENT ON COLUMN BARS.ZAS_1.VAL IS '';
COMMENT ON COLUMN BARS.ZAS_1.VID IS '';
COMMENT ON COLUMN BARS.ZAS_1.NLS IS '';
COMMENT ON COLUMN BARS.ZAS_1.NBS IS '';



PROMPT *** Create  grants  ZAS_1 ***
grant SELECT                                                                 on ZAS_1           to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAS_1           to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAS_1           to START1;
grant SELECT                                                                 on ZAS_1           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAS_1.sql =========*** End *** =======
PROMPT ===================================================================================== 
