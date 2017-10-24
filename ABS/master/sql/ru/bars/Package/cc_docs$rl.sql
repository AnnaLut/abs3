
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/cc_docs$rl.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CC_DOCS$RL as
  PROCEDURE blob_update (
    "pk_ADDS" IN NUMBER,
    "pk_ID" IN VARCHAR2,
    "pk_ND" IN NUMBER,
    "pk_VERSION" IN DATE,
    col_id$ IN NUMBER,
    operation$ IN VARCHAR2,
    offset$ IN NUMBER,
    old_range$ IN BLOB,
    old_length$ IN NUMBER,
    new_range$ IN BLOB,
    flag$ IN RAW,
    propagation_flag$ IN CHAR);
  PROCEDURE clob_update (
    "pk_ADDS" IN NUMBER,
    "pk_ID" IN VARCHAR2,
    "pk_ND" IN NUMBER,
    "pk_VERSION" IN DATE,
    col_id$ IN NUMBER,
    operation$ IN VARCHAR2,
    offset$ IN NUMBER,
    old_range$ IN CLOB,
    old_length$ IN NUMBER,
    new_range$ IN CLOB,
    flag$ IN RAW,
    propagation_flag$ IN CHAR);
  PROCEDURE nclob_update (
    "pk_ADDS" IN NUMBER,
    "pk_ID" IN VARCHAR2,
    "pk_ND" IN NUMBER,
    "pk_VERSION" IN DATE,
    col_id$ IN NUMBER,
    operation$ IN VARCHAR2,
    offset$ IN NUMBER,
    old_range$ IN NCLOB,
    old_length$ IN NUMBER,
    new_range$ IN NCLOB,
    flag$ IN RAW,
    propagation_flag$ IN CHAR);
