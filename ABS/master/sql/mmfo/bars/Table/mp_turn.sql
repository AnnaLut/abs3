

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MP_TURN.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MP_TURN ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MP_TURN ***
begin 
  execute immediate '
  CREATE TABLE BARS.MP_TURN 
   (	DAT DATE, 
	NLSA VARCHAR2(15), 
	NLSB VARCHAR2(15), 
	SUMMA NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MP_TURN ***
 exec bpa.alter_policies('MP_TURN');


COMMENT ON TABLE BARS.MP_TURN IS '';
COMMENT ON COLUMN BARS.MP_TURN.DAT IS '';
COMMENT ON COLUMN BARS.MP_TURN.NLSA IS '';
COMMENT ON COLUMN BARS.MP_TURN.NLSB IS '';
COMMENT ON COLUMN BARS.MP_TURN.SUMMA IS '';



PROMPT *** Create  grants  MP_TURN ***
grant SELECT                                                                 on MP_TURN         to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on MP_TURN         to BARS_ACCESS_DEFROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on MP_TURN         to MVO;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on MP_TURN         to START1;
grant SELECT                                                                 on MP_TURN         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MP_TURN.sql =========*** End *** =====
PROMPT ===================================================================================== 
