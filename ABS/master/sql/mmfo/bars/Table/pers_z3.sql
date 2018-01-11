

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PERS_Z3.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PERS_Z3 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PERS_Z3'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PERS_Z3'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PERS_Z3'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PERS_Z3 ***
begin 
  execute immediate '
  CREATE TABLE BARS.PERS_Z3 
   (	ID1 CHAR(1), 
	ID2 CHAR(1), 
	N NUMBER, 
	S NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PERS_Z3 ***
 exec bpa.alter_policies('PERS_Z3');


COMMENT ON TABLE BARS.PERS_Z3 IS '';
COMMENT ON COLUMN BARS.PERS_Z3.ID1 IS '';
COMMENT ON COLUMN BARS.PERS_Z3.ID2 IS '';
COMMENT ON COLUMN BARS.PERS_Z3.N IS '';
COMMENT ON COLUMN BARS.PERS_Z3.S IS '';



PROMPT *** Create  grants  PERS_Z3 ***
grant SELECT                                                                 on PERS_Z3         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PERS_Z3         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PERS_Z3         to START1;
grant SELECT                                                                 on PERS_Z3         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PERS_Z3.sql =========*** End *** =====
PROMPT ===================================================================================== 