end "CC_DOCS$RL";
/
CREATE OR REPLACE PACKAGE BODY BARS.CC_DOCS$RL as
  PROCEDURE blob_update (
    "pk_ADDS" IN NUMBER,
    "pk_ID" IN VARCHAR2,
    "pk_ND" IN NUMBER,
    "pk_VERSION" IN DATE,
    col_id$ IN NUMBER,
    operation$ IN VARCHAR2,
    offset$ IN NUMBER,
    old_range$ IN BLOB,
    old_length$ IN NUMBER,
    new_range$ IN BLOB,
    flag$ IN RAW,
    propagation_flag$ IN CHAR) IS
  BEGIN
    DBMS_REPCAT_INTERNAL_PACKAGE.CALL(
      'BARS','CC_DOCS','BLOB_UPDATE',12);
    DBMS_REPCAT_INTERNAL_PACKAGE.NUMBER_ARG( "pk_ADDS");
    DBMS_REPCAT_INTERNAL_PACKAGE.VARCHAR2_ARG( "pk_ID");
    DBMS_REPCAT_INTERNAL_PACKAGE.NUMBER_ARG( "pk_ND");
    DBMS_REPCAT_INTERNAL_PACKAGE.DATE_ARG( "pk_VERSION");
    DBMS_REPCAT_INTERNAL_PACKAGE.NUMBER_ARG(col_id$);
    DBMS_REPCAT_INTERNAL_PACKAGE.VARCHAR2_ARG(operation$);
    DBMS_REPCAT_INTERNAL_PACKAGE.NUMBER_ARG(offset$);
    DBMS_REPCAT_INTERNAL_PACKAGE.BLOB_ARG(old_range$);
    DBMS_REPCAT_INTERNAL_PACKAGE.NUMBER_ARG(old_length$);
    DBMS_REPCAT_INTERNAL_PACKAGE.BLOB_ARG(new_range$);
    DBMS_REPCAT_INTERNAL_PACKAGE.RAW_ARG(flag$);
    DBMS_REPCAT_INTERNAL_PACKAGE.CHAR_ARG(propagation_flag$);
  END BLOB_UPDATE;
  PROCEDURE clob_update (
    "pk_ADDS" IN NUMBER,
    "pk_ID" IN VARCHAR2,
    "pk_ND" IN NUMBER,
    "pk_VERSION" IN DATE,
    col_id$ IN NUMBER,
    operation$ IN VARCHAR2,
    offset$ IN NUMBER,
    old_range$ IN CLOB,
    old_length$ IN NUMBER,
    new_range$ IN CLOB,
    flag$ IN RAW,
    propagation_flag$ IN CHAR) IS
  BEGIN
    DBMS_REPCAT_INTERNAL_PACKAGE.CALL(
      'BARS','CC_DOCS','CLOB_UPDATE',12);
    DBMS_REPCAT_INTERNAL_PACKAGE.NUMBER_ARG( "pk_ADDS");
    DBMS_REPCAT_INTERNAL_PACKAGE.VARCHAR2_ARG( "pk_ID");
    DBMS_REPCAT_INTERNAL_PACKAGE.NUMBER_ARG( "pk_ND");
    DBMS_REPCAT_INTERNAL_PACKAGE.DATE_ARG( "pk_VERSION");
    DBMS_REPCAT_INTERNAL_PACKAGE.NUMBER_ARG(col_id$);
    DBMS_REPCAT_INTERNAL_PACKAGE.VARCHAR2_ARG(operation$);
    DBMS_REPCAT_INTERNAL_PACKAGE.NUMBER_ARG(offset$);
    DBMS_REPCAT_INTERNAL_PACKAGE.CLOB_ARG(old_range$);
    DBMS_REPCAT_INTERNAL_PACKAGE.NUMBER_ARG(old_length$);
    DBMS_REPCAT_INTERNAL_PACKAGE.CLOB_ARG(new_range$);
    DBMS_REPCAT_INTERNAL_PACKAGE.RAW_ARG(flag$);
    DBMS_REPCAT_INTERNAL_PACKAGE.CHAR_ARG(propagation_flag$);
  END CLOB_UPDATE;
  PROCEDURE nclob_update (
    "pk_ADDS" IN NUMBER,
    "pk_ID" IN VARCHAR2,
    "pk_ND" IN NUMBER,
    "pk_VERSION" IN DATE,
    col_id$ IN NUMBER,
    operation$ IN VARCHAR2,
    offset$ IN NUMBER,
    old_range$ IN NCLOB,
    old_length$ IN NUMBER,
    new_range$ IN NCLOB,
    flag$ IN RAW,
    propagation_flag$ IN CHAR) IS
  BEGIN
    DBMS_REPCAT_INTERNAL_PACKAGE.CALL(
      'BARS','CC_DOCS','NCLOB_UPDATE',12);
    DBMS_REPCAT_INTERNAL_PACKAGE.NUMBER_ARG( "pk_ADDS");
    DBMS_REPCAT_INTERNAL_PACKAGE.VARCHAR2_ARG( "pk_ID");
    DBMS_REPCAT_INTERNAL_PACKAGE.NUMBER_ARG( "pk_ND");
    DBMS_REPCAT_INTERNAL_PACKAGE.DATE_ARG( "pk_VERSION");
    DBMS_REPCAT_INTERNAL_PACKAGE.NUMBER_ARG(col_id$);
    DBMS_REPCAT_INTERNAL_PACKAGE.VARCHAR2_ARG(operation$);
    DBMS_REPCAT_INTERNAL_PACKAGE.NUMBER_ARG(offset$);
    DBMS_REPCAT_INTERNAL_PACKAGE.CLOB_ARG(old_range$);
    DBMS_REPCAT_INTERNAL_PACKAGE.NUMBER_ARG(old_length$);
    DBMS_REPCAT_INTERNAL_PACKAGE.CLOB_ARG(new_range$);
    DBMS_REPCAT_INTERNAL_PACKAGE.RAW_ARG(flag$);
    DBMS_REPCAT_INTERNAL_PACKAGE.CHAR_ARG(propagation_flag$);
  END NCLOB_UPDATE;
end "CC_DOCS$RL";
/
 show err;
 
PROMPT *** Create  grants  CC_DOCS$RL ***
grant EXECUTE                                                                on CC_DOCS$RL      to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/cc_docs$rl.sql =========*** End *** 
 PROMPT ===================================================================================== 
 