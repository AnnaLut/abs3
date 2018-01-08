

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MOPER.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MOPER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MOPER'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MOPER'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MOPER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MOPER ***
begin 
  execute immediate '
  CREATE TABLE BARS.MOPER 
   (	REF NUMBER(*,0), 
	NLS VARCHAR2(15), 
	NLSK VARCHAR2(15), 
	NLSF VARCHAR2(15), 
	S NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MOPER ***
 exec bpa.alter_policies('MOPER');


COMMENT ON TABLE BARS.MOPER IS '';
COMMENT ON COLUMN BARS.MOPER.REF IS '';
COMMENT ON COLUMN BARS.MOPER.NLS IS '';
COMMENT ON COLUMN BARS.MOPER.NLSK IS '';
COMMENT ON COLUMN BARS.MOPER.NLSF IS '';
COMMENT ON COLUMN BARS.MOPER.S IS '';



PROMPT *** Create  grants  MOPER ***
grant SELECT                                                                 on MOPER           to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on MOPER           to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on MOPER           to START1;
grant SELECT                                                                 on MOPER           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MOPER.sql =========*** End *** =======
PROMPT ===================================================================================== 
