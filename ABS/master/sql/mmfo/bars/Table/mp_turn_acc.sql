

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MP_TURN_ACC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MP_TURN_ACC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MP_TURN_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.MP_TURN_ACC 
   (	NLSA VARCHAR2(15), 
	KVA NUMBER(3,0), 
	NLSB VARCHAR2(15), 
	KVB NUMBER(3,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MP_TURN_ACC ***
 exec bpa.alter_policies('MP_TURN_ACC');


COMMENT ON TABLE BARS.MP_TURN_ACC IS '';
COMMENT ON COLUMN BARS.MP_TURN_ACC.NLSA IS '';
COMMENT ON COLUMN BARS.MP_TURN_ACC.KVA IS '';
COMMENT ON COLUMN BARS.MP_TURN_ACC.NLSB IS '';
COMMENT ON COLUMN BARS.MP_TURN_ACC.KVB IS '';




PROMPT *** Create  index PK_MPTURNACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MPTURNACC ON BARS.MP_TURN_ACC (NLSA, NLSB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MP_TURN_ACC ***
grant SELECT                                                                 on MP_TURN_ACC     to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on MP_TURN_ACC     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MP_TURN_ACC     to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on MP_TURN_ACC     to MVO;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on MP_TURN_ACC     to START1;
grant SELECT                                                                 on MP_TURN_ACC     to UPLD;
grant FLASHBACK,SELECT                                                       on MP_TURN_ACC     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MP_TURN_ACC.sql =========*** End *** =
PROMPT ===================================================================================== 
