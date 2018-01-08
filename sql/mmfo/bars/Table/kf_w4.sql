

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KF_W4.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KF_W4 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KF_W4 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KF_W4 
   (	KF NUMBER, 
	CODEW4 CHAR(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KF_W4 ***
 exec bpa.alter_policies('KF_W4');


COMMENT ON TABLE BARS.KF_W4 IS '';
COMMENT ON COLUMN BARS.KF_W4.KF IS '';
COMMENT ON COLUMN BARS.KF_W4.CODEW4 IS '';



PROMPT *** Create  grants  KF_W4 ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on KF_W4           to BARS_ACCESS_DEFROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on KF_W4           to BARS_CONNECT;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on KF_W4           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KF_W4.sql =========*** End *** =======
PROMPT ===================================================================================== 
