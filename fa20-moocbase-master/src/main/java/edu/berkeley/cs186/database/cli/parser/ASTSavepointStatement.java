/* Generated By:JJTree: Do not edit this line. ASTSavepointStatement.java Version 7.0 */
/* JavaCCOptions:MULTI=true,NODE_USES_PARSER=false,VISITOR=true,TRACK_TOKENS=false,NODE_PREFIX=AST,NODE_EXTENDS=,NODE_FACTORY=,SUPPORT_CLASS_VISIBILITY_PUBLIC=true */
package edu.berkeley.cs186.database.cli.parser;

public
class ASTSavepointStatement extends SimpleNode {
  public ASTSavepointStatement(int id) {
    super(id);
  }

  public ASTSavepointStatement(MoocParser p, int id) {
    super(p, id);
  }

  /** Accept the visitor. **/
  public void jjtAccept(MoocParserVisitor visitor, Object data) {
    visitor.visit(this, data);
  }
}
/* JavaCC - OriginalChecksum=1e6635af743a1649c5f5b1ec9a5bd672 (do not edit this line) */
